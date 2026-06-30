USING: assocs combinators kernel math sequences ;
IN: rpn-calculator

: add-op ( stack -- new-stack )
    [ 2 head* ] [ last2 + ] bi
    suffix ;

: multiply-op ( stack -- new-stack )
    [ 2 head* ] [ last2 * ] bi
    suffix ;

: apply-op ( stack op -- new-stack )
    call( stack -- new-stack ) ; inline

: evaluate ( stack ops -- final-stack )
    [ apply-op ] each ; inline

: evaluate-named ( stack ops names -- final-stack )
    [ swap at ] with map evaluate ;

ERROR: zero-divisor-error ;

: divide-op ( stack -- new-stack )
    [ 2 head* ] [ last2 dup 0 = [ zero-divisor-error ] when / ] bi
    suffix ;