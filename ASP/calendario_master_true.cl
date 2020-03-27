%lanciare file con questa ottimizzazione --trans-ext=dynamic

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


%dichiaro le propedeuticità propedeutica(l1,l2) <--> l1 è propedeutica per l2

propedeutica(fondamenti_di_iCT_e_paradigmi_di_programmazione,ambienti_sviluppo_linguaggi_clientsideweb).
propedeutica(ambienti_sviluppo_linguaggi_clientsideweb,progettazione_sviluppo_applicazioni_web_mobile1).
propedeutica(progettazione_sviluppo_applicazioni_web_mobile1,progettazione_sviluppo_applicazioni_web_mobile2).
propedeutica(progettazione_basi_dati,tecnologie_server_side_web).
propedeutica(linguaggi_di_markup,ambienti_sviluppo_linguaggi_clientsideweb).
propedeutica(project_management,marketing_digitale).
propedeutica(marketing_digitale,tecniche_strumenti_marketing_digitale).
propedeutica(project_management,strumenti_metodi_interazione_social_media).
propedeutica(project_management,progettazionegrafica_design_interfacce).
propedeutica(acquisizione_elaborazione_immagini_stat,elementi_fotografia_digitale).
propedeutica(elementi_fotografia_digitale,acquisizione_elaborazione_sequenze_immagini_digitali).
propedeutica(acquisizione_elaborazione_immagini_stat,grafica_3d).


%numero giorni totali assumendo che la prima sia un venerdì
%*giornata8(1;3;5;7;8;9;10;11;13;15;17;19;21;23;25;27;29;30;31;32;33;35;37;39;41;43;45;47). =28 giorni
giornata5(2;4;6;12;14;16;18;20;22;24;26;28;34;36;38;40;42;44;46;48).= 20
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
giornata(12,5).
giornata(13,8).
giornata(14,5).
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

ore(1..8).


%ogni giorno da 8 ci devono essere 8 ore lezione
{lezione(Giornata,Professore,Insegnamento,Ora):insegnamento(Insegnamento,Professore,_), ore(Ora)} 8 :- giornata(Giornata,_).
:- {lezione(Giornata,Professore,Insegnamento,Ora):insegnamento(Insegnamento,Professore,_), ore(Ora)} < 8,giornata(Giornata,8).

%ogni giorno da 5 ci devono essere 5 ore lezione
:- not 5{lezione(Giornata,Professore,Insegnamento,Ora):insegnamento(Insegnamento,Professore,_), ore(Ora)}5,giornata(Giornata,5).


%in un giorno ad ogni ora ci deve essere solo 1 lezione
:- {lezione(Giornata,Professore,Insegnamento,Ora):insegnamento(Insegnamento,Professore,_)} > 1, giornata(Giornata,_), ore(Ora).

%tutti gli insegnamenti devono completare il monte ore
:- not Ore{lezione(Giornata,Professore,Insegnamento,Ora):giornata(Giornata,_),ore(Ora)}Ore, insegnamento(Insegnamento,Professore,Ore),Insegnamento!=bloccolibero.

%lo stesso docente non può svolgere più di 4 ore di lezione in un giorno
:- {lezione(Giornata,Professore,Insegnamento,Ora):insegnamento(Insegnamento,_,_),ore(Ora)} > 4, giornata(Giornata,_),insegnante(Professore).

%*a ciascun insegnamento vengono assegnate minimo 2 e massimo 4 ore 
nello stesso giorno*%
:- 1 {lezione(Giornata,Professore,Insegnamento,Ora):ore(Ora)} 1, giornata(Giornata,_),insegnamento(Insegnamento,Professore,_),Insegnamento!=bloccolibero.
:- {lezione(Giornata,Professore,Insegnamento,Ora):ore(Ora)} > 4, giornata(Giornata,_),insegnamento(Insegnamento,Professore,_),Insegnamento!=bloccolibero.

%*il primo giorno di lezione prevede che, nelle prime due ore, vi sia la
presentazione del master*%
lezione(1,presentazioneCorso,presentazioneCorso,1).
lezione(1,presentazioneCorso,presentazioneCorso,2).

%*il calendario deve prevedere almeno 2 blocchi liberi di 2 ore ciascuno
per eventuali recuperi di lezioni annullate o rinviate*%
:- {lezione(_,_,bloccolibero,_)} 3.

%*l’insegnamento “Project Management” deve concludersi non oltre la
prima settimana full-time*%
:- lezione(Giornata,_,project_management,_), Giornata > 11.

%*la prima lezione dell’insegnamento “Accessibilità e usabilità nella
progettazione multimediale” deve essere collocata prima che siano
terminate le lezioni dell’insegnamento “Linguaggi di markup”*%
:- Min=#min{Giornata:lezione(Giornata,_,accessibilita_usabilita_progettazione_multimediale,_)}, Max=#max{Giornata1:lezione(Giornata1,_,linguaggi_di_markup,_)}, Max > Min.


%ogni insegnamento deve rispettare le propedeuticità
:- UltimoPrima=#max{Giornata:lezione(Giornata,_,LezionePrima,_)}, PrimoDopo=#min{Giornata1:lezione(Giornata1,_,LezioneDopo,_)}, propedeutica(LezionePrima,LezioneDopo),UltimoPrima > PrimoDopo.

%-----------DA QUI INIZIANO I VINCOLI AUSPICABILI---------

%*la distanza tra la prima e l’ultima lezione di ciascun insegnamento non
deve superare le 6 settimane = 30 giorni*%
:- vincoloAttivo(0), Min=#min{Inizio:lezione(Inizio,_,Insegnamento,_)}, Max=#max{Fine:lezione(Fine,_,Insegnamento,_)}, Diff =(Max - Min), Diff > 30.



%*la prima lezione degli insegnamenti “Crossmedia: articolazione delle
scritture multimediali” e “Introduzione al social media management”
devono essere collocate nella seconda settimana full-time*%

:- vincoloAttivo(1), Min=#min{Inizio:lezione(Inizio,_,crossmedia_articolazione_scritture_multimediali,_)}, Min > 32.
:- vincoloAttivo(1), Min=#min{Inizio:lezione(Inizio,_,crossmedia_articolazione_scritture_multimediali,_)}, Min < 29.

:- vincoloAttivo(2), Min=#min{Inizio:lezione(Inizio,_,introduzione_social_media_management,_)}, Min > 32.
:- vincoloAttivo(2), Min=#min{Inizio:lezione(Inizio,_,introduzione_social_media_management,_)}, Min < 29.



%*
le lezioni dei vari insegnamenti devono rispettare le seguenti
propedeuticità:in particolare la prima lezione dell’insegnamento della
colonna di destra deve essere successiva alle prime 4 ore di lezione del
corrispondente insegnamento della colonna di sinistra
*%
:- vincoloAttivo(3), Destra=#min{Inizio:lezione(Inizio,_,progettazione_basi_dati,_)}, Sinistra=#min{Fine:lezione(Fine,_,fondamenti_di_iCT_e_paradigmi_di_programmazione,_)}, Destra <= Sinistra+4.
:- vincoloAttivo(4), Destra=#min{Inizio:lezione(Inizio,_,introduzione_social_media_management,_)}, Sinistra=#min{Fine:lezione(Fine,_,marketing_digitale,_)}, Destra <= Sinistra+4.
:- vincoloAttivo(5), Destra=#min{Inizio:lezione(Inizio,_,gestione_risorse_umane,_)}, Sinistra=#min{Fine:lezione(Fine,_,comunicazione_pubblicitaria_comunicazione_pubblica,_)}, Destra <= Sinistra+4.
:- vincoloAttivo(6), Destra=#min{Inizio:lezione(Inizio,_,progettazione_sviluppo_applicazioni_web_mobile1,_)}, Sinistra=#min{Fine:lezione(Fine,_,tecnologie_server_side_web,_)}, Destra <= Sinistra+4.



%*
la distanza fra l’ultima lezione di “Progettazione e sviluppo di applicazioni
web su dispositivi mobile I” e la prima di “Progettazione e sviluppo di
applicazioni web su dispositivi mobile II” non deve superare le due
settimane.*%
minAppWeb2(Min) :- Min=#min{Inizio:lezione(Inizio,_,progettazione_sviluppo_applicazioni_web_mobile2,_)}.
maxAppWeb1(Max) :- Max=#max{Fine:lezione(Fine,_,progettazione_sviluppo_applicazioni_web_mobile1,_)}.
:- vincoloAttivo(7),  minAppWeb2(Min), maxAppWeb1(Max), (Max-Min) > 10.


#show lezione/4.