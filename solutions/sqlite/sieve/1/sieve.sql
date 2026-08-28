-- thanks to Timus for coming up with the idea to use two lateral dependent generate_series
update sieve
set result = (
    with notprimes(np) as (
        select nps.value as np
        from generate_series(2, sqrt("limit")) idxs,
             generate_series(idxs.value * 2, "limit", idxs.value) nps
    )
    select coalesce(group_concat(value, ', '), '')
    from generate_series(2, "limit")
    where not exists (select 1 from notprimes where np = value)
);