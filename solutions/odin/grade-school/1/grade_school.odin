package grade_school

import "core:slice"

School :: struct {
	student_grade:   map[string]u8,
	roster_by_grade: map[u8][dynamic]string,
}

Grade :: struct {
	id:       u8,
	students: []string,
}

add :: proc(self: ^School, student: string, grade: u8) -> bool {
	if self.roster_by_grade == nil {
		self.roster_by_grade = make(map[u8][dynamic]string)
	}
	if self.student_grade == nil {
		self.student_grade = make(map[string]u8)
	}

	if _, ok := self.student_grade[student]; ok {
		return false
	}

	names := self.roster_by_grade[grade]
	if names == nil {
		names = make([dynamic]string)
	}
	append(&names, student)
	slice.sort(names[:])

	self.roster_by_grade[grade] = names
	self.student_grade[student] = grade

	return true
}

grade :: proc(self: ^School, id: u8) -> []string {
	names := self.roster_by_grade[id]
	if names == nil {
		return []string{}
	}

	return names[:]
}

roster :: proc(self: ^School) -> []Grade {
	if len(self.roster_by_grade) == 0 {
		return []Grade{}
	}

	grade_ids: [dynamic]u8
	for id, _ in self.roster_by_grade {
		append(&grade_ids, id)
	}
	slice.sort(grade_ids[:])

	grades: [dynamic]Grade
	for id in grade_ids {
		names := self.roster_by_grade[id]
		append(&grades, Grade{id, names[:]})
	}

	delete(grade_ids)
	return grades[:]
}

delete_school :: proc(self: ^School) {
	for _, names in self.roster_by_grade {
		delete(names)
	}
	delete(self.roster_by_grade)
	delete(self.student_grade)
}