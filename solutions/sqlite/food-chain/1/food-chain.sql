update "food-chain"
set result = (
    with
    verses (num, animal, intro, outro) as (
        values
        (8, 'horse', 'She''s dead, of course!', null),
        (7, 'cow', 'I don''t know how she swallowed a cow!', 'She swallowed the cow to catch the goat.'),
        (6, 'goat', 'Just opened her throat and swallowed a goat!', 'She swallowed the goat to catch the dog.'),
        (5, 'dog', 'What a hog, to swallow a dog!', 'She swallowed the dog to catch the cat.'),
        (4, 'cat', 'Imagine that, to swallow a cat!', 'She swallowed the cat to catch the bird.'),
        (3, 'bird', 'How absurd to swallow a bird!', 'She swallowed the bird to catch the spider that wriggled and jiggled and tickled inside her.'),
        (2, 'spider', 'It wriggled and jiggled and tickled inside her.', 'She swallowed the spider to catch the fly.'),
        (1, 'fly', null, 'I don''t know why she swallowed the fly. Perhaps she''ll die.')
    ),
    lines as (
        select value, (
            select group_concat(line, char(10))
            from (
                select 'I know an old lady who swallowed a ' || animal || '.' as line
                from verses where num = para.value
                union all
                select intro
                from verses where num = para.value
                union all
                select group_concat(outro, char(10)) || iif(para.value = 8, null, '')
                from verses where num <= para.value
                )
            ) as verse
        from generate_series(start_verse, end_verse) para
    )
    select group_concat(verse, char(10) || char(10))
    from lines
    order by value
);