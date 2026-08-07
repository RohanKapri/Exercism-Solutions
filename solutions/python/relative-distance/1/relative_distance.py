"""Determine the degree of separation between two people in a family tree."""

from collections import defaultdict, deque


class RelativeDistance:
    """Represent relationships in a a family tree."""

    def __init__(self, family_tree):
        """Build an undirected graph of family relationships."""
        self.family = defaultdict(set)

        for parent, children in family_tree.items():
            self.family[parent]

            # Parent-child connections
            for child in children:
                self.family[parent].add(child)
                self.family[child].add(parent)

            # Sibling connections
            for index, child_a in enumerate(children):
                for child_b in children[index + 1 :]:
                    self.family[child_a].add(child_b)
                    self.family[child_b].add(child_a)

    def degree_of_separation(self, person_a, person_b):
        """Return the degree of separation between two people."""
        if person_a not in self.family:
            raise ValueError("Person A not in family tree.")

        if person_b not in self.family:
            raise ValueError("Person B not in family tree.")

        if person_a == person_b:
            return 0

        queue = deque([(person_a, 0)])
        visited = {person_a}

        while queue:
            current_person, distance = queue.popleft()

            for relative in self.family[current_person]:
                if relative == person_b:
                    return distance + 1

                if relative not in visited:
                    visited.add(relative)
                    queue.append((relative, distance + 1))

        raise ValueError(
            "No connection between person A and person B."
        )