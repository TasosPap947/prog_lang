dynamic seen/2.

% seen.add(QS)
assert_seen(QS) :-
  term_hash(QS, Hash),
  assertz(seen(Hash, QS)).

% if seen(QS)
seen(QS) :-
  term_hash(QS, Hash),
  seen(Hash, QS).
