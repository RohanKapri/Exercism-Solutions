update "grade-school"
set result = (
    with
    students as (
        select key, value->>0 as name, value->>1 as grade
        from json_each(input->'$.students')
    ),
    checked_students as (
        select key, name, grade, lag(name) over previous_names is null as valid
        from students
        window previous_names as 
            (partition by name order by key
             range between unbounded preceding and 1 preceding)
    )
    select case property
        when 'grade' then (
            select json_group_array(name)
            from checked_students
            where valid and grade = input->>'$.desiredGrade'
        )
        when 'add' then (
            select json_group_array(json(iif(valid, 'true', 'false')))
            from checked_students
        )
        when 'roster' then (
            select json_group_array(distinct name order by grade, name)
            from students 
        )
    end
);