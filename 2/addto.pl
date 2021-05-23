addto([],L,L).
addto([H|T],Acc,L) :-
    NewH is H + 1,
    addto(T,[Acc|NewH],L).

reverse([],L,L).
reverse([H|T],Acc,L) :-
    reverse(T,[H|Acc],L).
