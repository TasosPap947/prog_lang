% addto([],_,_).
% addto([H|T],V,L) :-
%   NewH is H+V,
%   append(Retl1,,Retl1),
%   addto(T,V,Retl2).

find_max([],Max) :- Max is 0.
find_max([H|T], Max) :-
    find_max(T, CurrMax),
    ( H > CurrMax -> Max is H
    ; Max is CurrMax
    ).

maxlist([],0).

maxlist([Head|Tail],Max) :-
    maxlist(Tail,TailMax),
    Head > TailMax,
    Max is Head.

maxlist([Head|Tail],Max) :-
    maxlist(Tail,TailMax),
    Head =< TailMax,
    Max is TailMax.

addto([],_,[]).
addto([H|T], n, L) :-
    L = CurrL,
    addto(T, n, CurrL),
    NewH is H+n,
    append([NewH],T,L).
