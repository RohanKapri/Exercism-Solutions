(import (rnrs))

(define (score x y)
  (let ((s (+ (* x x) (* y y))))
    (cond
     ((<= s 1.0) 10)
     ((<= s 25.0) 5)
     ((<= s 100.0) 1)
     (else 0))))