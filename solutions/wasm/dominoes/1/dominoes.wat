(module
  (memory (export "mem") 1)

  ;;
  ;; Determine if the dominoes can form a valid closed chain.
  ;; An Eulerian circuit exists if:
  ;; 1. The degree of every vertex is even.
  ;; 2. All vertices with a degree > 0 belong to the same connected component.
  ;;
  ;; @param {i32} $offset - starting byte address of the domino array in linear memory
  ;; @param {i32} $count  - number of dominoes
  ;;
  ;; @returns {i32} 1 if the dominoes form a chain, 0 otherwise
  ;;
  (func (export "canChain") (param $offset i32) (param $count i32) (result i32)
    (local $i i32)
    (local $left i32)
    (local $right i32)
    (local $addr i32)
    (local $v i32)
    (local $root i32)
    (local $root_u i32)
    (local $root_v i32)

    ;; An empty set of dominoes forms a valid chain vacuously
    (if (i32.eqz (local.get $count))
      (then (return (i32.const 1)))
    )

    ;; Initialize Union-Find structure and Degree tracking in safe high memory region
    ;; Let's use address 1024 for Parent array (256 * 4 bytes)
    ;; Let's use address 2048 for Degree array (256 * 4 bytes)
    (local.set $i (i32.const 0))
    (loop $init_loop
      ;; parent[i] = i
      (i32.store (i32.add (i32.const 1024) (i32.shl (local.get $i) (i32.const 2))) (local.get $i))
      ;; degree[i] = 0
      (i32.store (i32.add (i32.const 2048) (i32.shl (local.get $i) (i32.const 2))) (i32.const 0))
      
      (local.set $i (i32.add (local.get $i) (i32.const 1)))
      (br_if $init_loop (i32.lt_u (local.get $i) (i32.const 256)))
    )

    ;; Loop through all dominoes to accumulate degrees and join components
    (local.set $i (i32.const 0))
    (loop $process_loop
      (local.set $addr (i32.add (local.get $offset) (i32.shl (local.get $i) (i32.const 1))))
      (local.set $left (i32.load8_u (local.get $addr)))
      (local.set $right (i32.load8_u (i32.add (local.get $addr) (i32.const 1))))

      ;; Increment degrees
      ;; degree[left]++
      (local.set $addr (i32.add (i32.const 2048) (i32.shl (local.get $left) (i32.const 2))))
      (i32.store (local.get $addr) (i32.add (i32.load (local.get $addr)) (i32.const 1)))
      ;; degree[right]++
      (local.set $addr (i32.add (i32.const 2048) (i32.shl (local.get $right) (i32.const 2))))
      (i32.store (local.get $addr) (i32.add (i32.load (local.get $addr)) (i32.const 1)))

      ;; Find root of left element
      (local.set $root_u (local.get $left))
      (loop $find_u
        (local.set $v (i32.load (i32.add (i32.const 1024) (i32.shl (local.get $root_u) (i32.const 2)))))
        (if (i32.ne (local.get $root_u) (local.get $v))
          (then
            (local.set $root_u (local.get $v))
            (br $find_u)
          )
        )
      )

      ;; Find root of right element
      (local.set $root_v (local.get $right))
      (loop $find_v
        (local.set $v (i32.load (i32.add (i32.const 1024) (i32.shl (local.get $root_v) (i32.const 2)))))
        (if (i32.ne (local.get $root_v) (local.get $v))
          (then
            (local.set $root_v (local.get $v))
            (br $find_v)
          )
        )
      )

      ;; Union sets if they have different roots
      (if (i32.ne (local.get $root_u) (local.get $root_v))
        (then
          (i32.store (i32.add (i32.const 1024) (i32.shl (local.get $root_u) (i32.const 2))) (local.get $root_v))
        )
      )

      (local.set $i (i32.add (local.get $i) (i32.const 1)))
      (br_if $process_loop (i32.lt_u (local.get $i) (local.get $count)))
    )

    ;; Validate Eulerian Path requirements:
    ;; 1. Every used vertex must have an even degree.
    ;; 2. All used vertices must share the same representative disjoint set root.
    (local.set $root (i32.const -1))
    (local.set $i (i32.const 0))
    (loop $validate_loop
      (local.set $v (i32.load (i32.add (i32.const 2048) (i32.shl (local.get $i) (i32.const 2)))))
      
      (if (i32.gt_u (local.get $v) (i32.const 0))
        (then
          ;; Rule 1: Fail if degree is odd
          (if (i32.and (local.get $v) (i32.const 1))
            (then (return (i32.const 0)))
          )

          ;; Find component root for connectedness check
          (local.set $root_u (local.get $i))
          (loop $find_root
            (local.set $v (i32.load (i32.add (i32.const 1024) (i32.shl (local.get $root_u) (i32.const 2)))))
            (if (i32.ne (local.get $root_u) (local.get $v))
              (then
                (local.set $root_u (local.get $v))
                (br $find_root)
              )
            )
          )

          ;; Rule 2: Verify all nodes trace back to the exact same tracking component root
          (if (i32.eq (local.get $root) (i32.const -1))
            (then (local.set $root (local.get $root_u)))
            (else
              (if (i32.ne (local.get $root) (local.get $root_u))
                (then (return (i32.const 0)))
              )
            )
          )
        )
      )

      (local.set $i (i32.add (local.get $i) (i32.const 1)))
      (br_if $validate_loop (i32.lt_u (local.get $i) (i32.const 256)))
    )

    (i32.const 1)
  )
)