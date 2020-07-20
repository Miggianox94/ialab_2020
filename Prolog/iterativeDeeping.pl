% init
init :- 
	retractall(livello(_)), 
	assert(livello(0)).

% https://www.swi-prolog.org/pldoc/man?predicate=dynamic/1
:- dynamic livello/1.

% iterativeDeeping(-Soluzione).
iterativeDeeping(Soluzione):-
	init,
	profonditaLimitataDEP(Soluzione),
	!, %non appena trovo il primo risultato mi fermo
	write('soluzione trovata: '),write(Soluzione).

% profonditaLimitataDEP(-Soluzione).
profonditaLimitataDEP(Soluzione):-
  livello(MaxDepth),
  iniziale(S),
  ric_prof_MaxDepthDEP(S,[S],MaxDepth,Soluzione).
  
% profonditaLimitataDEP(-Soluzione).  
profonditaLimitataDEP(Soluzione):-
  livello(MaxDepth),
  retractall(livello(_)),
  MaxDepth1 is MaxDepth + 1,
  assert(livello(MaxDepth1)),
  write('Provo con MaxDepth: '),write(MaxDepth1),nl,
  profonditaLimitataDEP(Soluzione).

% ric_prof_MaxDepthDEP(+S,_,_,[]).
% stoppo il backtracking se arrivo ad un nodo finale usando il cut
ric_prof_MaxDepthDEP(S,_,_,[]):-finale(S),!.

% ric_prof_MaxDepthDEP(+S,+Visitati,+MaxDepth,?[Azione|AltreAzioni])
ric_prof_MaxDepthDEP(S,Visitati,MaxDepth,[Azione|AltreAzioni]):-
  MaxDepth>0,
  applicabile(Azione,S),
  trasforma(Azione,S,SNuovo),
  \+member(SNuovo,Visitati),
  MaxDepth1 is MaxDepth-1,
  ric_prof_MaxDepthDEP(SNuovo,[SNuovo|Visitati],MaxDepth1,AltreAzioni).