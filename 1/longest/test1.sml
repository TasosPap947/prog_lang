fun maze
let
  val counter = Array.array(1,0)
  (* counter = 0 *)

  fun countdown 0 = ()
    | countdown n = (
                      print(Int.toString(n-1)^"\n");
                      countdown (n-1)
                    )
in
  print("Answer\n")
