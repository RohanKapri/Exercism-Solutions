fun encode (rails, msg) =
  if rails <= 1 then msg
  else
    let
      val len = String.size msg
      val cycle = 2 * rails - 2

      fun rail i =
        let
          val m = i mod cycle
        in
          if m < rails then m
          else cycle - m
        end

      val arr = Array.array (rails, []: char list)

      (* Loop backwards through msg, building arr *)
      fun loop 0 = ()
        | loop i =
          let
            val i = i - 1
            val ch = String.sub (msg, i)
            val r = rail i
          in
            Array.update (arr, r, ch :: Array.sub (arr, r));
            loop i
          end

      fun collect (rail: char list, acc: string list): string list =
        String.implode rail :: acc
    in
      loop len;
      String.concat (Array.foldr collect [] arr)
    end

fun decode (rails, msg) =
  if rails <= 1 then msg
  else
    let
      val len = String.size msg
      val cycle = 2 * rails - 2

      fun rail i =
        let
          val m = i mod cycle
        in
          if m < rails then m
          else cycle - m
        end

      fun railLen k =
        let
          val full = len div cycle
          val rem = len mod cycle
          val base = if k = 0 orelse k = rails - 1 then full else 2 * full
          val extra1 = if rem > k then 1 else 0
          val extra2 = if k < rails - 1 andalso rem > cycle - k then 1 else 0
        in
          base + extra1 + extra2
        end

      val arr = Array.array (rails, []: char list)

      (* Fill array with rail segments *)
      fun fill (k, offset) =
        if k = rails then ()
        else
          let val n = railLen k
          in
            Array.update (arr, k, String.explode (String.substring (msg, offset, n)));
            fill (k + 1, offset + n)
          end
      val () = fill (0, 0)

      fun build (i: int, r: int, step: int): char list =
        if i = len then []
        else
          let
            val ch :: rest = Array.sub (arr, r)
            val _ = Array.update (arr, r, rest)
            val r = r + step
            val step = if r = 0 orelse r + 1 = rails then ~step else step
          in
            ch :: build (i + 1, r, step)
          end
    in
      String.implode (build (0, 0, 1))
    end