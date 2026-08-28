update "line-up"
set result = (
    with ending as (
        select case
            when number % 100 / 10 = 1 then 'th'
            when number % 10 = 1 then 'st'
            when number % 10 = 2 then 'nd'
            when number % 10 = 3 then 'rd'
            else 'th'
        end as ending        
    )
    select name || ', you are the ' || number || ending || ' customer we serve today. Thank you!'
    from ending
)