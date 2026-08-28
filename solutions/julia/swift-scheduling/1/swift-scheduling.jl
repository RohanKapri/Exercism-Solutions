using Dates

function delivery_date(start, description)
    ts = DateTime(start)
    if description == "NOW"
        ts += Hour(2)
    elseif description == "ASAP"
        if hour(ts) < 13
            ts = DateTime(Date(ts), Time(17))
        else
            ts = DateTime(Date(ts) + Day(1), Time(13))
        end
    elseif description == "EOW"
        q = 1 + (dayofweek(ts) in 1:3)
        d = [7, 5][q] - dayofweek(ts)
        t = [20, 17][q]
        ts = DateTime(Date(ts) + Day(d), Time(t))
    elseif endswith(description, 'M')
        m = parse(Int, chop(description))
        ts = DateTime(year(ts) + (month(ts) >= m), m, 1, 8)
        while dayofweek(ts) ∉ 1:5
            ts += Day(1)
        end
    elseif startswith(description, 'Q')
        m = parse(Int, description[begin+1:end])
        q = (month(ts) + 2) ÷ 3
        n = (q > m) + (m == 4)
        m = m % 4 * 3 + 1
        ts = DateTime(year(ts) + n, m, 1, 8) - Day(1)
        while dayofweek(ts) ∉ 1:5
            ts -= Day(1)
        end
    end
    return string(ts)
end