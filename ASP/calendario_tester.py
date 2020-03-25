import pandas as pd
import csv

#day,prof,insegnamento,ora
INPUT_DATA_FILE = 'test_doc.csv'

def testHoursDay(df,days,hoursexpected):
    for currday in days:
        if len(df[(df['day']==currday)]) != hoursexpected:
            print("Day ",currday," hasn't",hoursexpected," hours of lessons!")
            return False
    return True

def onelessonperhour(df):
    if len(df) > 48*8:
        print("There are more than one lesson per hour!")
        return False
    return True

def allMonteOre(df,monteoredays):
    for currInsegnamento in monteoredays:
        if currInsegnamento == 'bloccolibero' and len(df[(df['insegnamento']==currInsegnamento)]) < monteoredays.get(currInsegnamento):
            print("bloccolibero han't completed its hours of lessons")
            return False
        if currInsegnamento!='bloccolibero' and len(df[(df['insegnamento']==currInsegnamento)]) != monteoredays.get(currInsegnamento):
            print("Insegnamento ",currInsegnamento," hasn't completed",monteoredays.get(currInsegnamento)," hours of lessons!")
            return False
    return True

def runTests():
    df = pd.read_csv(INPUT_DATA_FILE,index_col=False, skipinitialspace=True)
    mystring = ''
    DAYSEIGHT = {1,3,5,7,8,9,10,11,13,15,17,19,21,23,25,27,29,30,31,32,33,35,37,39,41,43,45,47}
    DAYSFIVE = {2,4,6,12,14,16,18,20,22,24,26,28,34,36,38,40,42,44,46,48}
    INSEGNAMENTI_ORE= {
        "project_management":14,
        "fondamenti_di_iCT_e_paradigmi_di_programmazione":14,
        "linguaggi_di_markup":20,
        "la_gestione_della_qualita":10,
        "ambienti_sviluppo_linguaggi_clientsideweb":20,
        "progettazionegrafica_design_interfacce":10,
        "progettazione_basi_dati":20,
        "strumenti_metodi_interazione_social_media":14,
        "acquisizione_elaborazione_immagini_stat":14,
        "accessibilita_usabilita_progettazione_multimediale":14,
        "marketing_digitale":10,
        "elementi_fotografia_digitale":10,
        "risorse_digitali_progetto_collaborazione_documentazione":10,
        "tecnologie_server_side_web":20,
        "tecniche_strumenti_marketing_digitale":10,
        "introduzione_social_media_management":14,
        "acquisizione_elaborazione_suono":10,
        "acquisizione_elaborazione_sequenze_immagini_digitali":20,
        "comunicazione_pubblicitaria_comunicazione_pubblica":14,
        "semiologia_multimedialita":10,
        "crossmedia_articolazione_scritture_multimediali":20,
        "grafica_3d":20,
        "progettazione_sviluppo_applicazioni_web_mobile1":10,
        "progettazione_sviluppo_applicazioni_web_mobile2":10,
        "gestione_risorse_umane":10,
        "vincoli_giuridici_progetto":10,
        "bloccolibero":4,
        "presentazioneCorso":2
        }

    '''
    with open(INPUT_DATA_FILE, 'rb') as csvfile:
        reader = csv.reader(csvfile, delimiter=',')
        for row in reader:
            mystring.join(row)
    '''
    
    #ogni giorno da 8 ci devono essere 8 ore lezione
    testHoursDay(df,DAYSEIGHT,8)

    #ogni giorno da 5 ci devono essere 5 ore lezione
    testHoursDay(df,DAYSFIVE,5)

    #in un giorno ad ogni ora ci deve essere solo 1 lezione
    onelessonperhour(df)

    #tutti gli insegnamenti devono completare il monte ore
    allMonteOre(df,INSEGNAMENTI_ORE)

    #ogni insegnamento deve essere tenuto da un solo docente

    #lo stesso docente non può svolgere più di 4 ore di lezione in un giorno

    #a ciascun insegnamento vengono assegnate minimo 2 e massimo 4 ore nello stesso giorno

    #il primo giorno di lezione prevede che, nelle prime due ore, vi sia la presentazione del master

    #il calendario deve prevedere almeno 2 blocchi liberi di 2 ore ciascun per eventuali recuperi di lezioni annullate o rinviate

    #l’insegnamento “Project Management” deve concludersi non oltre l prima settimana full-time

    '''la prima lezione dell’insegnamento “Accessibilità e usabilità nella
    progettazione multimediale” deve essere collocata prima che siano
    terminate le lezioni dell’insegnamento “Linguaggi di markup”'''

    #ogni insegnamento deve rispettare le propedeuticità

if __name__ == "__main__":
    runTests()