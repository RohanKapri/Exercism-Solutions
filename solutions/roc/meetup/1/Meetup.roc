module [meetup]
import isodate.Date exposing [to_iso_str, from_ymd, weekday, days_in_month]

Week : [First, Second, Third, Fourth, Last, Teenth]
DayOfWeek : [Sunday, Monday, Tuesday, Wednesday, Thursday, Friday, Saturday]

meetup : { year : I64, month : U8, week : Week, day_of_week : DayOfWeek } -> Result Str _
meetup = |{ year, month, week, day_of_week }|
    output_str = |res|
        res |> Result.map_ok(|dom| from_ymd(year, month, dom) |> to_iso_str)

    target_dow = to_iso(day_of_week)
    days =
        List.range({ start: At 1, end: At days_in_month(year, month) })
        |> List.keep_if(|dom| weekday(year, month, dom) == target_dow)
    when week is
        First ->
            days |> List.first |> output_str

        Second ->
            days |> List.get(1) |> output_str

        Third ->
            days |> List.get(2) |> output_str

        Fourth ->
            days |> List.get(3) |> output_str

        Last ->
            days |> List.last |> output_str

        Teenth ->
            days |> List.find_first(|dom| dom > 12) |> output_str

to_iso = |dow|
    when dow is
        Sunday -> 0
        Monday -> 1
        Tuesday -> 2
        Wednesday -> 3
        Thursday -> 4
        Friday -> 5
        Saturday -> 6