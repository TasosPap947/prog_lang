/*
 * A predicate that reads the input from File and returns it in
 * the last three arguments: M, N and L.
 * Example:
 *
 * ?- read_input('c1.txt', M, N, L).
 * M = 10,
 * N = 3,
 * L = [1, 3, 1, 3, 1, 3, 3, 2, 2|...].
 */
read_input(File, M, N, L) :-
    open(File, read, Stream),
    read_line(Stream, [M, N]),
    read_line(Stream, L).

read_line(Stream, C) :-
    read_line_to_codes(Stream, Line),
    atom_codes(Atom, Line),
    atomic_list_concat(Atoms, ' ', Atom),
    maplist(atom_number, Atoms, C).
