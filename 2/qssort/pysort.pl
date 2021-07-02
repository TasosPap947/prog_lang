qssort(File, Answer) :-
  read_input(File, L),
  Q_init = L,
  S_init = [],
  String = [""],
  append([], [(Q_init, S_init, String)], State_Q),
  Seen = [],
  ( isSorted(Q_init) ->
    Answer = "empty"
  ;
    solve(State_Q, Seen, Answer_no_str)
    % atomics_to_string(Answer_no_str, Answer), !
  ).


solve(State_Q, Seen, Answer) :-
  ( not_empty(State_Q) ->
      popleft((Q, S, String), State_Q, NewState_Q),
      ( not_empty(Q) ->

          nextQ(Q, S, String, Q_next, S_next, String_next),

          ( final(Q_next, S_next) ->
              true
          ;
            State = (Q_next, S_next),
            ( not_member(State, Seen) ->
                append(State_Q, [(Q_next, S_next, String_next)], NewState_Q),
                append(Seen, [State], NewSeen),
                !, solve(NewState_Q, NewSeen, Answer)
            ; /* member(State, Seen) and not final(Q_next, S_next) and not empty(Q), and not empty(State_Q) */
              !, solve(NewState_Q, Seen, Answer)
            )
          )
      ; /* empty(Q) and not empty(State_Q), so we continue */
        !, solve(NewState_Q, Seen, Answer)
      ),
      ( not_empty(S) ->
          nextS(Q, S, String, Q_next, S_next, String_next),
          ( final(Q_next, S_next) ->
              true
          ;
            State = (Q_next, S_next),
            ( not_member(State, Seen) ->
                append(State_Q, [(Q_next, S_next, String_next)], NewState_Q),
                append(Seen, [State], NewSeen),
                !, solve(NewState_Q, NewSeen, Answer)
            ; /* member(State, Seen) and not final(Q_next, S_next) and not empty(S), and not empty(State_Q) */
              !, solve(NewState_Q, Seen, Answer)
            )
          )
      ;
        /* empty(S) and not empty(State_Q), so we continue */
        !, solve(NewState_Q, Seen, Answer)
      )
  ;
    /* empty(State_Q), so we failed */
    false
  ).

%===============================================================================
% Functions
%===============================================================================

final(Q, S) :-
  empty(S), isSorted(Q).

isSorted([]).
isSorted([_]).
isSorted([A1, A2 | T]) :-
  A1 < A2,
  isSorted([A2 | T]).

empty([]).
not_empty(L) :- \+empty(L).

not_member(X, L) :- \+member(X, L).


nextQ([Hq|Tq], S, String, Q_next, S_next, String_next) :-
  Q_next = Tq,
  S_next = [Hq|S],
  append(String, ["Q"], String_next).

nextS(Q, [Hs|Ts], String, Q_next, S_next, String_next) :-
  append(Q, [Hs], Q_next),
  S_next = Ts,
  append(String, ["S"], String_next).

%===============================================================================
% Queue
%===============================================================================

empty_queue([]).

enqueue(X, [], [X]).

enqueue(X, [H | T], [H | Tnew]) :-
  enqueue(X, T, Tnew).

popleft(X, [X | T], T).

popleft(X, [X | _], _).

add_list_to_queue(List, Queue, Newqueue) :-
  append(Queue, List, Newqueue).

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
