longest(File /*, Answer */) :-
    read_input(File, M, N, A1),
    maplist(change(N), A1, A2),
    % findall(Prefix, myprefix(Prefix, A2), Prefixlist),
    %maplist(sumlist, Prefixlist, Prefixsum),
    pref(A2, Prefixsum).
    %printlist(A1),
    %printlist(A2),
    %printlist(Prefixlist),
    %printlist(Prefixsum).

myprefix(L1, L2) :-
    prefix(L1, L2), \+L1 = [].

pref(Xs, Ys) :-
    pref(Xs,[],0,Y),
    reverse(Y,Ys).

pref([],Y,_,Y).

pref([H|T],Rs,A,Y) :-
    A1 is A + H,
    pref(T,[A1|Rs],A1,Y).

change(N, A1, A2) :-
    A2 is -A1-N.

sumlist([],0).
sumlist([H|T], S) :-
    sumlist(T, NewS),
    S is NewS + H.

% Tail recursive sum function
% sumlist([],X,X).
% sumlist([H|T], A, S) :- A2 is A + H, sumlist(T,A2,S).

%-----------------I/O-------------------

printlist([First|Rest]) :-
    write(First),
    write(" "),
    printlist(Rest).

read_input(File, M, N, L) :-
    open(File, read, Stream),
    read_line(Stream, [M, N]),
    read_line(Stream, L).

read_line(Stream, C) :-
    read_line_to_codes(Stream, Line),
    atom_codes(Atom, Line),
    atomic_list_concat(Atoms, ' ', Atom),
    maplist(atom_number, Atoms, C).
