%lanciare file con questa ottimizzazione --trans-ext=dynamic

%*
Le lezioni del master si svolgono il venerdì (8 ore) e il sabato (4 o 5 ore) nell’unica aula assegnata al Master, per 23 settimane.
Inoltre, sono previste due settimane full-time, la 7a e la 16a, con lezioni dal lunedì al sabato (8 ore al giorno da lunedì a venerdì, 4 o 5 ore al sabato)
*%

%dichiaro gli insegnanti
insegnante(muzzetto;pozzato;gena;tomatis;micalizio;terranova;mazzei;giordani;zanchetta;vargiu;boniolo;damiano;suppini;valle;ghidelli;gabardi;santangelo;taddeo;gribaudo;schifanella;lombardo;travostino;bloccolibero).

%dichiaro gli insegnamenti come insegnamento(nome,docente,oretotali)
insegnamento(project_management,muzzetto,4).
insegnamento(fondamenti_di_iCT_e_paradigmi_di_programmazione,pozzato,4).
insegnamento(linguaggi_di_markup,gena,2).

insegnamento(bloccolibero,bloccolibero,4).
insegnamento(presentazioneCorso,presentazioneCorso,2).


giornata(1,8).
giornata(2,5).
giornata(3,5).
giornata(4,5).
giornata(5,8).




ore(1..8).


%ogni giorno da 8 ci devono essere 8 ore lezione
8 {lezione(Giornata,Professore,Insegnamento,Ora):insegnamento(Insegnamento,Professore,_), ore(Ora)} 8 :- giornata(Giornata,8).


%ogni giorno da 5 ci devono essere 5 ore lezione
%5{lezione(Giornata,Professore,Insegnamento,Ora):insegnamento(Insegnamento,Professore,_), ore(Ora)}5 :- giornata(Giornata,5).
5 {lezione(Giornata,Professore,Insegnamento,Ora):insegnamento(Insegnamento,Professore,_), ore(Ora), Ora<6} 5 :- giornata(Giornata,5).



%in un giorno ad ogni ora ci deve essere solo 1 lezione
%:- {lezione(Giornata,Professore,Insegnamento,Ora):insegnamento(Insegnamento,Professore,_)} > 1, giornata(Giornata,_), ore(Ora).
{lezione(Giornata,Professore,Insegnamento,Ora):insegnamento(Insegnamento,Professore,_)} 1 :- giornata(Giornata,8), ore(Ora).
{lezione(Giornata,Professore,Insegnamento,Ora):insegnamento(Insegnamento,Professore,_)} 1 :- giornata(Giornata,5), ore(Ora), Ora<6.

%tutti gli insegnamenti devono completare il monte ore
:- not Ore{lezione(Giornata,Professore,Insegnamento,Ora):giornata(Giornata,_),ore(Ora)}Ore, insegnamento(Insegnamento,Professore,Ore),Insegnamento!=bloccolibero.


%lo stesso docente non può svolgere più di 4 ore di lezione in un giorno
%:- {lezione(Giornata,Professore,Insegnamento,Ora):insegnamento(Insegnamento,_,_),ore(Ora), Insegnamento!=bloccolibero} > 4, giornata(Giornata,_),insegnante(Professore).
{lezione(Giornata,Professore,Insegnamento,Ora):insegnamento(Insegnamento,_,_),ore(Ora), Insegnamento!=bloccolibero} 4 :- giornata(Giornata,_),insegnante(Professore).

%*a ciascun insegnamento vengono assegnate minimo 2 e massimo 4 ore 
nello stesso giorno*%
:- 1 {lezione(Giornata,Professore,Insegnamento,Ora):ore(Ora)} 1, giornata(Giornata,_),insegnamento(Insegnamento,Professore,_), Insegnamento!=bloccolibero.
:- {lezione(Giornata,Professore,Insegnamento,Ora):ore(Ora)} > 4, giornata(Giornata,_),insegnamento(Insegnamento,Professore,_), Insegnamento!=bloccolibero.
%2 {lezione(Giornata,Professore,Insegnamento,Ora):ore(Ora)} 4 :- insegnamento(Insegnamento,Professore,_),giornata(Giornata,_),Insegnamento!=bloccolibero.

%*il primo giorno di lezione prevede che, nelle prime due ore, vi sia la
presentazione del master*%
lezione(1,presentazioneCorso,presentazioneCorso,1).
lezione(1,presentazioneCorso,presentazioneCorso,2).

%*il calendario deve prevedere almeno 2 blocchi liberi di 2 ore ciascuno
per eventuali recuperi di lezioni annullate o rinviate*%
:- {lezione(_,bloccolibero,bloccolibero,_)} 3.



#show lezione/4.