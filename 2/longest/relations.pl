parent(kim, holly).
parent(margaret, kim).
parent(margaret, kent).
parent(esther, margaret).
parent(herbert, margaret).
parent(herbert, jean).

greatgrandparent(GGP, GGC) :-
    parent(GGP, GP),
    parent(GP, P),
    parent(P, GGC).
