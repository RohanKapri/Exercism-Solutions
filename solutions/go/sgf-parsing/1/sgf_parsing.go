package sgfparsing

import (
	"errors"
	"strings"
	"unicode"
)

// Node represents an SGF node with properties and child nodes.
type Node struct {
	Properties map[string][]string
	Children   []*Node
}

func normalizeWhitespace(input string) string {
	var out strings.Builder
	out.Grow(len(input))

	for _, r := range input {
		if r != '\n' && unicode.IsSpace(r) {
			out.WriteRune(' ')
		} else {
			out.WriteRune(r)
		}
	}

	return out.String()
}

func parseProperty(s string) (string, []string, string, error) {
	nameEnd := 0
	for nameEnd < len(s) {
		c := s[nameEnd]
		if (c >= 'a' && c <= 'z') || (c >= 'A' && c <= 'Z') {
			nameEnd++
			continue
		}
		break
	}

	name := s[:nameEnd]
	if name != strings.ToUpper(name) {
		return "", nil, "", errors.New("property must be in uppercase")
	}

	s = s[nameEnd:]
	if len(s) == 0 || s[0] != '[' {
		return "", nil, "", errors.New("properties without delimiter")
	}

	values := []string{}
	for len(s) > 0 && s[0] == '[' {
		s = s[1:]
		var value strings.Builder

		for len(s) > 0 && s[0] != ']' {
			if s[0] == '\\' {
				if len(s) < 2 {
					s = s[1:]
					continue
				}
				next := s[1]
				if next != '\n' {
					value.WriteByte(next)
				}
				s = s[1:]
			} else {
				value.WriteByte(s[0])
			}

			s = s[1:]
		}

		if len(s) > 0 {
			s = s[1:]
		}

		values = append(values, normalizeWhitespace(value.String()))
	}

	return name, values, s, nil
}

func parseProperties(s string) (map[string][]string, string, error) {
	properties := map[string][]string{}

	for len(s) > 0 && s[0] != ';' && s[0] != '(' && s[0] != ')' {
		name, values, rest, err := parseProperty(s)
		if err != nil {
			return nil, "", err
		}
		properties[name] = values
		s = rest
	}

	return properties, s, nil
}

func parseNode(s string) (*Node, string, error) {
	s = s[1:]
	properties, rest, err := parseProperties(s)
	if err != nil {
		return nil, "", err
	}
	return &Node{Properties: properties, Children: []*Node{}}, rest, nil
}

func parseTree(s string) (*Node, string, error) {
	if len(s) == 0 || s[0] != '(' {
		return nil, "", errors.New("tree missing")
	}
	s = s[1:]

	if len(s) == 0 || s[0] != ';' {
		return nil, "", errors.New("tree with no nodes")
	}
	s = s[1:]

	properties, s, err := parseProperties(s)
	if err != nil {
		return nil, "", err
	}

	node := &Node{Properties: properties, Children: []*Node{}}

	for {
		if len(s) == 0 {
			break
		}

		switch s[0] {
		case ';':
			child, rest, err := parseNode(s)
			if err != nil {
				return nil, "", err
			}
			node.Children = append(node.Children, child)
			s = rest
		case '(':
			child, rest, err := parseTree(s)
			if err != nil {
				return nil, "", err
			}
			node.Children = append(node.Children, child)
			s = rest
			if len(s) > 0 {
				s = s[1:]
			}
		default:
			return node, s, nil
		}
	}

	return node, s, nil
}

// Parse decodes an SGF string and returns the root node of the tree.
func Parse(encoded string) (*Node, error) {
	root, _, err := parseTree(encoded)
	if err != nil {
		return nil, err
	}
	return root, nil
}