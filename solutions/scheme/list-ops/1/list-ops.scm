(define (my-reverse l)
  (let loop ((l l)
             (acc '()))
    (if (null? l)
        acc
        (loop (cdr l) (cons (car l) acc)))))

(define (my-append list1 list2)
  (let loop ((l (my-reverse list1))
             (acc list2))
    (if (null? l)
        acc
        (loop (cdr l) (cons (car l) acc)))))

(define (my-concatenate lists)
  (let loop ((l (my-reverse lists))
             (acc '()))
    (if (null? l)
        acc
        (loop (cdr l) (my-append (car l) acc)))))

(define (my-filter f l)
  (let loop ((l (my-reverse l))
             (acc '()))
    (cond
      ((null? l)
        acc)
      ((f (car l))
        (loop (cdr l) (cons (car l) acc)))
      (else
        (loop (cdr l) acc)))))

(define (my-length l)
  (let loop ((l l)
             (acc 0))
    (if (null? l)
        acc
        (loop (cdr l) (+ acc 1)))))

(define (my-map f l)
  (let loop ((l (my-reverse l))
             (acc '()))
    (if (null? l)
        acc
        (loop (cdr l) (cons (f (car l)) acc)))))

(define (my-foldl f acc l)
  (let loop ((acc acc)
             (l l))
    (if (null? l)
        acc
        (loop (f (car l) acc) (cdr l)))))

(define (my-foldr f acc l)
  (let loop ((l (my-reverse l))
             (acc acc))
    (if (null? l)
        acc
        (loop (cdr l) (f (car l) acc)))))