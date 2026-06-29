package relativedistance

func byChild(familyTree map[string][]string) map[string][]string {
	inverse := make(map[string][]string)
	for parent, children := range familyTree {
		for _, child := range children {
			inverse[child] = append(inverse[child], parent)
		}
	}
	return inverse
}

func ancestry(childToParents map[string][]string, name string) map[string]int {
	result := make(map[string]int)
	queue := []string{name}
	distance := []int{0}

	for len(queue) > 0 {
		current := queue[0]
		count := distance[0]
		queue = queue[1:]
		distance = distance[1:]

		if prev, seen := result[current]; seen && prev <= count {
			continue
		}
		result[current] = count

		for _, parent := range childToParents[current] {
			queue = append(queue, parent)
			distance = append(distance, count+1)
		}
	}

	return result
}

func DegreeOfSeparation(familyTree map[string][]string, personA, personB string) (int, bool) {
	childToParents := byChild(familyTree)
	ancestryA := ancestry(childToParents, personA)
	ancestryB := ancestry(childToParents, personB)

	minimumDegrees := -1
	for ancestor, degreeA := range ancestryA {
		degreeB, ok := ancestryB[ancestor]
		if !ok {
			continue
		}

		degrees := degreeA + degreeB - 1
		if ancestor == personA || ancestor == personB {
			degrees++
		}

		if minimumDegrees == -1 || degrees < minimumDegrees {
			minimumDegrees = degrees
		}
	}

	if minimumDegrees == -1 {
		return 0, false
	}

	return minimumDegrees, true
}