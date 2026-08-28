update "binary-search"
set (result, error) = (
    with recursive
    r(r,v) as (
        select array, "value"
    ),
    split(lb, ub, m, hit) as (
        select 0, json_array_length(r) - 1, (json_array_length(r) - 1)/2, null
        from r
        union all
        select iif(r->>m > v, lb, m + 1), iif(r->>m < v, ub, m - 1), iif(r->>m > v, (m - 1 + ub)/2, (lb + m + 1)/2), iif(r->>m = v, m, null)
        from split, r
        where lb <= ub
        and hit is null
    )
    select (select max(hit) from split), iif((select max(hit) from split) is null, 'value not in array', null)
);