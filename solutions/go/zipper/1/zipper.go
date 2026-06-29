package zipper

import "errors"

type Node struct {
	value int
	left  *Node
	right *Node
}

type Zipper struct {
	tree  *Node
	steps []string
}

func cloneSteps(steps []string) []string {
	out := make([]string, len(steps))
	copy(out, steps)
	return out
}

func cloneNode(node *Node) *Node {
	return &Node{value: node.value, left: node.left, right: node.right}
}

func (z Zipper) cloneToFocus() *Node {
	tree := cloneNode(z.tree)
	focus := tree

	for _, step := range z.steps {
		switch step {
		case "left":
			focus.left = cloneNode(focus.left)
			focus = focus.left
		case "right":
			focus.right = cloneNode(focus.right)
			focus = focus.right
		}
	}

	return tree
}

func NewZipper(tree *Node) Zipper {
	return Zipper{tree: tree, steps: nil}
}

func (z Zipper) Value() int {
	return z.focus().value
}

func (z Zipper) ToTree() *Node {
	return z.tree
}

func (z Zipper) Left() (Zipper, error) {
	focus := z.focus()
	if focus.left == nil {
		return Zipper{}, errors.New("left child does not exist")
	}

	steps := cloneSteps(z.steps)
	steps = append(steps, "left")
	return Zipper{tree: z.tree, steps: steps}, nil
}

func (z Zipper) Right() (Zipper, error) {
	focus := z.focus()
	if focus.right == nil {
		return Zipper{}, errors.New("right child does not exist")
	}

	steps := cloneSteps(z.steps)
	steps = append(steps, "right")
	return Zipper{tree: z.tree, steps: steps}, nil
}

func (z Zipper) Up() (Zipper, error) {
	if len(z.steps) == 0 {
		return Zipper{}, errors.New("already at root")
	}

	steps := cloneSteps(z.steps[:len(z.steps)-1])
	return Zipper{tree: z.tree, steps: steps}, nil
}

func (z Zipper) SetValue(v int) Zipper {
	tree := z.cloneToFocus()
	z.traverse(tree, z.steps).value = v
	return Zipper{tree: tree, steps: cloneSteps(z.steps)}
}

func (z Zipper) SetLeft(v *Node) Zipper {
	tree := z.cloneToFocus()
	z.traverse(tree, z.steps).left = v
	return Zipper{tree: tree, steps: cloneSteps(z.steps)}
}

func (z Zipper) SetRight(v *Node) Zipper {
	tree := z.cloneToFocus()
	z.traverse(tree, z.steps).right = v
	return Zipper{tree: tree, steps: cloneSteps(z.steps)}
}

func (z Zipper) traverse(tree *Node, steps []string) *Node {
	node := tree
	for _, step := range steps {
		switch step {
		case "left":
			node = node.left
		case "right":
			node = node.right
		}
	}
	return node
}

func (z Zipper) focus() *Node {
	return z.traverse(z.tree, z.steps)
}