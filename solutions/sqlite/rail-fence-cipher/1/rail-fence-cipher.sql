update "rail-fence-cipher"
set result = (
    with recursive
    path(row, dir, i, char) as (
        select 1, 1, 1, substr(msg, 1, 1)
        union all
        select iif(row + dir > rails or row + dir < 1, row - dir, row + dir),
            iif(row + dir > rails or row + dir < 1, dir * -1, dir),
            i + 1,
            substr(msg, i + 1, 1)
        from path
        where substr(msg, i + 1, 1) != ''
    ),
    encrypt as (
        select group_concat(row, '') as code
        from (
            select group_concat(char, '') as row
            from path
            group by row
        )
    ),
    decrypt1 as (
        select row_number() over (partition by row order by i) as col, row, i
        from path
        order by row, col
    ),
    decrypt2 as (
        select substr(msg, row_number() over (), 1) as char
        from decrypt1
        order by i
    ),
    decrypt3 as (
        select group_concat(char, '') as text
        from decrypt2
    )
    select iif(property = 'encode', (select code from encrypt), (select text from decrypt3))
);