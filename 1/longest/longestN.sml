fun longest fileName =
  let
    (* Input parse code by Stavros Aronis, modified by Nick Korasidis. *)
    fun parse file =
      let
        (* A function to read an integer from specified input. *)
        fun readInt input =
        Option.valOf (TextIO.scanStream (Int.scan StringCvt.DEC) input)

        (* Open input file. *)
      	val inStream = TextIO.openIn file

        (* Read an integer (number of countries) and consume newline. *)
      	val m = readInt inStream
        val n = readInt inStream
      	val _ = TextIO.inputLine inStream

        (* A function to read N integers from the open file. *)
      	fun readInts 0 acc = rev acc (* Replace with 'rev acc' for proper order. *)
      	  | readInts i acc = readInts (i - 1) (readInt inStream :: acc)
      in
        (m, n, readInts m [])
      end

    (* BEGINNING OF ACTUAL SOLUTION *)
    fun max (a, b) = if a > b then a else b

    fun min (a, b) = if a < b then a else b

    fun print_list [] = print "\n"
      | print_list (h::t) = (print(Int.toString(h) ^ " "); print_list t)

    fun print_array a i =
      if i >= Array.length a then (print("\n"))
      else (print(Int.toString(Array.sub(a, i)) ^ " "); print_array a (i+1))

    fun update_array a i N =
      if i >= Array.length a then ()
      else (
        Array.update(a, i, ~(Array.sub(a,i)+N));
        update_array a (i+1) N
      )

    fun create_partial_sums partial_sum a i M =
      if i < M then (
        Array.update(partial_sum, i, Array.sub(partial_sum, i-1) + Array.sub(a, i));
        create_partial_sums partial_sum a (i+1) M
      )
      else ()

    fun create_left_right_arrays left_min right_max partial_sum i M =
      if i < M then (
        Array.update(left_min, i, min(Array.sub(left_min, i-1), Array.sub(partial_sum, i)));
        Array.update(right_max, M-i-1, max(Array.sub(right_max,M-i), Array.sub(partial_sum,M-i-1)));
        create_left_right_arrays left_min right_max partial_sum (i+1) M
      )
      else ()

    fun check_first partial_sum i length M =
      if i < M then (
        if Array.sub(partial_sum, i) >= 0 then (
          Array.update(length, 0, i+1);
          check_first partial_sum (i+1) length M
        )
        else (
          check_first partial_sum (i+1) length M
        )
      )
      else ()

    fun check_second i j M right_max left_min length =
      if (i < M andalso j < M) then (
        if (Array.sub(right_max, j) >= Array.sub(left_min, i)) then (
          if (j-i > Array.sub(length, 0)) then (
            Array.update(length, 0, j-i);
            check_second i (j+1) M right_max left_min length
          )
          else (
            check_second i (j+1) M right_max left_min length
          )
        )
        else (
          check_second (i+1) j M right_max left_min length
        )
      )
      else ()

    fun solve (m, n, sizelist) =
      let
        val a = Array.fromList sizelist
        val partial_sum = Array.array(m,0)
        val left_min = Array.array(m,0)
        val right_max = Array.array(m,0)
        val length = Array.array(1,0)

      in
        (
          update_array a 0 n;
          Array.update(partial_sum, 0, Array.sub(a, 0));
          create_partial_sums partial_sum a 1 m;
          Array.update(left_min, 0, Array.sub(partial_sum,0));
          Array.update(right_max, m-1, Array.sub(partial_sum, m-1));
          create_left_right_arrays left_min right_max partial_sum 1 m;
          check_first partial_sum 0 length m;
          check_second 0 0 m right_max left_min length;
          (* print_array a 0; *)
          (* print_array partial_sum 0; *)
          (* print_array left_min 0; *)
          (* print_array right_max 0; *)
          print_array length 0
        )
      end
    (* END OF ACTUAL SOLUTION *)

    (* Dummy solver & requested interface. *)

  in
    solve (parse fileName)
    (* longest "f.txt"; *)
  end
