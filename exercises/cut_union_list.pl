%Unione di due liste che rappresentano insiemi unione(A,B,Res) usando l'operatore cut
unione([],B,B).
unione([Head|Tail],B,Unione):-
    member(Head,B),
    !,
    unione(Tail,B,Unione).
unione([Head|Tail],B,[Head|Unione]):-
    unione(Tail,B,Unione).



