longest(File, Answer, Debug) :-
    read_input(File, M, N, A1),
    M = M,

    change(A1, N, [], A2),
    reverse(A2, A3),

    partial_sum(A3, 0, [], PS1),
    reverse(PS1, PS2),

    first(PS2, Min),
    left_min(PS2, Min, [], LM1),
    reverse(LM1, LM2),

    % We can use PS1 here, no reverse needed.
    % RM2 instead of RM1, for consistency with LM2

    first(PS1, Max),
    right_max(PS1, Max, [], RM2),

    length1(PS2, 0, 0, L1),

    % Careful! CurrLength must be equal to L1
    length2(RM2, LM2, 0, L1, L2, Debug),

    ( Debug ->
        write("A:\n"),
        print_list(A3),
        write("Partial_sum:\n"),
        print_list(PS2),
        write("Left_min:\n"),
        print_list(LM2),
        write("Right_max:\n"),
        print_list(RM2),
        write(L1),
        write("\n"),
        write(L2),
        write("\n")
    ;
        true
    ),

    Answer is max(L1,L2).


%===============================================================================



change([], _, L, L).
change([H|T], N, Acc, L) :-
    NewH is -H-N,
    change(T, N, [NewH|Acc], L).

partial_sum([], _, L, L).
partial_sum([H|T], Sum, Acc, L) :-
    NewSum is Sum + H,
    partial_sum(T, NewSum, [NewSum|Acc], L).

first([],[]).
first([H|_],H).

left_min([], _, L, L). % need to find what happens with CurrMin
left_min([H|T], CurrMin, Acc, L) :-
    NewMin is min(H, CurrMin),
    left_min(T, NewMin, [NewMin|Acc], L).

right_max([], _, L, L).
right_max([H|T], CurrMax, Acc, L) :-
    NewMax is max(H, CurrMax),
    right_max(T, NewMax, [NewMax|Acc], L).

length1([], _, Length, Length).
length1([H|T], I, CurrLength, Length) :-
    ( H >= 0 ->
        NewI is I+1,
        length1(T, NewI, NewI, Length)
    ;
        NewI is I+1,
        length1(T, NewI, CurrLength, Length)
    ).

length2([], _, _, CurrLength, Length, _) :-
    Length is CurrLength.

length2(_, [], _, CurrLength, Length, _) :-
    Length is CurrLength.

length2([H1|T1], [H2|T2], Diff, CurrLength, Length, Debug) :-
    ( H1 >= H2 ->
            ( Diff > CurrLength ->
                NewLength is Diff
            ;
                NewLength is CurrLength
            ),
            NewDiff is Diff+1,
            length2(T1, [H2|T2], NewDiff, NewLength, Length, Debug)
    ;
        NewDiff is Diff-1,
        NewLength is CurrLength,
        length2([H1|T1], T2, NewDiff, NewLength, Length, Debug)
    ),
    ( Debug ->
        write("CurrLength = "),
        write(CurrLength),
        write("\n")
    ;
        true
    ).


%===============================================================================



print_list([]) :-
    write("\n\n").
print_list([First|Rest]) :-
    write(First),
    write(" "),
    print_list(Rest).

read_input(File, M, N, L) :-
    open(File, read, Stream),
    read_line(Stream, [M, N]),
    read_line(Stream, L).

read_line(Stream, C) :-
    read_line_to_codes(Stream, Line),
    atom_codes(Atom, Line),
    atomic_list_concat(Atoms, ' ', Atom),
    maplist(atom_number, Atoms, C).
