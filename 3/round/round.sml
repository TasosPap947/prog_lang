fun round fileName =
  let
    (* FUNCTION TO READ INPUT *)
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
        (m, n, readInts n [])
      end

    fun printList [] = print("\n")
      | printList (h :: t) =
        (print(Int.toString(h) ^ " "); printList t)

    fun minList L =
      let
        fun minListAux _ [] (x,y) = (x,y)
          | minListAux "first_time" ((x,y) :: t) _ =
              minListAux "second_time" ((x,y) :: t) (x,y)
          | minListAux "second_time" ((x,y) :: t) (curr_min, curr_y) =
              if x < curr_min then minListAux "second_time" t (x,y)
              else minListAux "second_time" t (curr_min, curr_y)
      in
        minListAux "first_time" L (0,0)
      end

    fun cityCost [] city_num sum K N max = (sum, max)
      | cityCost (h :: t) city_num sum K N max =
          if city_num - h >= 0 then cityCost t city_num (sum + city_num - h) K N (Int.max(max, city_num - h))
          else cityCost t city_num (sum + N + city_num - h) K N (Int.max(max, N + city_num - h))

    fun allCityCosts city_num car_list K N =
      let
        val (cost, max) = cityCost car_list city_num 0 K N 0
      in
        if (city_num < N) then
          if max > cost - max + 1 then allCityCosts (city_num+1) car_list K N else (cost, city_num) :: (allCityCosts (city_num+1) car_list K N)
        else []
      end

    fun solve fileName =
      let
        val (N, K, initial) = parse fileName
        val costs = allCityCosts 0 initial K N
        val (x, y) = minList costs
      in
        (print(Int.toString(x) ^ " " ^ Int.toString(y) ^ "\n"))
      end
  in
    solve fileName
  end
