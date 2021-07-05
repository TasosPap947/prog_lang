round(File, M, C) :-
  read_input(File, N, K, Initial),
  allCityCosts(0, Initial, K, N, [], Costs),
  minList(Costs, Answer),
  (M, C) = Answer.

cityCost([], _, Sum, _, _, Max, Result_sum, Result_max) :-
  Result_sum = Sum, Result_max = Max.
cityCost([H | T], City_num, Sum, K, N, Max, Result_sum, Result_max) :-
  (City_num - H >= 0 ->
    NewSum is Sum + City_num - H,
    NewMax is max(Max, City_num - H),
    cityCost(T, City_num, NewSum, K, N, NewMax, Result_sum, Result_max)
  ;
    NewSum is Sum + N + City_num - H,
    NewMax is max(Max, N + City_num - H),
    cityCost(T, City_num, NewSum, K, N, NewMax, Result_sum, Result_max)
  ).

allCityCosts(City_num, Car_list, K, N, Acc, Result) :-
  cityCost(Car_list, City_num, 0, K, N, 0, Result_cost, Result_max),
  (Cost, Max) = (Result_cost, Result_max),
  (City_num < N ->
    (Max > Cost - Max + 1 ->
      New_city_num is City_num + 1,
      allCityCosts(New_city_num, Car_list, K, N, Acc, Result)
    ;
      New_city_num is City_num + 1,
      allCityCosts(New_city_num, Car_list, K, N, [(Cost, City_num) | Acc], Result)
    )
  ;
    reverse(Acc, Result)
  ).

minList(_, [], (X, Y), (Ans1, Ans2)) :- Ans1 = X, Ans2 = Y.
minList("first_time", [(X, Y) | T], _, (Ans1, Ans2)) :-
  minList("second_time", [(X, Y) | T], (X, Y), (Ans1, Ans2)).
minList("second_time", [(X, Y) | T], (Curr_min, Curr_y), (Ans1, Ans2)) :-
  ( X < Curr_min ->
      minList("second_time", T, (X, Y), (Ans1, Ans2))
  ;
    minList("second_time", T, (Curr_min, Curr_y), (Ans1, Ans2))
  ).
minList(L, Answer) :-
  minList("first_time", L, (0,0), Answer), !.

%==============================================================================
% I/O
%==============================================================================

read_input(File, N, K, Initial) :-
    open(File, read, Stream),
    read_line(Stream, [N, K]),
    read_line(Stream, Initial).

read_line(Stream, L) :-
    read_line_to_codes(Stream, Line),
    atom_codes(Atom, Line),
    atomic_list_concat(Atoms, ' ', Atom),
    maplist(atom_number, Atoms, L).
