GradeSchool := Dict Str U8.{
	Student : { name : Str, grade : U8 },

	empty : GradeSchool,
	empty = @GradeSchool(Dict.empty({})),

	add : GradeSchool, List Student -> { results : List [Accepted, Rejected], updated_school : GradeSchool },
	add = |@GradeSchool(school_dict), new_student_grade_pairs| {
		initial_state = {
			results: [],
			current_dict: school_dict,
		}

		final_state =
			List.walk(
				new_student_grade_pairs,
				initial_state,
				|state, student|
					if Dict.contains(state.current_dict, student.name) then
						{
							results: List.append(state.results, Rejected),
							current_dict: state.current_dict,
						}
					else
						{
							results: List.append(state.results, Accepted),
							current_dict: Dict.insert(state.current_dict, student.name, student.grade),
						},
			)

		{
			results: final_state.results,
			updated_school: @GradeSchool(final_state.current_dict),
		}
	},

	roster : GradeSchool -> List Str,
	roster = |@GradeSchool(school_dict)| {
		Dict.to_list(school_dict)
		|> List.sort_with(
			|\(name_a, grade_a), \(name_b, grade_b)|
				when Num.compare(grade_a, grade_b) is
					LT -> LT
					GT -> GT
					EQ -> Str.compare(name_a, name_b),
		)
		|> List.map(\(name, _grade) -> name)
	},

	grade : GradeSchool, U8 -> List Str,
	grade = |@GradeSchool(school_dict), target_grade| {
		Dict.to_list(school_dict)
		|> List.keep_if(\(_name, g) -> g == target_grade)
		|> List.map(\(name, _grade) -> name)
		|> List.sort_with(Str.compare)
	},
}