USING: kernel math ;
IN: difference-of-squares

:: square-of-sum ( n -- m )
    n 1 +
    n *
    2 /
    sq ;

:: sum-of-squares ( n -- m )
    n
    n 1 +
    n n 1 + +
    * *
    6 / ;

:: difference-of-squares ( n -- m )
    n square-of-sum
    n sum-of-squares
    - ;