type BinaryTree = Option<Box<BinaryTreeNode>>;

#[derive(Drop, Debug, PartialEq, Copy)]
struct BinaryTreeNode {
    value: u32,
    left: BinaryTree,
    right: BinaryTree,
}

pub impl OptionalBinaryTreeNodePartialEq of PartialEq<Option<Box<BinaryTreeNode>>> {
    fn eq(lhs: @Option<Box<BinaryTreeNode>>, rhs: @Option<Box<BinaryTreeNode>>) -> bool {
        match (lhs, rhs) {
            (Option::Some(lhs), Option::Some(rhs)) => (*lhs).unbox() == (*rhs).unbox(),
            (Option::None, Option::None) => true,
            _ => false,
        }
    }
}

#[generate_trait]
impl NodeImpl of NodeTrait {
    fn set_value(self: BinaryTreeNode, value: u32) -> BinaryTreeNode {
        BinaryTreeNode { value, ..self }
    }

    fn set_left(self: BinaryTreeNode, left: BinaryTree) -> BinaryTreeNode {
        BinaryTreeNode { left, ..self }
    }

    fn set_right(self: BinaryTreeNode, right: BinaryTree) -> BinaryTreeNode {
        BinaryTreeNode { right, ..self }
    }
}

impl NodeIntoBinaryTree of Into<BinaryTreeNode, BinaryTree> {
    fn into(self: BinaryTreeNode) -> BinaryTree {
        Option::Some(BoxTrait::new(self))
    }
}

#[generate_trait]
pub impl BinaryTreeImpl of BinaryTreeTrait {
    fn empty() -> BinaryTree {
        Option::None
    }

    fn new(value: u32, left: BinaryTree, right: BinaryTree) -> BinaryTree {
        Option::Some(BoxTrait::new(BinaryTreeNode { value, left, right }))
    }

    fn leaf(value: u32) -> BinaryTree {
        Self::new(value, Self::empty(), Self::empty())
    }

    fn set_value(self: BinaryTree, value: u32) -> BinaryTree {
        Self::new(value, *self.left(), *self.right())
    }

    fn value(self: @BinaryTree) -> Option<u32> {
        Option::Some((*self)?.value)
    }

    fn left(self: @BinaryTree) -> @BinaryTree {
        @match self {
            Option::None => Option::None,
            Option::Some(bst) => bst.left,
        }
    }

    fn right(self: @BinaryTree) -> @BinaryTree {
        @match self {
            Option::None => Option::None,
            Option::Some(bst) => bst.right,
        }
    }
}

#[derive(Drop, Debug, PartialEq, Clone)]
enum Direction {
    Left,
    Right,
}

#[derive(Drop, Debug, PartialEq, Clone)]
struct Crumb {
    direction: Direction,
    parent_value: u32,
    sibling: BinaryTree,
}

#[derive(Drop, Debug, PartialEq)]
struct Zipper {
    focus: BinaryTree,
    crumbs: Array<Crumb>,
}

#[generate_trait]
pub impl ZipperImpl of ZipperTrait {
    fn from_tree(tree: BinaryTree) -> Option<Zipper> {
        match tree {
            Option::None => Option::None,
            Option::Some(_) => Option::Some(Zipper { focus: tree, crumbs: array![] }),
        }
    }

    fn to_tree(self: Zipper) -> BinaryTree {
        if self.crumbs.is_empty() {
            return self.focus;
        }
        
        let up_zipper = self.up();
        match up_zipper {
            Option::Some(parent) => parent.to_tree(),
            Option::None => panic!("Failed to go up despite having crumbs"),
        }
    }

    fn value(self: @Zipper) -> @u32 {
        match self.focus {
            Option::Some(node) => @node.value,
            Option::None => panic!("Cannot get value of empty tree"),
        }
    }

    fn left(self: Zipper) -> Option<Zipper> {
        match self.focus {
            Option::None => Option::None,
            Option::Some(node) => {
                match node.left {
                    Option::None => Option::None,
                    Option::Some(_) => {
                        let mut new_crumbs = self.crumbs;
                        new_crumbs.append(Crumb {
                            direction: Direction::Left,
                            parent_value: node.value,
                            sibling: node.right,
                        });
                        Option::Some(Zipper { focus: node.left, crumbs: new_crumbs })
                    }
                }
            }
        }
    }

    fn right(self: Zipper) -> Option<Zipper> {
        match self.focus {
            Option::None => Option::None,
            Option::Some(node) => {
                match node.right {
                    Option::None => Option::None,
                    Option::Some(_) => {
                        let mut new_crumbs = self.crumbs;
                        new_crumbs.append(Crumb {
                            direction: Direction::Right,
                            parent_value: node.value,
                            sibling: node.left,
                        });
                        Option::Some(Zipper { focus: node.right, crumbs: new_crumbs })
                    }
                }
            }
        }
    }

    fn up(self: Zipper) -> Option<Zipper> {
        if self.crumbs.is_empty() {
            return Option::None;
        }
        
        let crumbs_len = self.crumbs.len();
        if crumbs_len == 0 {
            return Option::None;
        }
        
        // Get the last crumb (most recent breadcrumb) - LIFO behavior
        let last_index = crumbs_len - 1;
        let crumb = self.crumbs.at(last_index);
        
        // Create new array without the last element (simulate pop_back)
        let mut new_crumbs = array![];
        let mut i = 0;
        while i < last_index {
            new_crumbs.append(self.crumbs.at(i).clone());
            i += 1;
        };
        
        let parent_node = match crumb.direction {
            Direction::Left => BinaryTreeNode {
                value: *crumb.parent_value,
                left: self.focus,
                right: crumb.sibling.clone(),
            },
            Direction::Right => BinaryTreeNode {
                value: *crumb.parent_value,
                left: crumb.sibling.clone(),
                right: self.focus,
            },
        };
        
        Option::Some(Zipper {
            focus: Option::Some(BoxTrait::new(parent_node)),
            crumbs: new_crumbs,
        })
    }

    fn set_value(self: Zipper, value: u32) -> Zipper {
        match self.focus {
            Option::None => self,
            Option::Some(node) => {
                let new_node = BinaryTreeNode {
                    value,
                    left: node.left,
                    right: node.right,
                };
                Zipper {
                    focus: Option::Some(BoxTrait::new(new_node)),
                    crumbs: self.crumbs,
                }
            }
        }
    }

    fn set_left(self: Zipper, left: BinaryTree) -> Zipper {
        match self.focus {
            Option::None => self,
            Option::Some(node) => {
                let new_node = BinaryTreeNode {
                    value: node.value,
                    left,
                    right: node.right,
                };
                Zipper {
                    focus: Option::Some(BoxTrait::new(new_node)),
                    crumbs: self.crumbs,
                }
            }
        }
    }

    fn set_right(self: Zipper, right: BinaryTree) -> Zipper {
        match self.focus {
            Option::None => self,
            Option::Some(node) => {
                let new_node = BinaryTreeNode {
                    value: node.value,
                    left: node.left,
                    right,
                };
                Zipper {
                    focus: Option::Some(BoxTrait::new(new_node)),
                    crumbs: self.crumbs,
                }
            }
        }
    }
}
       