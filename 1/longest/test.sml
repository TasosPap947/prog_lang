fun print_list [] = print "\n"
  | print_list (h::t) = (print(Int.toString(h) ^ " "); print_list t);

fun check_and n =
  if (n > 0 andalso n < 5) then print("0 < n < 5\n")
  else ();


check_and 1;
