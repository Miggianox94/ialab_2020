%lanciare file con questa ottimizzazione --trans-ext=dynamic

%*
Le lezioni del master si svolgono il venerdì (8 ore) e il sabato (4 o 5 ore) nell’unica aula assegnata al Master, per 23 settimane.
Inoltre, sono previste due settimane full-time, la 7a e la 16a, con lezioni dal lunedì al sabato (8 ore al giorno da lunedì a venerdì, 4 o 5 ore al sabato)
*%

%dichiaro gli insegnanti
insegnante(muzzetto;pozzato;gena;tomatis;micalizio;terranova;mazzei;giordani;zanchetta;vargiu;boniolo;damiano;suppini;valle;ghidelli;gabardi;santangelo;taddeo;gribaudo;schifanella;lombardo;travostino;bloccolibero).
%insegnamento(project_management;fondamenti_di_iCT_e_paradigmi_di_programmazione;linguaggi_di_markup;la_gestione_della_qualita;ambienti_sviluppo_linguaggi_clientsideweb;progettazionegrafica_design_interfacce;progettazione_basi_dati;strumenti_metodi_interazione_social_media;acquisizione_elaborazione_immagini_stat;accessibilita_usabilita_progettazione_multimediale;marketing_digitale;elementi_fotografia_digitale;risorse_digitali_progetto_collaborazione_documentazione;tecnologie_server_side_web;tecniche_strumenti_marketing_digitale;introduzione_social_media_management;acquisizione_elaborazione_suono;acquisizione_elaborazione_sequenze_immagini_digitali;comunicazione_pubblicitaria_comunicazione_pubblica;semiologia_multimedialita;crossmedia_articolazione_scritture_multimediali;grafica_3d;progettazione_sviluppo_applicazioni_web_mobile1;progettazione_sviluppo_applicazioni_web_mobile2;gestione_risorse_umane;vincoli_giuridici_progetto;bloccolibero;presentazioneCorso).

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
8 {lezione(Giornata,Professore,Insegnamento,Ora):insegnamento(Insegnamento,Professore,_), ore(Ora)} 8 :- giornata(Giornata,8).

%ogni giorno da 5 ci devono essere 5 ore lezione
%5{lezione(Giornata,Professore,Insegnamento,Ora):insegnamento(Insegnamento,Professore,_), ore(Ora)}5 :- giornata(Giornata,5).
5 {lezione(Giornata,Professore,Insegnamento,Ora):insegnamento(Insegnamento,Professore,_), ore(Ora), Ora<6} 5 :- giornata(Giornata,5).




%in un giorno ad ogni ora ci deve essere solo 1 lezione
:- {lezione(Giornata,Professore,Insegnamento,Ora):insegnamento(Insegnamento,Professore,_)} > 1, giornata(Giornata,_), ore(Ora).
%{lezione(Giornata,Professore,Insegnamento,Ora):insegnamento(Insegnamento,Professore,_)} 1 :- giornata(Giornata,8), ore(Ora).
%{lezione(Giornata,Professore,Insegnamento,Ora):insegnamento(Insegnamento,Professore,_)} 1 :- giornata(Giornata,5), ore(Ora), Ora<6.

%tutti gli insegnamenti devono completare il monte ore
:- not Ore{lezione(Giornata,Professore,Insegnamento,Ora):giornata(Giornata,_),ore(Ora)}Ore, insegnamento(Insegnamento,Professore,Ore),Insegnamento!=bloccolibero.


%lo stesso docente non può svolgere più di 4 ore di lezione in un giorno
:- {lezione(Giornata,Professore,Insegnamento,Ora):insegnamento(Insegnamento,_,_),ore(Ora), Insegnamento!=bloccolibero} > 4, giornata(Giornata,_),insegnante(Professore).
%{lezione(Giornata,Professore,Insegnamento,Ora):insegnamento(Insegnamento,Professore,_),ore(Ora), Insegnamento!=bloccolibero} 4 :- giornata(Giornata,_),insegnante(Professore).

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