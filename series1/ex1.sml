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

fun sum counter first last [] = 0
  | sum counter first last (h::t) =
    if counter < first then
      sum (counter+1) first last t
    else
      if first < last then h + sum (counter+1) (first+1) last t else 0

fun for_range range first l m n=
  if first+range < m then
    if (sum 0 first (first+range) l) div (n*range) < ~1 then true
    else for_range range (first+1) l m n
  else
    false

fun for_all_ranges curr l m n =
  if for_range curr 0 l m n then for_all_ranges (curr+1) l m n
  else curr-1

fun my_sol (m, n, sizelist) = for_all_ranges 1 sizelist m n

(* END OF ACTUAL SOLUTION *)

(* Dummy solver & requested interface. *)
fun solve (m, n, sizelist) =
  let
    val answer = my_sol (m, n, sizelist)
  in
    (answer, m, n, sizelist)
  end

fun longest fileName = solve (parse fileName);

longest "f.txt";
