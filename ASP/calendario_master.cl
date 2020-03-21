%*
Le lezioni del master si svolgono il venerdì (8 ore) e il sabato (4 o 5 ore) nell’unica aula assegnata al Master, per 23 settimane.
Inoltre, sono previste due settimane full-time, la 7a e la 16a, con lezioni dal lunedì al sabato (8 ore al giorno da lunedì a venerdì, 4 o 5 ore al sabato)
*%

%dichiaro gli insegnanti
insegnante(muzzetto;pozzato;bloccolibero;prof1;prof2;prof3;prof4;prof5;prof6).

%dichiaro gli insegnamenti come insegnamento(nome,docente,oretotali)
insegnamento(project_management,muzzetto,14).
insegnamento(fondamenti_di_iCT_e_paradigmi_di_programmazione,pozzato,14).
insegnamento(bloccolibero,bloccolibero,4).
insegnamento(presentazioneCorso,presentazioneCorso,2).

insegnamento(prova1,prof1,14).
insegnamento(prova2,prof2,14).
insegnamento(prova3,prof3,14).
insegnamento(prova4,prof4,14).
insegnamento(prova5,prof5,14).
insegnamento(prova6,prof6,14).

%numero giorni totali assumendo che la prima sia un venerdì
%*giornata8(1;3;5;7;8;9;10;11;13;15;17;19;21;23;25;27;29;30;31;32;33;35;37;39;41;43;45;47).
giornata5(2;4;6;12;14;16;18;20;22;24;26;28;34;36;38;40;42;44;46;48).
giornata(1..48).*%
%*giornata8(1;3;5;7).
giornata5(2;4;6).
giornata(1..7).*%

giornata(1,8).
giornata(2,5).
giornata(3,8).
giornata(4,5).
giornata(5,8).
giornata(6,5).
giornata(7,8).

ore8(1..8).
ore5(1..5).


%ogni giorno da 8 ci devono essere 8 ore lezione
8 {lezione(Giornata,Professore,Insegnamento,Ora):insegnamento(Insegnamento,Professore,_), ore8(Ora)} 8 :- giornata(Giornata,8).

%ogni giorno da 5 ci devono essere 5 ore lezione
5 {lezione(Giornata,Professore,Insegnamento,Ora):insegnamento(Insegnamento,Professore,_), ore5(Ora)} 5 :- giornata(Giornata,5).

%in un giorno ad ogni ora ci deve essere solo 1 lezione
1 {lezione(Giornata,Professore,Insegnamento,Ora):insegnamento(Insegnamento,Professore,_)} 1 :- giornata(Giornata,_), ore8(Ora).
1 {lezione(Giornata,Professore,Insegnamento,Ora):insegnamento(Insegnamento,Professore,_)} 1 :- giornata(Giornata,_), ore5(Ora).

%lo stesso docente non può svolgere più di 4 ore di lezione in un giorno
{lezione(Giornata,Professore)} 4 :- giornata(Giornata,_),insegnante(Professore).

%*a ciascun insegnamento vengono assegnate minimo 2 e massimo 4 ore 
nello stesso giorno*%


%*il primo giorno di lezione prevede che, nelle prime due ore, vi sia la
presentazione del master*%
lezione(1,presentazioneCorso,presentazioneCorso,1).
lezione(1,presentazioneCorso,presentazioneCorso,2).



%*il calendario deve prevedere almeno 2 blocchi liberi di 2 ore ciascuno
per eventuali recuperi di lezioni annullate o rinviate*%
%4 {lezione(Giornata,bloccolibero,bloccolibero)} :- giornata(Giornata).

%*l’insegnamento “Project Management” deve concludersi non oltre la
prima settimana full-time*%

%*la prima lezione dell’insegnamento “Accessibilità e usabilità nella
progettazione multimediale” deve essere collocata prima che siano
terminate le lezioni dell’insegnamento “Linguaggi di markup”*%

#show lezione/4.