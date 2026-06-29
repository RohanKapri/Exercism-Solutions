using Dates

function shared_birthday(birthdates)
    v = (monthday∘Date).(birthdates)
    length(v) != length(unique(v))
end

function random_date()
    y = rand(filter(!isleapyear, 1950:2050))
    Date(y) + Day(rand(0:364))
end

function random_birthdates(groupsize)
    [random_date() for _ in 1:groupsize]
end

function estimate_probability_of_shared_birthday(groupsize)
    N = 10000
    v = [shared_birthday(random_birthdates(groupsize))
        for _ in 1:N]
    sum(v) / N
end