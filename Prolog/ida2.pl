% init
init2 :- 
  retractall(currentListOver(_)), 
	assert(currentListOver([])).


%lista degli f(n) degli n che hanno superato il depthlimit
:- dynamic currentListOver/1.


% ida(-Soluzione).
ida(Soluzione):-
  init2,
	iniziale(S),
	h(S,MaxDepth),
	profonditaLimitataIDA(nodo(S,0),MaxDepth,Soluzione),
	!, %non appena trovo il primo risultato mi fermo
  write('soluzione trovata: '),write(Soluzione),nl,
  length(Soluzione,LE),
  write('soluzione trovata lunghezza: '),write(LE).

% profonditaLimitataIDA(+nodo(S,G),+MaxDepth,-Soluzione).
profonditaLimitataIDA(nodo(S,G),MaxDepth,Soluzione):-
  write('Provo con MaxDepth: '),write(MaxDepth),nl,
  ric_prof_MaxDepthIDA(nodo(S,G),[S],MaxDepth,Soluzione).
 
%chiamato quando fallisce la chiamata precedente. Serve per fare la chiamata ricorsiva con la nuova depth 
% profonditaLimitataIDA(+S,_,-Soluzione). 
profonditaLimitataIDA(S,_,Soluzione):-
  currentListOver(CurrentListOver),
  %trovo il minimo tra quelli che hanno superato la soglia
  min_list(CurrentListOver,NexDepth),
  %length(CurrentListOver,LE),
  %write('CurrentListOver: '),write(LE),nl,
  retractall(currentListOver(_)), 
  assert(currentListOver([])),
  profonditaLimitataIDA(S,NexDepth,Soluzione).

% ric_prof_MaxDepthIDA(+nodo(S,_,_,_,[])).
ric_prof_MaxDepthIDA(nodo(S,_),_,_,[]):-finale(S),!.

% ric_prof_MaxDepthIDA(+nodo(S,G),+Visitati,+MaxDepth,?[Azione|AltreAzioni])
ric_prof_MaxDepthIDA(nodo(S,G),Visitati,MaxDepth,[Azione|AltreAzioni]):-
  MaxDepth>0,
  applicabile(Azione,S),
  trasforma(Azione,S,SNuovo),
  \+member(SNuovo,Visitati),
  MaxDepth1 is MaxDepth-1,
  g_funct(G,S,SNuovo,GNuovo),
  ric_prof_MaxDepthIDA(nodo(SNuovo,GNuovo),[SNuovo|Visitati],MaxDepth1,AltreAzioni).
 
% ric_prof_MaxDepthIDA(+nodo(S,G),_,+MaxDepth,_) 
ric_prof_MaxDepthIDA(nodo(S,G),_,MaxDepth,_):-
  \+MaxDepth>0,
	h(S,H),
	F is H+G,
	%faccio l'append della lista dei valori di f(n) che superano maxdepth
  currentListOver(CurrentListOver),
	retractall(currentListOver(_)), 
  assert(currentListOver([F|CurrentListOver])),
	fail.
