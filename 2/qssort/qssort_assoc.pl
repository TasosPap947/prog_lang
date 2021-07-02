#:- dynamic visited/2.
qssort(File, Answer) :-
  read_input(File, L),
  Q_init = L,
  S_init = [],
  ( isSorted(Q_init) ->
    Answer = "empty"
  ;
    empty_assoc(Assoc),
    length(Moves, _),
    solve(Q_init, S_init, Assoc, Moves),
    atomics_to_string(Moves, Answer), !
  ).

%===============================================================================
% Predicates
%===============================================================================

isSorted([]).
isSorted([_]).
isSorted([A1, A2 | T]) :-
  A1 < A2,
  isSorted([A2 | T]).

isEmpty([]).

isFinal(Q, S) :-
  isSorted(Q),
  isEmpty(S).

move([Hq|Tq], S, "Q", Q_next, S_next) :-
  Q_next = Tq,
  S_next = [Hq|S].

move(Q, [Hs|Ts], "S", Q_next, S_next) :-
  append(Q, [Hs], Q_next),
  S_next = Ts.

solve(Q, S, _, []) :-
  isFinal(Q, S).

solve(Q, S, Assoc, [Move|Moves]) :-
  move(Q, S, Move, Q_next, S_next),
  ( not_assoc((Q, S), Assoc, 0) ->
    put_assoc((Q, S), Assoc, 0, NewAssoc),
    solve(Q_next, S_next, NewAssoc, Moves), !
  ;
    dummy()
  ).


not_assoc(X, Assoc, 0) :-
  \+get_assoc(X, Assoc, 0), !.

dummy().

%===============================================================================
% I/O
%===============================================================================

count([], Acc, Acc).
count([_|T], Acc, Result) :-
  NewAcc is Acc + 1,
  count(T, NewAcc, Result).


print_list([]).
print_list([First|Rest]) :-
    write(First),
    print_list(Rest).

read_input(File, L) :-
    open(File, read, Stream),
    read_line(Stream, [_]),
    read_line(Stream, L).

read_line(Stream, C) :-
    read_line_to_codes(Stream, Line),
    atom_codes(Atom, Line),
    atomic_list_concat(Atoms, ' ', Atom),
    maplist(atom_number, Atoms, C).