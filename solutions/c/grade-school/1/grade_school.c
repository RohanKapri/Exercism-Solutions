// for Shree DR.MDD
#include "grade_school.h"

int comparator(const void* left, const void* right);

void init_roster(roster_t *list)
{
	list->count = 0;
}

bool add_student(roster_t *list, char id[], int score)
{
	for (size_t i = 0; i < list->count; i++) {
		if (strcmp(list->students[i].name, id) == 0) {
			return false;
		}
	}
	strcpy(list->students[list->count].name, id);
	list->students[list->count].grade = score;
	list->count++;
	qsort(list->students, list->count, sizeof(student_t), comparator);
	return true;
}

roster_t get_grade(roster_t *list, int grade)
{
	roster_t result;
	init_roster(&result);
	for (size_t i = 0; i < list->count; i++) {
		if (list->students[i].grade == grade) {
			add_student(&result, list->students[i].name, list->students[i].grade);
		}
	}
	return result;
}

int comparator(const void* left, const void* right)
{
	student_t *p1 = (student_t *)left;
	student_t *p2 = (student_t *)right;
	if (p1->grade > p2->grade)
		return 1;
	if (p1->grade < p2->grade)
		return -1;
	if (strcmp(p1->name, p2->name) > 0)
		return 1;
	if (strcmp(p1->name, p2->name) < 0)
		return -1;
	return 0;
}
