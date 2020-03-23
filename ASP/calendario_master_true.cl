%lanciare file con questa ottimizzazione --trans-ext=card

%*
Le lezioni del master si svolgono il venerdì (8 ore) e il sabato (4 o 5 ore) nell’unica aula assegnata al Master, per 23 settimane.
Inoltre, sono previste due settimane full-time, la 7a e la 16a, con lezioni dal lunedì al sabato (8 ore al giorno da lunedì a venerdì, 4 o 5 ore al sabato)
*%

%dichiaro gli insegnanti
insegnante(muzzetto;pozzato;gena;tomatis;micalizio;terranova;mazzei;giordani;zanchetta;vargiu;boniolo;damiano;suppini;valle;ghidelli;gabardi;santangelo;taddeo;gribaudo;schifanella;lombardo;travostino;bloccolibero).

%dichiaro gli insegnamenti come insegnamento(nome,docente,oretotali)
insegnamento(project_management,muzzetto,14).
insegnamento(fondamenti_di_iCT_e_paradigmi_di_programmazione,pozzato,14).
insegnamento(linguaggi_di_markup,gena,20).
insegnamento(la_gestione_della_qualita,tomatis,10).
insegnamento(ambienti_sviluppo_linguaggi_clientsideweb,micalizio,20).
insegnamento(progettazionegrafica_design_interfacce,terranova,10).
insegnamento(progettazione_basi_dati,mazzei,20).
insegnamento(strumenti_metodi_interazione_social_media,giordani,14).
insegnamento(acquisizione_elaborazione_immagini_stat,zanchetta,14).
insegnamento(accessibilita_usabilita_progettazione_multimediale,gena,14).
insegnamento(marketing_digitale,muzzetto,10).
insegnamento(elementi_fotografia_digitale,vargiu,10).
insegnamento(risorse_digitali_progetto_collaborazione_documentazione,boniolo,10).
insegnamento(tecnologie_server_side_web,damiano,20).
insegnamento(tecniche_strumenti_marketing_digitale,zanchetta,10).
insegnamento(introduzione_social_media_management,suppini,14).
insegnamento(acquisizione_elaborazione_suono,valle,10).
insegnamento(acquisizione_elaborazione_sequenze_immagini_digitali,ghidelli,20).
insegnamento(comunicazione_pubblicitaria_comunicazione_pubblica,gabardi,14).
insegnamento(semiologia_multimedialita,santangelo,10).
insegnamento(crossmedia_articolazione_scritture_multimediali,taddeo,20).
insegnamento(grafica_3d,gribaudo,20).
insegnamento(progettazione_sviluppo_applicazioni_web_mobile1,pozzato,10).
insegnamento(progettazione_sviluppo_applicazioni_web_mobile2,schifanella,10).
insegnamento(gestione_risorse_umane,lombardo,10).
insegnamento(vincoli_giuridici_progetto,travostino,10).

insegnamento(bloccolibero,bloccolibero,4).
insegnamento(presentazioneCorso,presentazioneCorso,2).




%numero giorni totali assumendo che la prima sia un venerdì
%*giornata8(1;3;5;7;8;9;10;11;13;15;17;19;21;23;25;27;29;30;31;32;33;35;37;39;41;43;45;47).
giornata5(2;4;6;12;14;16;18;20;22;24;26;28;34;36;38;40;42;44;46;48).
*%


giornata(1,8).
giornata(2,5).
giornata(3,8).
giornata(4,5).
giornata(5,8).
giornata(6,5).
giornata(7,8).
giornata(8,8).
giornata(9,8).
giornata(10,8).
giornata(11,8).
giornata(12,8).
giornata(13,8).
giornata(14,8).
giornata(15,8).
giornata(16,5).
giornata(17,8).
giornata(18,5).
giornata(19,8).
giornata(20,5).
giornata(21,8).
giornata(22,5).
giornata(23,8).
giornata(24,5).
giornata(25,8).
giornata(26,5).
giornata(27,8).
giornata(28,5).
giornata(29,8).
giornata(30,8).
giornata(31,8).
giornata(32,8).
giornata(33,8).
giornata(34,5).
giornata(35,8).
giornata(36,5).
giornata(37,8).
giornata(38,5).
giornata(39,8).
giornata(40,5).
giornata(41,8).
giornata(42,5).
giornata(43,8).
giornata(44,5).
giornata(45,8).
giornata(46,5).
giornata(47,8).
giornata(48,5).

ore8(1..8).
ore5(1..5).


%ogni giorno da 8 ci devono essere 8 ore lezione
8 {lezione(Giornata,Professore,Insegnamento,Ora):insegnamento(Insegnamento,Professore,_), ore8(Ora)} 8 :- giornata(Giornata,8).

%ogni giorno da 5 ci devono essere 5 ore lezione --> todo: dovrei anche poterla togliere se sistemo la prima per essere indipendente dalle 8
5 {lezione(Giornata,Professore,Insegnamento,Ora):insegnamento(Insegnamento,Professore,_), ore5(Ora)} 5 :- giornata(Giornata,5).

%in un giorno ad ogni ora ci deve essere solo 1 lezione
1 {lezione(Giornata,Professore,Insegnamento,Ora):insegnamento(Insegnamento,Professore,_)} 1 :- giornata(Giornata,_), ore8(Ora).
1 {lezione(Giornata,Professore,Insegnamento,Ora):insegnamento(Insegnamento,Professore,_)} 1 :- giornata(Giornata,_), ore5(Ora).

%tutti gli insegnamenti devono completare il monte ore
Ore {lezione(Giornata,Professore,Insegnamento,Ora):giornata(Giornata,_),ore8(Ora)} Ore :- insegnamento(Insegnamento,Professore,Ore), Insegnamento!=bloccolibero.

%ogni insegnamento deve essere tenuto da un solo docente
:- lezione(_,Professore1,Insegnamento1,_), lezione(_,Professore2,Insegnamento2,_), Professore1 != Professore2, Insegnamento1 == Insegnamento2.


%lo stesso docente non può svolgere più di 4 ore di lezione in un giorno
{lezione(Giornata,Professore,Insegnamento,Ora):insegnamento(Insegnamento,_,_),ore8(Ora)} 4 :- giornata(Giornata,_),insegnante(Professore).

%*a ciascun insegnamento vengono assegnate minimo 2 e massimo 4 ore 
nello stesso giorno*%
{lezione(Giornata,Professore,Insegnamento,Ora):ore8(Ora)} 4 :- insegnamento(Insegnamento,Professore,_), Insegnamento!=bloccolibero,giornata(Giornata,_).
:- 1 {lezione(Giornata,Professore,Insegnamento,Ora):ore8(Ora)} 1, giornata(Giornata,_),Insegnamento!=bloccolibero,insegnamento(Insegnamento,Professore,_).

%*il primo giorno di lezione prevede che, nelle prime due ore, vi sia la
presentazione del master*%
lezione(1,presentazioneCorso,presentazioneCorso,1).
lezione(1,presentazioneCorso,presentazioneCorso,2).



%*il calendario deve prevedere almeno 2 blocchi liberi di 2 ore ciascuno
per eventuali recuperi di lezioni annullate o rinviate*%
:- {lezione(Giornata,_,bloccolibero,Ora)} 3.

%*l’insegnamento “Project Management” deve concludersi non oltre la
prima settimana full-time*%
:- lezione(Giornata,_,project_management,_), Giornata > 11.

%*la prima lezione dell’insegnamento “Accessibilità e usabilità nella
progettazione multimediale” deve essere collocata prima che siano
terminate le lezioni dell’insegnamento “Linguaggi di markup”*%
:- #min{giornata(Giornata):lezione(Giornata,_,accessibilita_usabilita_progettazione_multimediale,_)}, #max{giornata(Giornata1):lezione(Giornata1,_,linguaggi_di_markup,_)}, Giornata1 > Giornata, giornata(Giornata1), giornata(Giornata).

#show lezione/4.