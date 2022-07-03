%===============================================================================
% Main
%===============================================================================

qssort(File, Answer) :-
  read_input(File, L),
  Q_init = L,
  S_init = [],
  (isSorted(Q_init) -> Answer = "empty", !
  ;
  length(Moves, Length),
  solve(Q_init, S_init, Moves, Length, 0),
  atomics_to_string(Moves, Answer),
  !
  ).

%===============================================================================
% Predicates
%===============================================================================

isSorted([]).
isSorted([_]).
isSorted([A1, A2 | T]) :-
  A1 =< A2,
  isSorted([A2 | T]).

isEmpty([]).

isFinal(Q, S) :-
  isSorted(Q),
  isEmpty(S).

move([Hq|Tq], S, "Q", Q_next, S_next, CounterQ, NewCounterQ) :-
  NewCounterQ is CounterQ+1,
  Q_next = Tq,
  S_next = [Hq|S].

move(Q, [Hs|Ts], "S", Q_next, S_next, CounterQ, CounterQ) :-
  append(Q, [Hs], Q_next),
  S_next = Ts.

duplicate([H1|_], [H2|_], Move) :-
 (H1 =:= H2 -> Move = "Q").

%===============================================================================
% Solver
%===============================================================================

solve(Q, S, [], _, _) :-
  isFinal(Q, S).

solve(Q, S, [Move | Moves], Length, CounterQ) :-
  Length rem 2 =:= 0,
  ( CounterQ =:= Length div 2 ->
      Move = "S",
      move(Q, S, Move, Q_next, S_next, CounterQ, CounterQ),
      solve(Q_next, S_next, Moves, Length, CounterQ)
  ;
    ( duplicate(Q, S, Move) ->
        move(Q, S, Move, Q_next, S_next, CounterQ, NewCounterQ),
        solve(Q_next, S_next, Moves, Length, NewCounterQ)
    ;
      move(Q, S, Move, Q_next, S_next, CounterQ, NewCounterQ),
      solve(Q_next, S_next, Moves, Length, NewCounterQ)
    )
  ).

%===============================================================================
% I/O
%===============================================================================

read_input(File, L) :-
    open(File, read, Stream),
    read_line(Stream, [_]),
    read_line(Stream, L).

read_line(Stream, C) :-
    read_line_to_codes(Stream, Line),
    atom_codes(Atom, Line),
    atomic_list_concat(Atoms, ' ', Atom),
    maplist(atom_number, Atoms, C).
