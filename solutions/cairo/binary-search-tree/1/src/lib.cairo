use core::array::{ArrayTrait, SpanTrait};
use core::box::BoxTrait;

type BinarySearchTree = Option<Box<Node>>;

#[derive(Drop, Copy)]
struct Node {
    value: u32,
    left: BinarySearchTree,
    right: BinarySearchTree,
}

// Insert a value into the BST, returning a new tree (persistent / immutable style).
fn insert(tree: BinarySearchTree, v: u32) -> BinarySearchTree {
    match tree {
        Option::None => {
            Option::Some(BoxTrait::new(Node {
                value: v,
                left: Option::None,
                right: Option::None,
            }))
        },
        Option::Some(b) => {
            // Take ownership of the node, update the side that changes, and re-box.
            let mut node: Node = b.unbox();
            if v <= node.value {
                node.left = insert(node.left, v);
            } else {
                node.right = insert(node.right, v);
            }
            Option::Some(BoxTrait::new(node))
        }
    }
}

// In-order traversal that collects values into `out` (sorted ascending).
fn inorder_collect(tree: @BinarySearchTree, ref out: Array<u32>) {
    match tree {
        Option::None => {},
        Option::Some(b) => {
            let n: Node = (*b).unbox();
            inorder_collect(@n.left, ref out);
            out.append(n.value);
            inorder_collect(@n.right, ref out);
        }
    }
}

#[generate_trait]
pub impl BinarySearchTreeImpl of BinarySearchTreeTrait {
    fn new(tree_data: Span<u32>) -> BinarySearchTree {
        let mut t: BinarySearchTree = Option::None;

        // Iterate the span explicitly by index to avoid moving it.
        let len: usize = tree_data.len();
        let mut i: usize = 0_usize;
        while i < len {
            let v: u32 = *tree_data.at(i);
            t = insert(t, v);
            i += 1_usize;
        };

        t
    }

    fn value(self: @BinarySearchTree) -> Option<u32> {
        match self {
            Option::None => Option::None,
            Option::Some(b) => {
                let n: Node = (*b).unbox();
                Option::Some(n.value)
            }
        }
    }

    fn left(self: @BinarySearchTree) -> @BinarySearchTree {
        match self {
            Option::None => self, // If empty, "left" is still empty.
            Option::Some(b) => {
                let n: Node = (*b).unbox();
                @n.left
            }
        }
    }

    fn right(self: @BinarySearchTree) -> @BinarySearchTree {
        match self {
            Option::None => self, // If empty, "right" is still empty.
            Option::Some(b) => {
                let n: Node = (*b).unbox();
                @n.right
            }
        }
    }

    fn sorted_data(self: @BinarySearchTree) -> Span<u32> {
        let mut out: Array<u32> = ArrayTrait::new();
        inorder_collect(self, ref out);
        out.span()
    }
}
      