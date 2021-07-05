% testFunction(+File, +City_num, +L, +Zero_amount,
%      -M, -C, -City_cost_result_sum, -City_cost_result_max, -City_cost_result_max_position)
%      -Sort_and_cars_per_city_result
%      -All_city_costs_wrapper_result
%      -Fast_city_costs_result
%      -Min_list_result
%      -Cars_per_city_result
%      -Fill_with_zeros_result)
testFunction(File, City_num, L, Zero_amount,
     M, C, City_cost_result_sum, City_cost_result_max, City_cost_result_max_position,
     Sort_and_cars_per_city_result,
     All_city_costs_wrapper_result,
     Fast_city_costs_result,
     Slow_city_costs_result,
     Min_list_result,
     Cars_per_city_result,
     Fill_with_zeros_result,
     Max_helper) :-

  write("\n"),
  % +File
  read_input(File, N, K, Car_list),
  %
  % % +File, -M, -C
  round(File, M, C),
  %
  % % +City_num, -City_cost_result_sum, -City_cost_result_max, -City_cost_result_max_position
  cityCost(Car_list, City_num, 0, 0, K, N, 0, 0, City_cost_result_sum, City_cost_result_max, City_cost_result_max_position),
  %
  % % -Sort_and_cars_per_city_result
  sortAndCarsPerCity(Car_list, N, K, Sort_and_cars_per_city_result),
  %
  City_list = Sort_and_cars_per_city_result,
  %
  % % -All_city_costs_wrapper_result
  allCityCostsWrapper(Car_list, City_list, K, N, All_city_costs_wrapper_result),
  %
  %
  slowCityCosts(0, Car_list, K, N, [], Slow_city_costs_result),

  Prev_city_cost = City_cost_result_sum,
  Prev_city_max = City_cost_result_max,
  Prev_city_max_position = City_cost_result_max_position,
  %
  sort(Car_list, Max_helper_intermediate),
  Max_helper_intermediate = [Max_helper_head1, Max_helper_head2 | Max_helper_tail],
  (Max_helper_head1 =:= 0 ->
    append(Max_helper_tail, [0], Max_helper)
  ;
    Max_helper = [Max_helper_head2 | Max_helper_tail]
  ),

  % % -Fast_city_costs_result
  fastCityCosts(Car_list, 0, City_list, Prev_city_cost, Prev_city_max, Prev_city_max_position, K, N, [], Max_helper, Fast_city_costs_result),
  %
  List_of_tuples = All_city_costs_wrapper_result,
  %
  % % -(Min_list_ans_1, Min_list_ans_2)
  minList("first_time", List_of_tuples, (0, 0), (Min_list_ans_1, Min_list_ans_2)),
  %
  Min_list_result = (Min_list_ans_1, Min_list_ans_2),
  % % -Cars_per_city_result
  msort(Car_list, Sorted_car_list),
  carsPerCity(Sorted_car_list, 0, 0, N, K, [], Cars_per_city_result),
  %
  % % +L, +Zero_amount, -Fill_with_zeros_result
  fillWithZeros(L, Zero_amount, Fill_with_zeros_result).

test(M, C, City_cost_result_sum, City_cost_result_max, City_cost_result_max_position,
     Sort_and_cars_per_city_result,
     All_city_costs_wrapper_result,
     Fast_city_costs_result,
     Slow_city_costs_result,
     Min_list_result,
     Cars_per_city_result,
     Fill_with_zeros_result,
     Max_helper) :-
  File = "r5.txt",
  City_num = 0,
  L = [1, 2, 3],
  Zero_amount = 3,
  testFunction(File, City_num, L, Zero_amount,
       M, C, City_cost_result_sum, City_cost_result_max, City_cost_result_max_position,
       Sort_and_cars_per_city_result,
       All_city_costs_wrapper_result,
       Fast_city_costs_result,
       Slow_city_costs_result,
       Min_list_result,
       Cars_per_city_result,
       Fill_with_zeros_result,
       Max_helper).

% round(+File, -M, -C)
round(File, M, C) :-
  read_input(File, N, K, Initial),
  sortAndCarsPerCity(Initial, N, K, City_list),
  allCityCostsWrapper(Initial, City_list, K, N, Costs),
  minList(Costs, Answer),
  (M, C) = Answer.

% cityCost(+Car_list, +City_num, ~Curr_city_counter, ~Sum, +K, +N, ~Max, ~Max_position, -Result_sum, -Result_max, -Result_max_position)
cityCost([], _, _, Sum, _, _, Max, Max_position, Result_sum, Result_max, Result_max_position) :-
  Result_sum = Sum, Result_max = Max, Result_max_position = Max_position.
cityCost([H | T], City_num, Curr_city_counter, Sum, K, N, Max, Max_position, Result_sum, Result_max, Result_max_position) :-
  % write([H | T]), write(" "), write(Max_position), write(" "), write(Max), write("\n"),
  New_city_counter is Curr_city_counter + 1,
  (City_num - H >= 0 ->
    New_sum is Sum + City_num - H,
    (City_num - H > Max ->
      New_max is City_num - H,
      New_max_position is H
    ;
      New_max is Max,
      New_max_position is Max_position
    ),
    cityCost(T, City_num, New_city_counter, New_sum, K, N, New_max, New_max_position, Result_sum, Result_max, Result_max_position)
  ;
    New_sum is Sum + N + City_num - H,
    New_max is max(Max, N + City_num - H),
    (N + City_num - H > Max ->
      New_max is N + City_num - H,
      New_max_position is H
    ;
      New_max is Max,
      New_max_position is Max_position
    ),
    cityCost(T, City_num, New_city_counter, New_sum, K, N, New_max, New_max_position, Result_sum, Result_max, Result_max_position)
  ).

% allCityCostsWrapper(+Car_list, +City_list, +K, +N, -Result)
allCityCostsWrapper(Car_list, City_list, K, N, Result) :-
  cityCost(Car_list, 0, 0, 0, K, N, 0, 0, Result_cost, Result_max, Result_max_position),
  (Cost, Max, Max_position) = (Result_cost, Result_max, Result_max_position),
  City_list = [_ | T],
  sort(Car_list, Max_helper_intermediate),
  Max_helper_intermediate = [Max_helper_head1, Max_helper_head2 | Max_helper_tail],
  (Max_helper_head1 =:= 0 ->
    append(Max_helper_tail, [0], Max_helper)
  ;
    Max_helper = [Max_helper_head2 | Max_helper_tail]
  ),
  ( Max =< Cost - Max + 1 ->
    fastCityCosts(Car_list, 0, T, Cost, Max, Max_position, K, N, [(Cost, 0)], Max_helper, Result)
  ;
    fastCityCosts(Car_list, 0, T, Cost, Max, Max_position, K, N, [], Max_helper, Result)
  ).
% fastCityCosts(+Car_list, ~Prev_city_num, +City_list, ~Prev_city_cost, ~Prev_city_max, ~Prev_city_max_position, +K, +N, ~Acc, Max_helper, -Result)
fastCityCosts(_, _, [], _, _, _, _, _, Acc, _, Result) :-
  reverse(Acc, Result).

fastCityCosts(Car_list, Prev_city_num, City_list, Prev_city_cost, Prev_city_max, Prev_city_max_position, K, N, Acc, [], Result) :-
  City_list = [H | T],
  New_city_cost is Prev_city_cost + K - H * N,
  ( Prev_city_max_position =\= Prev_city_num ->
      New_city_max is Prev_city_max + 1,
      New_city_max_position is Prev_city_max_position,
      New_max_helper = []
  ;
    % cityCost(Car_list, Prev_city_num, 0, 0, K, N, 0, 0, _, Result_max, Result_max_position),
    (false ->
      New_city_max is N - (M - Prev_city_num),
      New_city_max_position = M,
      New_max_helper = []
    ;
      New_city_max is Prev_city_num,
      New_city_max_position = Prev_city_max_position,
      New_max_helper = []
    )
  ),
  New_city_num is Prev_city_num + 1,
  (New_city_max > New_city_cost - New_city_max + 1 ->
    NewAcc = Acc
  ;
    % write("Adding "), write((New_city_cost, New_city_max)), write(" "), write("\n"),
    NewAcc = [(New_city_cost, New_city_num) | Acc]
  ),
  fastCityCosts(Car_list, New_city_num, T, New_city_cost, New_city_max, New_city_max_position, K, N, NewAcc, New_max_helper, Result).

fastCityCosts(Car_list, Prev_city_num, City_list, Prev_city_cost, Prev_city_max, Prev_city_max_position, K, N, Acc, [M | Ms], Result) :-
  % write(Prev_city_num), write(" "),
  % write(City_list), write(" "),
  % write([M | Ms]), write("\n"),
  City_list = [H | T],
  New_city_cost is Prev_city_cost + K - H * N,
  ( Prev_city_max_position =\= Prev_city_num ->
      New_city_max is Prev_city_max + 1,
      New_city_max_position is Prev_city_max_position,
      New_max_helper = [M | Ms]
  ;
    % cityCost(Car_list, Prev_city_num, 0, 0, K, N, 0, 0, _, Result_max, Result_max_position),
    (M =\= 0 ->
      New_city_max is N - (M - Prev_city_num),
      New_city_max_position = M,
      New_max_helper = Ms
    ;
      New_city_max is Prev_city_num + 1,
      New_city_max_position = 0,
      New_max_helper = Ms
    )
  ),
  New_city_num is Prev_city_num + 1,
  (New_city_max > New_city_cost - New_city_max + 1 ->
    NewAcc = Acc
  ;
    % write("Adding "), write((New_city_cost, New_city_max)), write(" "), write("\n"),
    NewAcc = [(New_city_cost, New_city_num) | Acc]
  ),
  fastCityCosts(Car_list, New_city_num, T, New_city_cost, New_city_max, New_city_max_position, K, N, NewAcc, New_max_helper, Result).

% slowCityCosts(~City_num, +Car_list, +K, +N, ~Acc, -Result)
slowCityCosts(City_num, Car_list, K, N, Acc, Result) :-
  cityCost(Car_list, City_num, 0, 0, K, N, 0, 0, Result_cost, Result_max, _),
  (Cost, Max) = (Result_cost, Result_max),
  (City_num < N ->
    (Max > Cost - Max + 1 ->
      New_city_num is City_num + 1,
      slowCityCosts(New_city_num, Car_list, K, N, Acc, Result)
    ;
      New_city_num is City_num + 1,
      slowCityCosts(New_city_num, Car_list, K, N, [(Cost, City_num) | Acc], Result)
    )
  ;
    reverse(Acc, Result)
  ).
% minList(~first_or_second_time, +List_of_tuples, ~(Curr_min, Curr_y), -(Ans1, Ans2))
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

% sortAndCarsPerCity(+Car_list, +N, +K, -Result)
sortAndCarsPerCity(Car_list, N, K, Result) :-
  msort(Car_list, Sorted_car_list),
  carsPerCity(Sorted_car_list, 0, 0, N, K, [], Result).

% carsPerCity(+Car_list, ~Curr_city, ~Curr_city_count, +N, +K, ~Acc, -Result)
carsPerCity([], Curr_city, Curr_city_count, N, _, Acc, Result) :-
  Zero_amount is N - Curr_city - 1,
  fillWithZeros([Curr_city_count|Acc], Zero_amount, Intermediate),
  reverse(Intermediate, Result).
carsPerCity([H | T], Curr_city, Curr_city_count, N, K, Acc, Result) :-
  (H =:= Curr_city ->
    New_curr_city is Curr_city,
    New_curr_city_count is Curr_city_count + 1,
    carsPerCity(T, New_curr_city, New_curr_city_count, N, K, Acc, Result)
  ;
    New_curr_city is Curr_city + 1,
    New_curr_city_count is 0,
    carsPerCity([H | T], New_curr_city, New_curr_city_count, N, K, [Curr_city_count | Acc], Result)
  ).

% fillWithZeros(+L, +Zero_amount, -Result)
fillWithZeros(L, 0, Result) :- Result = L, !.
fillWithZeros(L, Zero_amount, Result) :-
  New_zero_amount is Zero_amount - 1,
  fillWithZeros([0 | L], New_zero_amount, Result).

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
