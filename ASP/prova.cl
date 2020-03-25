%lanciare file con questa ottimizzazione --trans-ext=dynamic

%*
Le lezioni del master si svolgono il venerdì (8 ore) e il sabato (4 o 5 ore) nell’unica aula assegnata al Master, per 23 settimane.
Inoltre, sono previste due settimane full-time, la 7a e la 16a, con lezioni dal lunedì al sabato (8 ore al giorno da lunedì a venerdì, 4 o 5 ore al sabato)
*%

%dichiaro gli insegnanti
insegnante(muzzetto;pozzato;gena;tomatis;micalizio;terranova;mazzei;giordani;zanchetta;vargiu;boniolo;damiano;suppini;valle;ghidelli;gabardi;santangelo;taddeo;gribaudo;schifanella;lombardo;travostino;bloccolibero).

%dichiaro gli insegnamenti come insegnamento(nome,docente,oretotali)
insegnamento(project_management,muzzetto,3).
insegnamento(fondamenti_di_iCT_e_paradigmi_di_programmazione,pozzato,5).
insegnamento(linguaggi_di_markup,gena,3).

insegnamento(bloccolibero,bloccolibero,4).


giornata(1,8).
giornata(2,5).




ore8(1..8).
ore5(1..5).


%ogni giorno da 8 ci devono essere 8 ore lezione
8 {lezione(Giornata,Professore,Insegnamento,Ora):insegnamento(Insegnamento,Professore,_), ore8(Ora)} 8 :- giornata(Giornata,8).

%ogni giorno da 5 ci devono essere 5 ore lezione --> todo: dovrei anche poterla togliere se sistemo la prima per essere indipendente dalle 8
5 {lezione(Giornata,Professore,Insegnamento,Ora):insegnamento(Insegnamento,Professore,_), ore5(Ora)} 5 :- giornata(Giornata,5).


%in un giorno ad ogni ora ci deve essere solo 1 lezione
1{lezione(Giornata,Professore,Insegnamento,Ora):insegnamento(Insegnamento,Professore,_)}1:- giornata(Giornata,8), ore8(Ora).
1{lezione(Giornata,Professore,Insegnamento,Ora):insegnamento(Insegnamento,Professore,_)}1 :- giornata(Giornata,5), ore5(Ora).

%tutti gli insegnamenti devono completare il monte ore
Ore {lezione(Giornata,Professore,Insegnamento,Ora):giornata(Giornata,_),ore8(Ora)} Ore :- insegnamento(Insegnamento,Professore,Ore),Insegnamento!=bloccolibero.

%ogni insegnamento deve essere tenuto da un solo docente
:- lezione(_,Professore1,Insegnamento,_), lezione(_,Professore2,Insegnamento,_), Professore1 != Professore2.



#show lezione/4.