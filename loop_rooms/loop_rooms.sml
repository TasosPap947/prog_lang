fun loop_rooms inputFile =
  let
    fun parse file =
      let
  	    (* Open input file. *)
        fun readInt input =
  	     Option.valOf (TextIO.scanStream (Int.scan StringCvt.DEC) input)
      	val inStream = TextIO.openIn file
        val N = readInt inStream
        val M = readInt inStream

        (* Reads lines until EOF and puts them in a list as char lists *)
        fun readLines acc =
          let
            val newLineOption = TextIO.inputLine inStream
          in
            if newLineOption = NONE
            then (rev acc)
            else ( readLines ( explode (valOf newLineOption ) :: acc ))
        end;

        val plane = readLines []

      in
     	    (N,M,plane)
    end;

   fun print_array a i j n m =
      if i < n then (
        if j < m then (
          print(Int.toString(Array2.sub(a, i, j)) ^ " ");
          print_array a i (j+1) n m
        )
        else (
          print("\n");
          print_array a (i+1) 0 n m
        )
      )
      else ()


    fun side_good_rooms maz fl i j n m cnt=
      if i < n then (
        if j < m then (
          if (j = 0 andalso Array2.sub(maz,i,j) = #"L") orelse (j = (m-1) andalso Array2.sub(maz,i,j) = #"R") orelse (i = 0 andalso Array2.sub(maz,i,j) = #"U") orelse (i = (n-1) andalso Array2.sub(maz,i,j) = #"D") then (
            Array2.update(fl,i,j, 1);
            Array.update(cnt,0,(Array.sub(cnt,0)+1))
            )
            else();
          side_good_rooms maz fl i (j+1) n m cnt
        )
        else (
          side_good_rooms maz fl (i+1) 0 n m cnt
        )
      )
      else ()





    fun recursive_help maz fl k l n2 m2 cnt =
      if(k = 0 andalso l = 0) then (   (*Upper-Left*)
        if(Array2.sub(maz,k,(l+1)) = #"L" andalso Array2.sub(fl,k,(l+1)) = 0) then(
            Array2.update(fl,k,(l+1), 1);
            Array.update(cnt,0,(Array.sub(cnt,0)+1));
            recursive_help maz fl k (l+1) n2 m2 cnt
          )
        else();
        if(Array2.sub(maz,(k+1),l) = #"U" andalso Array2.sub(fl,(k+1),l) = 0) then(
          Array2.update(fl,(k+1),l,1);
          Array.update(cnt,0,(Array.sub(cnt,0)+1));
          recursive_help maz fl (k+1) l n2 m2 cnt
          )
        else()
        )
      else( if( k = 0 andalso l = (m2-1)) then( (*Upper-Right*)
        if(Array2.sub(maz,k,(l-1)) = #"R" andalso Array2.sub(fl,k,(l-1)) = 0) then(
          Array2.update(fl,k,(l-1), 1);
          Array.update(cnt,0,(Array.sub(cnt,0)+1));
          recursive_help maz fl k (l-1) n2 m2 cnt
          )
        else();
        if(Array2.sub(maz,(k+1),l) = #"U" andalso Array2.sub(fl,(k+1),l) = 0) then(
          Array2.update(fl,(k+1),l,1);
          Array.update(cnt,0,(Array.sub(cnt,0)+1));
          recursive_help maz fl (k+1) l n2 m2 cnt
          )
        else()
        )
      else(if(k = (n2-1) andalso l = 0) then( (*Bottom-Left*)
        if(Array2.sub(maz,k,(l+1)) = #"L" andalso Array2.sub(fl,k,(l+1)) = 0) then(
          Array2.update(fl,k,(l+1), 1);
          Array.update(cnt,0,(Array.sub(cnt,0)+1));
          recursive_help maz fl k (l+1) n2 m2 cnt
          )
        else();
        if(Array2.sub(maz,(k-1),l) = #"D" andalso Array2.sub(fl,(k-1),l) = 0) then(
          Array2.update(fl,(k-1),l,1);
          Array.update(cnt,0,(Array.sub(cnt,0)+1));
          recursive_help maz fl (k-1) l n2 m2 cnt
          )
        else()
        )
      else(if(k = (n2-1) andalso l = (m2-1)) then( (*Bottom-Right*)
        if(Array2.sub(maz,k,(l-1)) = #"R" andalso Array2.sub(fl,k,(l-1)) = 0) then(
          Array2.update(fl,k,(l-1), 1);
          Array.update(cnt,0,(Array.sub(cnt,0)+1));
          recursive_help maz fl k (l-1) n2 m2 cnt
          )
        else();
        if(Array2.sub(maz,(k-1),l) = #"D" andalso Array2.sub(fl,(k-1),l) = 0) then(
          Array2.update(fl,(k-1),l,1);
          Array.update(cnt,0,(Array.sub(cnt,0)+1));
          recursive_help maz fl (k-1) l n2 m2 cnt
          )
        else()
        )
      else(if(k <> 0 andalso k <> (n2-1) andalso l = 0) then( (*Left side*)
        if(Array2.sub(maz,k,(l+1)) = #"L" andalso Array2.sub(fl,k,(l+1)) = 0) then(
          Array2.update(fl,k,(l+1), 1);
          Array.update(cnt,0,(Array.sub(cnt,0)+1));
          recursive_help maz fl k (l+1) n2 m2 cnt
          )
        else();
        if(Array2.sub(maz,(k-1),l) = #"D" andalso Array2.sub(fl,(k-1),l) = 0) then(
          Array2.update(fl,(k-1),l,1);
          Array.update(cnt,0,(Array.sub(cnt,0)+1));
          recursive_help maz fl (k-1) l n2 m2 cnt
          )
        else();
        if(Array2.sub(maz,(k+1),l) = #"U" andalso Array2.sub(fl,(k+1),l) = 0) then(
          Array2.update(fl,(k+1),l,1);
          Array.update(cnt,0,(Array.sub(cnt,0)+1));
          recursive_help maz fl (k+1) l n2 m2 cnt
          )
        else()
        )
      else(if(l = (m2-1) andalso k <> 0 andalso k <> (n2-1)) then( (*Right side *)
        if(Array2.sub(maz,k,(l-1)) = #"R" andalso Array2.sub(fl,k,(l-1)) = 0) then(
          Array2.update(fl,k,(l-1), 1);
          Array.update(cnt,0,(Array.sub(cnt,0)+1));
          recursive_help maz fl k (l-1) n2 m2 cnt
          )
        else();
        if(Array2.sub(maz,(k-1),l) = #"D" andalso Array2.sub(fl,(k-1),l) = 0) then(
          Array2.update(fl,(k-1),l,1);
          Array.update(cnt,0,(Array.sub(cnt,0)+1));
          recursive_help maz fl (k-1) l n2 m2 cnt
          )
        else();
        if(Array2.sub(maz,(k+1),l) = #"U" andalso Array2.sub(fl,(k+1),l) = 0) then(
          Array2.update(fl,(k+1),l,1);
          Array.update(cnt,0,(Array.sub(cnt,0)+1));
          recursive_help maz fl (k+1) l n2 m2 cnt
          )
        else()
        )
      else(if( k = 0 andalso l <> 0 andalso l <> (m2-1)) then( (*Upper-side*)
      if(Array2.sub(maz,k,(l-1)) = #"R" andalso Array2.sub(fl,k,(l-1)) = 0) then(
        Array2.update(fl,k,(l-1), 1);
        Array.update(cnt,0,(Array.sub(cnt,0)+1));
        recursive_help maz fl k (l-1) n2 m2 cnt
        )
      else();
      if(Array2.sub(maz,k,(l+1)) = #"L" andalso Array2.sub(fl,k,(l+1)) = 0) then(
        Array2.update(fl,k,(l+1), 1);
        Array.update(cnt,0,(Array.sub(cnt,0)+1));
        recursive_help maz fl k (l+1) n2 m2 cnt
        )
      else();
      if(Array2.sub(maz,(k+1),l) = #"U" andalso Array2.sub(fl,(k+1),l) = 0) then(
        Array2.update(fl,(k+1),l,1);
        Array.update(cnt,0,(Array.sub(cnt,0)+1));
        recursive_help maz fl (k+1) l n2 m2 cnt
        )
      else()
        )
      else(if(k = (n2-1) andalso l <> 0 andalso l <> (m2-1)) then( (*Bottom-side *)
        if(Array2.sub(maz,k,(l-1)) = #"R" andalso Array2.sub(fl,k,(l-1)) = 0) then(
          Array2.update(fl,k,(l-1), 1);
          Array.update(cnt,0,(Array.sub(cnt,0)+1));
          recursive_help maz fl k (l-1) n2 m2 cnt
          )
        else();
        if(Array2.sub(maz,k,(l+1)) = #"L" andalso Array2.sub(fl,k,(l+1)) = 0) then(
          Array2.update(fl,k,(l+1), 1);
          Array.update(cnt,0,(Array.sub(cnt,0)+1));
          recursive_help maz fl k (l+1) n2 m2 cnt
          )
        else();
        if(Array2.sub(maz,(k-1),l) = #"D" andalso Array2.sub(fl,(k-1),l) = 0) then(
          Array2.update(fl,(k-1),l,1);
          Array.update(cnt,0,(Array.sub(cnt,0)+1));
          recursive_help maz fl (k-1) l n2 m2 cnt
          )
        else()
        )
      else( (*Inside*)
      if(Array2.sub(maz,k,(l-1)) = #"R" andalso Array2.sub(fl,k,(l-1)) = 0) then(
        Array2.update(fl,k,(l-1), 1);
        Array.update(cnt,0,(Array.sub(cnt,0)+1));
        recursive_help maz fl k (l-1) n2 m2 cnt
        )
      else();
      if(Array2.sub(maz,k,(l+1)) = #"L" andalso Array2.sub(fl,k,(l+1)) = 0) then(
        Array2.update(fl,k,(l+1), 1);
        Array.update(cnt,0,(Array.sub(cnt,0)+1));
        recursive_help maz fl k (l+1) n2 m2 cnt
        )
      else();
      if(Array2.sub(maz,(k-1),l) = #"D" andalso Array2.sub(fl,(k-1),l) = 0) then(
        Array2.update(fl,(k-1),l,1);
        Array.update(cnt,0,(Array.sub(cnt,0)+1));
        recursive_help maz fl (k-1) l n2 m2 cnt
        )
      else();
      if(Array2.sub(maz,(k+1),l) = #"U" andalso Array2.sub(fl,(k+1),l) = 0) then(
        Array2.update(fl,(k+1),l,1);
        Array.update(cnt,0,(Array.sub(cnt,0)+1));
        recursive_help maz fl (k+1) l n2 m2 cnt
        )
      else()
       )) ))) )))




    fun prev_room maz fl i j n1 m1 cnt=
      if i < n1 then (
        if j < m1 then (
          if (j = 0 andalso Array2.sub(maz,i,j) = #"L") orelse (j = (m1-1) andalso Array2.sub(maz,i,j) = #"R") orelse (i = 0 andalso Array2.sub(maz,i,j) = #"U") orelse (i = (n1-1) andalso Array2.sub(maz,i,j) = #"D") then (
            recursive_help maz fl i j n1 m1 cnt
            )
            else();
          prev_room maz fl i (j+1) n1 m1 cnt
        )
        else (
          prev_room maz fl (i+1) 0 n1 m1 cnt
        )
      )
      else ()



    fun solve inputFile =
      let
        val inputTuple = parse inputFile
        val N = #1 inputTuple
        val M = #2 inputTuple
        val my_list = tl(#3 inputTuple)
        val maze = Array2.fromList my_list
        val flag = Array2.array(N,M,0)
        val counter = Array.array(1,0);
        (* actual program *)

      in
        (
          side_good_rooms maze flag 0 0 N M counter;
          prev_room maze flag 0 0 N M counter;
          (*print_array flag 0 0 N M; *)
          print(Int.toString(N*M-Array.sub(counter,0)) ^ "\n")
          (*change bad_maze maze 0 0 (*ΑΠΑΡΑΙΤΗΤΟ*)*)
        )
      end
  in
    solve inputFile
end;
