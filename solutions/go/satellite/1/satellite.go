package satellite

import (
	"errors"
	"reflect"
)

type Node struct {
	Value string
	Left  *Node
	Right *Node
}

func TreeFromTraversals(preorder, inorder []string) (*Node, error) {
	if len(preorder) != len(inorder) {
		return nil, errors.New("traversals must have the same length")
	}

	preCounts := make(map[string]int, len(preorder))
	inCounts := make(map[string]int, len(inorder))
	for _, item := range preorder {
		preCounts[item]++
	}
	for _, item := range inorder {
		inCounts[item]++
	}

	if len(preCounts) != len(preorder) {
		return nil, errors.New("traversals must contain unique items")
	}

	if !reflect.DeepEqual(preCounts, inCounts) {
		return nil, errors.New("traversals must have the same elements")
	}

	var build func(pre, ino []string) *Node
	build = func(pre, ino []string) *Node {
		if len(pre) == 0 {
			return nil
		}

		value := pre[0]
		leftCount := -1
		for i, v := range ino {
			if v == value {
				leftCount = i
				break
			}
		}

		if leftCount == -1 {
			return nil
		}

		return &Node{
			Value: value,
			Left:  build(pre[1:leftCount+1], ino[:leftCount]),
			Right: build(pre[leftCount+1:], ino[leftCount+1:]),
		}
	}

	return build(preorder, inorder), nil
}