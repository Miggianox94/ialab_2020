import pandas as pd
import csv

#day,prof,insegnamento,ora
INPUT_DATA_FILE = 'test_doc.csv'


def testHoursDay(df, days, hoursexpected):
    for currday in days:
        if len(df[(df['day']==currday)]) != hoursexpected:
            print("Day ", currday, " hasn't", hoursexpected, " hours of lessons!")
            return False
    return True

def onelessonperhour(df):
    if len(df) > (32*8+24*5):
        print("There are more than one lesson per hour!")
        return False
    return True

def oneTeacherPerTopic(df):
    uniqueprof = df['prof'].nunique()
    uniqueinsegnamento = df['insegnamento'].nunique()
    if uniqueprof != 24 or uniqueinsegnamento != 28:
        print("uniqueprof != 24 or uniqueinsegnamento != 28")
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

def noMoreThanFourLessonsPerTeacher(df,teachers):
    groupedseries = df.groupby(['day','prof']).size()
    if (groupedseries > 4).any():
        print("Some teachers has more than 4 lesson in a day!")
        return False
    return True

def twoToFourHoursPerDay(df):
    df_copy = df.copy()
    df_copy = df_copy.drop(df_copy[df_copy.insegnamento == 'bloccolibero'].index)
    groupedseries = df_copy.groupby(['day','insegnamento']).size()
    if (groupedseries > 4 ).any():
        print("Some insegnamento has more than 4 hours in a day")
        return False
    if (groupedseries == 1 ).any():
        print("Some insegnamento has 1 hour in a day")
        print(groupedseries)
        return False
    return True

def checkFirstTwoDays(df):

    if (df.loc[(df['day'] == 1) & (df['ora'] == 1)].insegnamento != 'presentazioneCorso').all():
        print("First day is not presentazioneCorso")
        return False
    if (df.loc[(df['day'] == 1) & (df['ora'] == 2)].insegnamento != 'presentazioneCorso').all():
        print("Second day is not presentazioneCorso")
        return False
    return True

def checkBloccoLibero(df):
    if len(df.loc[df['insegnamento'] == 'bloccolibero']) <= 4:
        print("Not enough bloccolibero!")
        return False
    return True

def checkEndProjectManagement(df):
    if df.loc[df['insegnamento'] == 'project_management'].day.max() > 18:
        print("project_management finish after 18th day!")
        return False
    return True

def checkAccessibilitausabilita(df):
    if df.loc[df['insegnamento'] == 'linguaggi_di_markup'].day.max() < df.loc[df['insegnamento'] == 'accessibilita_usabilita_progettazione_multimediale'].day.min():
        print("Last lesson of linguaggi_di_markup before first of accessibilita_usabilita_progettazione_multimediale")
        return False
    return True

def checkpropedeuticita(df,propDict):
    for before in propDict:
        if df.loc[df['insegnamento'] == before].day.max() > df.loc[df['insegnamento'] == propDict.get(before)].day.min():
            print("propedeutico relationship not satisfacted!",before,df.loc[df['insegnamento'] == before].day.max(),"-->",propDict.get(before),df.loc[df['insegnamento'] == propDict.get(before)].day.min())
            return False
    return True

def runTests():
    df = pd.read_csv(INPUT_DATA_FILE,index_col=False, skipinitialspace=True)
    mystring = ''
    DAYSEIGHT = {1,3,5,7,9,11,13,14,15,16,17,19,21,23,25,27,29,31,33,35,36,37,38,39,41,43,45,47,49,51,53,55}
    DAYSFIVE = {2,4,6,8,10,12,18,20,22,24,26,28,30,32,34,40,42,44,46,48,50,52,54,56}
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
    TEACHERS = ["muzzetto", "pozzato", "gena", "tomatis", "micalizio", "terranova", "mazzei", "giordani", "zanchetta", "vargiu", "boniolo", "damiano", "suppini", "valle", "ghidelli", "gabardi", "santangelo", "taddeo", "gribaudo", "schifanella", "lombardo", "travostino", "bloccolibero", "presentazioneCorso"]
    PROPEDEUTICO = {
        "fondamenti_di_iCT_e_paradigmi_di_programmazione":"ambienti_sviluppo_linguaggi_clientsideweb",
        "ambienti_sviluppo_linguaggi_clientsideweb":"progettazione_sviluppo_applicazioni_web_mobile1",
        "progettazione_sviluppo_applicazioni_web_mobile1":"progettazione_sviluppo_applicazioni_web_mobile2",
        "progettazione_basi_dati":"tecnologie_server_side_web",
        "linguaggi_di_markup":"ambienti_sviluppo_linguaggi_clientsideweb",
        "project_management":"marketing_digitale",
        "marketing_digitale":"tecniche_strumenti_marketing_digitale",
        "project_management":"strumenti_metodi_interazione_social_media",
        "project_management":"progettazionegrafica_design_interfacce",
        "acquisizione_elaborazione_immagini_stat":"elementi_fotografia_digitale",
        "elementi_fotografia_digitale":"acquisizione_elaborazione_sequenze_immagini_digitali",
        "acquisizione_elaborazione_immagini_stat":"grafica_3d"
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
    oneTeacherPerTopic(df)

    #lo stesso docente non può svolgere più di 4 ore di lezione in un giorno
    noMoreThanFourLessonsPerTeacher(df,TEACHERS)

    #a ciascun insegnamento vengono assegnate minimo 2 e massimo 4 ore nello stesso giorno
    twoToFourHoursPerDay(df)

    #il primo giorno di lezione prevede che, nelle prime due ore, vi sia la presentazione del master
    checkFirstTwoDays(df)

    #il calendario deve prevedere almeno 2 blocchi liberi di 2 ore ciascun per eventuali recuperi di lezioni annullate o rinviate
    checkBloccoLibero(df)

    #l’insegnamento “Project Management” deve concludersi non oltre l prima settimana full-time
    checkEndProjectManagement(df)

    '''la prima lezione dell’insegnamento “Accessibilità e usabilità nella
    progettazione multimediale” deve essere collocata prima che siano
    terminate le lezioni dell’insegnamento “Linguaggi di markup”'''
    checkAccessibilitausabilita(df)

    #ogni insegnamento deve rispettare le propedeuticità
    checkpropedeuticita(df,PROPEDEUTICO)

if __name__ == "__main__":
    runTests()