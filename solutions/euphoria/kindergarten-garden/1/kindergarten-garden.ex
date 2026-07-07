function decode(integer plant)
    if plant = 'G' then
        return "grass"
    elsif plant = 'C' then
        return "clover"
    elsif plant = 'R' then
        return "radishes"
    elsif plant = 'V' then
        return "violets"
    end if

    return ""
end function

public function plants(sequence garden, sequence student)
    sequence students
    integer newline_pos
    sequence row1
    sequence row2
    integer student_pos
    integer cup_pos
    sequence result

    students = {
        "Alice", "Bob", "Charlie", "David",
        "Eve", "Fred", "Ginny", "Harriet",
        "Ileana", "Joseph", "Kincaid", "Larry"
    }

    newline_pos = find('\n', garden)
    row1 = garden[1..newline_pos-1]
    row2 = garden[newline_pos+1..length(garden)]

    student_pos = find(student, students)

    if student_pos = 0 then
        return {}
    end if

    cup_pos = (student_pos - 1) * 2 + 1

    result = {
        decode(row1[cup_pos]),
        decode(row1[cup_pos + 1]),
        decode(row2[cup_pos]),
        decode(row2[cup_pos + 1])
    }

    return result
end function