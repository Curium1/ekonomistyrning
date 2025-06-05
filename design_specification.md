Budget- och prognosverktyg – Designspecifikation

Ett modernt digitalt verktyg för budgetering och prognos kan avsevärt förenkla ekonomiprocesserna i en organisation. För företag är användningen av rätt budget-, prognos- och uppföljningsverktyg avgörande för effektiv styrning – det skapar struktur och transparens i planeringen ￼. Många upplever frustration med att hantera budgetar i Excel och gamla system som hämmar effektiviteten ￼. Därför utformas detta React-baserade budgetverktyg (med lokal SQL-databas) för att erbjuda en användarvänlig Excel-liknande upplevelse med stöd för flera delbudgetar och integrerad rapportering, allt inom samma system ￼. Nedan följer wireframes för huvudsidorna, ett databasschema och en omfattande produktbeskrivning av sidor, funktioner, komponenter och användarflöden.

1. Wireframes för huvudsidor

(Wireframeskisserna nedan illustrerar layout och huvudelement för varje central sida i applikationen.)

Dashboard (Översiktssida)
	•	Layout: En översiktspanel med viktiga nyckeltal högst upp och diagram nedanför. Exempelvis kan KPI-cards visas i en övre sektion (t.ex. Total försäljning, Totala kostnader, Resultat), följt av en rad diagram. Sidan har även en toppmeny med filtrering (t.ex. val av år och budgetversion) och en sidomeny för navigering mellan moduler.
	•	Innehåll: Stapel- och linjediagram presenterar utfall vs budget per månad, kumulativt resultat över året, etc. Under diagrammen kan en sammanfattande tabell visas (t.ex. per kostnadsställegrupp eller projekt) för att ge detaljinformation. Varje användare ser bara data för de enheter de har behörighet till, men alla ser sin aggregerade totalsumma i KPI:erna.
	•	Interaktivitet: Dashboardens grafer är interaktiva – att hovra eller klicka på ett diagram kan visa detaljer eller låta användaren drilla ner till en rapport för specifika siffror. Det finns även filterdropdowns (t.ex. välj Budget 2024 vs Prognos Q2) som uppdaterar alla visuella element.

Budgetredigerare (Excel-liknande inmatning)
	•	Layout: En huvudsida för budgetinmatning med en tab-navigering eller dropdown för olika budgettyper: Försäljningsbudget, Kostnadsställebudget och Projektbudget. Ovanför datagriden finns verktygsknappar (Spara, Ångra, Gör om, Exportera, etc.) samt eventuellt en formelfält liknande Excel för att skriva enklare formler.
	•	Datagrid: Huvudområdet utgörs av en redigerbar tabell (datagrid) där rader kan representera t.ex. konton eller objekt och kolumner representerar perioder (månader Q1–Q4 eller Jan–Dec) samt totaler. Användaren kan klicka i celler och direkt mata in värden eller formler (t.ex. “=SUM(Jan:Mar)” för ett Q1-belopp). Celler stödjer autofyll genom dra-och-släpp i hörnet – likt Excel kan man dra i cellens hörn för att kopiera eller fylla en serie.
	•	Försäljningsbudget: Om denna flik är vald visas t.ex. rader för olika produktgrupper eller marknader med kolumner Jan–Dec. Användaren (ofta försäljningschef) fyller i intäkter per månad. Formler kan användas för att beräkna t.ex. Pris * Volym om systemet stödjer det, eller heltal kan fyllas i manuellt.
	•	Kostnadsställebudget: Visar kostnader per kostnadsställe. Varje rad kan motsvara en kostnadskategori (t.ex. Personal, Drift, Marknadsföring) eller total kostnadsbudget för det kostnadsstället. Om detaljer per konto inte planeras kan raden helt enkelt vara “Totalkostnad”. Chefer skriver in sina budgeterade kostnader per månad. Kostnadsställen är hierarkiskt grupperade, så grupper av kostnadsställen kan summeras för helår. Gränssnittet kan visuellt gruppera rader eller erbjuda en vy där man byter mellan enskilt kostnadsställe och gruppnivå (t.ex. en dropdown för att välja en kostnadsställegrupp).
	•	Projektbudget: Liknar kostnadsställe-fliken men listar projekt (investeringar) som rader. Varje projekt har en budget över tid – ofta fördelad per kvartal eller år istället för månadsvis om projekten är få, men verktyget kan tillåta månadsvis fördelning här också. Projekt kan ha start- och slutdatum; gränssnittet kan då gråmarkera utanför projektets tidsram. Projektägare (chefer eller controllers) kan här budgetera investeringskostnader per period.
	•	Funktioner: Alla tre budgettyper delar funktionalitet för direktredigering i celler, stöd för enkla formler (referenser inom samma blad, t.ex. summor, procentökningar) och autofyll. Användaren kan kopiera/klistra in områden från Excel vid behov. Ogiltiga inmatningar markeras tydligt. Det finns en Spara-knapp (eller auto-spar vid varje ändring, med indikator). Versionshantering gör att användaren alltid redigerar i valt scenario (t.ex. Budget 2025 eller Prognos 2025-Q3). Endast användare med skrivbehörighet (t.ex. ansvarig chef eller controller) kan ändra siffror; andra ser cellerna som låsta/läsbara.
	•	Export/Import: På redigeringssidan finns även en Exportera till Excel-knapp för att ladda ner nuvarande vy (med eventuella filtreringar) som en Excel-fil. För användare med rätt behörighet finns också en Importera Excel-knapp eller menyval (t.ex. controllers kan här initiera import av t.ex. lönelistor direkt in i budgeten för personal-kostnader – se Importfunktion nedan).

Rapportvyer (Uppföljning och analys)
	•	Layout: En rapportsida med valbara vyer/rapporter i en meny eller fliksystem. Exempelvis kan det finnas en Resultatrapport, en Avvikelseanalys och en Detaljrapport. I toppen finns filter (tidsperiod, version, kostnadsställe/projekt, etc.) samt knappar för export (Excel/PDF).
	•	Innehåll – Resultatrapport: Visar t.ex. en tabell över Budget vs Utfall vs Avvikelse per månad och totalt, för valda enheter. Om utfallsdata (realisationsdata) finns inläst kan dessa visas jämte budget. Rader kan vara kontogrupper (Intäkter, Kostnader, osv.) och kolumner månader och helår. Färgmarkeringar kan lyfta fram positiva eller negativa avvikelser.
	•	Innehåll – Avvikelseanalys: En variant av rapport som fokuserar på differenser mellan olika versioner. T.ex. Prognos vs Budget eller Budget vs Föregående år. Visas kanske som en tabell eller ett diagram. Användaren kan här välja två versioner att jämföra.
	•	Innehåll – Detaljrapport/drilldown: Om man från en högre nivå (t.ex. Dashboard eller resultatrapport) klickar på ett värde kan man nå en detaljerad rapport. Den kan visa transaktionsdetaljer eller underliggande poster som summan består av, om sådana finns (t.ex. specifika projekt under en kostnadsställegrupp).
	•	Interaktivitet: Rapportvyerna stödjer drill-down och filtrering. Användaren kan t.ex. gruppera eller detaljera nivåer (likt pivottabell-funktion: grupper efter kostnadsställegrupp eller expandera för att se varje kostnadsställe). Endast data som användaren har rätt att se inkluderas. Rapporter kan också ha diagram inbäddade för visualisering (t.ex. pajdiagram över kostnadsfördelning).
	•	Export: Varje rapportvy har en exportfunktion – främst Excel (för vidare analys i Excel om önskat) och även PDF för att kunna dela eller skriva ut snyggt formaterade rapporter.

Accesskontroll (Användare & Rättigheter)
	•	Layout: En administrativ sida för att hantera användarkonton, roller och behörigheter. Sidan kan vara indelad i flikar eller sektioner: Användare, Roller och Tilldelningar/Behörigheter.
	•	Användarhantering: Här listas alla användare i systemet i en tabell med kolumner som Namn, E-post, Roll, Senast inloggad, etc. Admin kan lägga till ny användare (knapp Ny användare som öppnar ett formulär för namn, e-post, lösenord, val av roll). Det finns även möjlighet att redigera eller inaktivera användare. Rollen (Admin, Ekonomichef, Controller, Chef, Användare) kan väljas från en dropdown i formuläret.
	•	Roller: En översikt över de roller som finns, med beskrivningar av respektive rollens rättigheter. Troligen är dessa roller fasta (ej många nya roller behövs), men om redigering tillåts kan admin här ändra behörighetsinställningar per roll (t.ex. vilka moduler eller åtgärder rollen har tillgång till). Alternativt är rollen statisk och sidan bara informativ.
	•	Behörighetstilldelning: Detta avsnitt hanterar vilka enheter (kostnadsställen, kostnadsställegrupper, projekt) en användare får se. En typisk UI är en tabell eller lista grupperad per användare eller per enhet. Exempel: Man kan välja en användare och se alla kostnadsställen/kostnadsställegrupper den har tillgång till, och lägga till eller ta bort tillgång via flervalslistor eller trädstruktur. Kanske finns en hierarkisk trädvy över alla kostnadsställegrupper och underliggande kostnadsställen, där admin kan checka i vilka noder användaren ska ha tillgång till. En användare kan ha flera tilldelningar – t.ex. flera kostnadsställen och/eller en hel grupp.
	•	Spara & Verifiera: Efter ändringar finns en spara-knapp. Systemet kan också ha en Testa behörighet-funktion där admin kan kontrollera att en viss användare ser rätt data (t.ex. “visa som användare”).

Import & Export-funktioner
	•	Importfunktion: Import sker huvudsakligen via Excel-filer. En särskild Importera dialog eller sida låter t.ex. en controller ladda upp Excel med fördefinierad mall. Användaren väljer fil, anger typ av data att importera (t.ex. Lönekostnader per person, Utfallsdata per konto, Budgettal för massimport). Det kan finnas en guide: steg 1 – ladda upp fil, steg 2 – förhandsgranska mapping (mappa kolumner i Excel till fält i databasen, om inte exakt mall), steg 3 – bekräfta import. Efter import visas en sammanfattning: antal rader inlästa, eventuella fel (t.ex. okända kostnadsställen). Resultatet loggas i Importlogg (åtkomlig kanske som en tabell under Import-sidan eller i admin-sektionen) där man kan se historik av importer, tidpunkt, användare och status.
	•	Exportfunktion: Export till Excel finns, som nämnt, på relevanta sidor (främst Budgetredigerare och Rapportvyer). Vid export genereras en Excel-fil som antingen motsvarar skärmens data (vad man ser är vad man får), eller en mer omfattande export beroende på kontext (t.ex. hela budgetversionen). PDF-export kan erbjudas för rapporter och eventuellt för budgetformulär (om man vill skriva ut budgetarna). Exportknappen öppnar antingen en dialog där man väljer format (Excel/PDF) och eventuell rapportmall, eller laddar ner direkt i standardformat (Excel).
	•	Övrigt: Systemet kan också stödja schemalagd export (t.ex. att skicka ut en PDF-rapport månadsvis), men huvudsakligen sker export on-demand via användarens klick.

(Obs: Alla wireframes ovan är konceptuella och fokuserar på struktur och flöde, inte slutlig grafisk design.)

2. Databasschema

Nedan definieras ett föreslaget databasschema som stödjer användare, roller, kostnadsställen, budgetdata, versioner, rättigheter och importlogg. Schemat är anpassat för en SQL-databas. Tabeller och relationer beskrivs här:
	•	Användare – lagrar kontoinformation för varje användare.
	•	Roller – listar de olika rollerna och deras egenskaper.
	•	Kostnadsställe – innehåller alla kostnadsställen (avdelningar/enheter) i organisationen.
	•	KostnadsställeGrupp – definierar grupper av kostnadsställen (t.ex. divisioner eller högre aggregat) för rapportering på helårsnivå.
	•	Projekt – lista över projekt för vilka projektbudgetar görs.
	•	BudgetVersion – olika versioner av budget/prognos (t.ex. Budget 2025, Prognos Q2 2025).
	•	BudgetPost – lagrar själva budgetvärden (belopp) per dimension (kostnadsställe/projekt, period, version, etc.).
	•	Rättighet – kopplingstabell som ger användare behörighet till specificerade kostnadsställen eller grupper.
	•	ImportLogg – loggar historik av datainläsningar via import.

Följande tabeller visar detaljer för respektive entitet:

Tabell: Användare

Fält	Datatyp	Beskrivning
anvID	INT (PK)	Unikt ID för användare
namn	VARCHAR	Användarens fullständiga namn
epost	VARCHAR	Inloggningsmejl (unik)
lösenord_hash	VARCHAR	Hashat lösenord för autentisering
roll	VARCHAR	Rollnamn eller roll-ID (FK till Roller)
aktiv	BOOL	Om kontot är aktivt (för att ev. inaktivera)
skapadDatum	DATETIME	När kontot skapades
senasteInlogg	DATETIME	Timestamp för senaste inloggning

Kommentar: En användare tilldelas en av de fördefinierade rollerna (Admin, Ekonomichef, Controller, Chef eller Användare). Roll kan lagras som text eller som en främmande nyckel till en Roller-tabell.

Tabell: Roller

Fält	Datatyp	Beskrivning
rollID	INT (PK)	Unikt ID för roll (om används istället för namn som nyckel)
rollNamn	VARCHAR	T.ex. “Admin”, “Ekonomichef”, “Controller”, “Chef”, “Användare”
beskrivning	TEXT	Beskrivning av rollens behörighet (t.ex. Admin = full tillgång)
behörighet_nivå	INT	Hierarkisk nivå (t.ex. 1=högst/Admin … 5=lägst/Användare)

Kommentar: Roller kan antingen användas som uppslagsdata (där rollNamn refereras direkt i Användare) eller via rollID som FK. I ett enkelt system kan man lagra roll som text i Användare och inte behöva en separat tabell, men en tabell ger flexibilitet för framtida anpassning.

Tabell: Kostnadsställe

Fält	Datatyp	Beskrivning
ksID	INT (PK)	Unikt ID för kostnadsställe
namn	VARCHAR	Namn på kostnadsställe (t.ex. “IT-avdelningen”)
kod	VARCHAR	Eventuell kod/nummer för kostnadsstället (om företaget har kodplan)
gruppID	INT (FK)	Referens till KostnadsställeGrupp som kostnadsstället tillhör
chef_anvID	INT (FK)	Referens till Användare (chef/ansvarig för kostnadsstället)
aktiv	BOOL	Om kostnadsstället är aktivt (för att ej radera historiska)

Kommentar: Varje kostnadsställe kan tillhöra en KostnadsställeGrupp (fält gruppID). Detta möjliggör gruppering av budgetar för helårssammanställningar. Fältet chef_anvID kan användas för att veta vem som är ansvarig (inte nödvändigt för behörighet, men bra för info/notifieringar).

Tabell: KostnadsställeGrupp

Fält	Datatyp	Beskrivning
gruppID	INT (PK)	Unikt ID för kostnadsställegrupp
namn	VARCHAR	Gruppens namn (t.ex. “Division A” eller “Alla admin-avd”)
överordnadGruppID	INT (FK)	Om grupper är hierarkiska: ID för eventuell över-grupp
aktiv	BOOL	Om gruppen är aktiv

Kommentar: Kostnadsställegrupper kan antingen vara platta (ingen hierarki, då överordnadGruppID ej används) eller hierarkiska om man exempelvis vill gruppera grupper. I många fall räcker en nivå (t.ex. divisioner). Grupper används för att ge behörighet på aggregerad nivå och för rapportering (summera alla kostnadsställen i gruppen).

Tabell: Projekt

Fält	Datatyp	Beskrivning
projektID	INT (PK)	Unikt ID för projekt
namn	VARCHAR	Projektnamn eller beskrivning
kostnadsställeID	INT (FK)	Referens till Kostnadsställe som projektet hör till (om varje projekt ägs av en avdelning)
startDatum	DATE	Projektets startdatum (valfritt)
slutDatum	DATE	Projektets slutdatum (valfritt)
aktiv	BOOL	Om projektet är aktivt/aktuellt

Kommentar: Projektbudgeten kan kopplas till ett kostnadsställe för att ärva behörighet – dvs om en chef har tillgång till kostnadsställe X så ser hen även projekt under X. Alternativt hanteras projektbehörighet separat (i Rättighet-tabellen, se nedan).

Tabell: BudgetVersion

Fält	Datatyp	Beskrivning
versionID	INT (PK)	Unikt ID för budget/prognos-version
namn	VARCHAR	Namn på version (t.ex. “Budget 2025”, “Prognos Q2-2025”)
typ	VARCHAR	Typ av version (t.ex. Budget, Prognos, Utfall). Kan även vara enum/flagga.
år	INT	Avser år (t.ex. 2025). Kan vara NULL om version sträcker sig över flera år.
låst	BOOL	Om versionen är låst för redigering (t.ex. fastställd budget)
skapadDatum	DATETIME	När versionen skapades
skapadAv	INT (FK)	Användar-ID som skapade versionen

Kommentar: Versioner gör att systemet kan hantera flera omgångar av budget/prognos. T.ex. en årlig budget och löpande prognoser. Fältet typ kan vara användbart för logik (t.ex. särskilja utfallsdata eller olika scenarion). låst markeras när en budget är fastslagen så att endast överordnade (CFO/Admin) kan ändra eller ingen alls.

Tabell: BudgetPost

Fält	Datatyp	Beskrivning
postID	INT (PK)	Unikt ID för budgetpost (rad)
versionID	INT (FK)	Referens till BudgetVersion som denna post tillhör
kostnadsställeID	INT (FK)	Referens till Kostnadsställe (om posten är kopplad till ett kostnadsställe)
projektID	INT (FK)	Referens till Projekt (om posten är kopplad till ett projekt)
period	VARCHAR	Tidsperiod för värdet (t.ex. “2025-01” eller “Jan 2025” – kan standardiseras som ÅÅÅÅMM)
kategori	VARCHAR	Kategori/konto för posten (t.ex. “Intäkt”, “Personalkostnad”). Kan ersättas med kontonummer om en kontoplan används.
värde	DECIMAL	Budgeterat belopp för angiven kategori, period, enhet
kommentar	TEXT	Valfri kommentar/anteckning till posten (t.ex. anteckning om beräkning)
senastUppdaterad	DATETIME	Senaste ändringens tidpunkt
uppdateradAv	INT (FK)	Användar-ID som senast uppdaterade posten

Kommentar: BudgetPost lagrar de numeriska värdena. Varje rad representerar t.ex. ett belopp för en viss kostnad eller intäkt, ett visst kostnadsställe/projekt, en viss period och version. Antingen fylls kostnadsställeID eller projektID i (den som är relevant för posten, den andra kan vara NULL). kategori kan vara budgettypens underindelning – för försäljningsbudget kanske det är intäktskategori, för kostnadsbudget en kostnadstyp, för projekt kanske investeringskategori. Om detaljerad kontoplan inte behövs kan man sätta alla poster för t.ex. kostnadsställebudget utan kontodelning (då kanske kategori endast är “Total” eller liknande). Period kan vara månadsvis (vilket är vanligast för budget) – t.ex. “2025-01” för Jan 2025. Alternativt kan man ha separata fält år=2025 och månad=1, eller en period-nyckel till en kalenderdimensionstabell. För enkelhet är en period-text/nummer direkt i tabellen okej.

Tabell: Rättighet

Fält	Datatyp	Beskrivning
rättighetID	INT (PK)	Unikt ID för rättighetsrad
anvID	INT (FK)	Referens till Användare som rättigheten gäller
typ	VARCHAR	Typ av objekt: "kostnadsställe" eller "grupp" (eller "projekt")
objektID	INT	ID på objektet (kostnadsställeID eller gruppID eller projektID beroende på typ)
läsbehörighet	BOOL	Indikerar läsrätt (True som standard, d.v.s. de får se)
skrivbehörighet	BOOL	Indikerar om användaren får redigera detta objekt

Kommentar: Denna tabell kopplar användare till de enheter de har behörighet till. Om typ = “kostnadsställe” används objektID för att peka på en post i Kostnadsställe. Om typ = “grupp”, pekar objektID på *KostnadsställeGrupp. (Eventuellt kan även typ = “projekt” förekomma om man vill ge specifik projektåtkomst separat). En användare kan ha flera rader här (flera tilldelade enheter). I de flesta fall kommer skrivbehörighet vara True för t.ex. chefer på sina kostnadsställen, medan controllers kan ha skrivbehörighet på många/allt. Läsa kan de flesta på det de är tilldelade. Admin har implicit full behörighet och kanske behöver inte finnas i denna tabell alls för alla enheter. Rader i Rättighetstabellen kan skapas antingen manuellt via Accesskontroll-gränssnittet eller automatiskt (t.ex. när man sätter en chef på ett kostnadsställe kan systemet ge den användaren rättighet till det kostnadsstället).

Tabell: ImportLogg

Fält	Datatyp	Beskrivning
importID	INT (PK)	Unikt ID för en importhändelse
anvID	INT (FK)	Referens till Användare som utförde importen
typ	VARCHAR	Typ av import (t.ex. “Löner”, “Utfall”, “Budgetdata”)
filnamn	VARCHAR	Namn på den importerade filen
status	VARCHAR	Resultatstatus (“OK”, “Fel”, “Delvis OK” etc.)
radantal	INT	Antal rader/importposter lästa
felmeddelande	TEXT	Felinfo om status ej OK (t.ex. vilka rader som misslyckades)
tidsstämpel	DATETIME	Tidpunkt för importen

Kommentar: ImportLogg registrerar alla importer för spårbarhet. Vid en lyckad import sätts status = “OK” och radantal = antal poster som lagts in/uppdaterats. Vid fel fylls felmeddelande med beskrivning (eller lämnas tomt vid fullständig framgång). Administratörer eller controllers kan granska loggen för att se att importer gått rätt till.

Relationer mellan tabellerna:
	•	Användare – Roller: En-till-många (varje användare har en roll). Implementeras via Användare.roll = Roller.rollNamn eller Roller.rollID.
	•	Kostnadsställe – KostnadsställeGrupp: Många-till-ett (flera kostnadsställen kan tillhöra en grupp). Kostnadsställe.gruppID → KostnadsställeGrupp.gruppID.
	•	Projekt – Kostnadsställe: Många-till-ett (projekt kan kopplas till kostnadsställe). Projekt.kostnadsställeID → Kostnadsställe.ksID.
	•	BudgetPost – BudgetVersion: Många-till-ett. Varje budgetpost hör till en version.
	•	BudgetPost – Kostnadsställe/Projekt: Varje post antingen till ett kostnadsställe eller ett projekt (alternativt kan man ha två tabeller BudgetPost_KS och BudgetPost_Projekt, men här hålls de i en med valfri koppling).
	•	Rättighet – Användare: Många-till-ett (en användare kan ha många rättighetsrader).
	•	Rättighet – Kostnadsställe/KostnadsställeGrupp/Projekt: Många-till-ett beroende på typ (en rättighetsrad knyter en användare till ETT objekt).
	•	ImportLogg – Användare: Många-till-ett (flera importhändelser per användare).

Diagram över schemat (förenklat):

Användare (anvID PK, roll FK, ...) ——< Rättighet >—— Kostnadsställe (ksID PK, gruppID FK, ...)
           |                           |__ KostnadsställeGrupp (gruppID PK)
           |                           \__ (Projekt (projektID PK, kostnadsställeID FK))
           \__ Roller (rollID PK)
BudgetVersion (versionID PK) ——< BudgetPost (postID PK, versionID FK, kostnadsställeID FK, projektID FK, ...)
Användare ——< ImportLogg (importID PK, anvID FK, ...)

(PK = Primärnyckel, FK = Främmande nyckel)

3. Produktbeskrivning

I detta avsnitt beskrivs samtliga sidor i applikationen, deras syfte och funktionalitet, de huvudsakliga komponenterna på varje sida, samt hur användare med olika roller förväntas navigera och använda systemet (användarflöde).

Sidöversikt och komponenter

Nedan listas alla huvudsidor med respektive funktioner och viktiga UI-komponenter:
	•	Dashboard (Översikt): Startsidans dashboard ger en sammanfattning av organisationens läge. Funktioner: Visar nyckeltal (KPI:er) som total intäkt, kostnad, resultat osv. Visar diagram som jämför budget med utfall eller prognos över tid. Tillåter filtrering per år och version (budget/prognos). Användaren ser endast siffror aggregerat för sina behöriga enheter. Komponenter: KPI-visare (kort för nyckeltal), diagramkomponenter (stapeldiagram för månadsvisa värden, linjediagram för trend), filtreringsmenyer (dropdowns för år, version), navigationsmeny. Eventuellt också notiser (t.ex. “Deadline för budgetinlämning är 31/10”).
	•	Budgetredigerare: Huvudsida för att mata in och uppdatera budget- och prognossiffror. Funktioner: Låter användaren växla mellan olika budgettyper – Försäljning, Kostnadsställe, Projekt – och redigera siffror i en grid per månad. Stödjer grundläggande formler (summering, procentberäkning) direkt i celler samt autofyll. Val av aktuell version (t.ex. Budget 2025 eller en prognos) för inmatning. Möjlighet att spara ändringar och köra export/import. Komponenter: Tab-navigering eller toggle för budgettyper, datagrid (tabellkomponent med redigerbara celler, stödjer scrollning och frysta rubriker), formelfält (visar/redigerar cellinnehåll, valfritt om integrerat i datagridens celler), knapprad (Spara, Ångra, Beräkna om, Exportera Excel, Importera), eventuellt verktygstips och valideringsmeddelanden vid fel inmatning.
	•	Försäljningsbudget-fliken: Inmatning av intäkter. Möjlighet att lägga in total försäljning eller uppdelat per t.ex. produkt/region (beroende på implementering). Komponenter: Samma datagrid, men rader/kolumner är konfigurerade för försäljningsdata.
	•	Kostnadsställebudget-fliken: Inmatning av kostnader per kostnadsställe. Komponenter: Datagrid med rader för kostnadskategorier per kostnadsställe. Ovan grid kan finnas en dropdown för att välja kostnadsställe eller kostnadsställegrupp om endast en visas åt gången; alternativt en hierarkisk visning i raderna. Summeringsrader per grupp kan visas i fet stil.
	•	Projektbudget-fliken: Inmatning av budget för investeringar/projekt. Komponenter: Datagrid där varje rad motsvarar ett projekt. Kolumner per period (ofta år eller kvartal för översikt, eller månader om detaljerat). Möjlighet att filtrera projektlista (om många projekt) via ett sökfält.
	•	Rapportvyer: En eller flera sidor för att analysera och följa upp utfall mot budget. Funktioner: Ger dynamiska rapporter som användaren kan anpassa via filter. Standardrapporten kan vara en resultatrapport som jämför budget, utfall och prognos. Andra rapporter kan inkludera avvikelseanalys, trender, eller en pivottabell-liknande vy där användaren själv väljer dimensioner (kostnadsställe, konto, period). Komponenter: Filterpanel (datumintervall, version, enhetsval etc.), rapporttabell (icke-redigerbar datagrid eller pivot-komponent som visar beräknade värden), diagram (valbart, för att visualisera rapportdata), knappar för Exportera (Excel/PDF) och ev. Uppdatera (för att hämta ny data efter filterändring). Om drill-down stöds finns klickbara celler eller expandera/collapsa-funktion i tabellen.
	•	Accesskontroll: Administrativ sida för användar- och behörighetshantering. Funktioner: Låter admin skapa/ändra användare och styra vilka data de får se eller redigera. Komponenter: Användartabell (lista befintliga användare med kolumner och actions för redigera/radera), formulärmodal för ny/redigera användare (inputfält för namn, e-post, lösenord, roll, etc.), rättighetshantering UI (t.ex. en trädvy över kostnadsställe-strukturen med checkboxar per användare, eller en matrix där rader = användare, kolumner = enheter, kryss för access). Knappar: Spara ändringar, Lägg till användare, Lägg till rättighet. Eventuellt en separat flik för rollbeskrivningar (om roller ska kunna konfigureras).
	•	Import/Export: (Även om exportknappar finns på andra sidor, kan det finnas en dedikerad sida eller dialog för import.) Funktioner: Tillåter import av Excel-mallar för att automatisera inmatning av t.ex. personalbudget eller utfallsdata. Visar också en logg av tidigare importer. Komponenter: Importera-dialog: filuppladdningsfält, dropdown för datatyp, förhandsgranskningstabell av uppladdade data (valfritt), knapp Kör import. Importlogg-vy: tabell över ImportLogg med senaste importerna, filtrerbar per typ eller datum. Export är som nämnt främst implementerat som knappar på relevanta sidor men kan också ha en central sida om man vill erbjuda t.ex. mass-export av alla rapporter.

Användarroller och behörighet (vem ser/gör vad)
	•	Admin: Har full åtkomst till systemets alla delar. Administratören ansvarar för att lägga upp användare, tilldela roller och behörigheter via Accesskontroll-sidan. Admin kan skapa nya budgetversioner (t.ex. initiera “Budget 2026”) i systemet, antingen via ett gränssnitt (kan vara på Dashboard eller en speciell inställningssida). Admin kan också justera systeminställningar. I användarflödet är admin ofta aktiv i början (upprättar struktur) och underhåll (hanterar nya användare, justerar rättigheter vid organisationsförändringar).
	•	Ekonomichef (CFO): Har också i princip åtkomst till all data (hela organisationens siffror), men fokuserar på det ekonomiska helhetsperspektivet. Ekonomichefen använder främst Dashboard för översikt och Rapportvyer för detaljer/analys. CFO kan göra justeringar i budget på hög nivå (t.ex. finjustera totalresultat eller vissa nyckeltal) via Budgetredigeraren – kanske i övergripande versioner eller genom att gå in på respektive chefs siffror om systemet tillåter det. CFO kan låsa upp/låsa budgetversioner, starta prognosomgångar och exportera rapporter till PDF för styrelserapportering. Denna roll kan även använda importfunktionen för att ladda in utfallsdata månadsvis, om det not inte sker automatiskt.
	•	Controller: Har en central roll i budgetprocessen. Controllern har åtkomst till all relevant data (kanske allt, eller åtminstone flera kostnadsställen/projekt enligt sin funktion). Hen förbereder budgetomgången – t.ex. genom att skapa budgetversionen (om inte admin gör det), importera lönelistor och annan fördelningsdata i början som underlag för cheferna. Controllern använder Budgetredigeraren för att se över och eventuellt justera siffror som chefer matar in (kan ha rättighet att skriva över vid behov). Controllern följer upp att alla chefer har fyllt i sina delar (systemet kan visa status per kostnadsställe, t.ex. % ifyllt eller markerar vilka som är klara). Controllern använder Rapportvyer för att konsolidera budgeten och göra analyser, samt Dashboard för översikt. I accesskontrollen kan controllern ges behörighet likt CFO, eller något snävare om företaget vill segmentera (men ofta har controllers bred behörighet). Controllers är också typiska mottagare/användare av Importlogg-informationen för att felsöka om något data saknas efter import.
	•	Chef (linjechef/avdelningsansvarig): Har begränsad åtkomst – ser bara sitt eget kostnadsställe (och eventuella underenheter/projekt de ansvarar för). Chefen loggar in och använder framförallt Budgetredigeraren på Kostnadsställe-fliken för att fylla i sin avdelnings budget. Om chefen även ansvarar för intäkter (t.ex. försäljningschef) kan de också använda Försäljningsbudget-delen. Chefen kan navigera till Dashboard för att se sammanfattning av just sin enhet (t.ex. utfallet hittills och budget), och till Rapportvyer för att se mer detaljerad uppföljning av sitt kostnadsställe (t.ex. månadsrapport). Cheferna har skrivbehörighet på sina egna enheter, så de kan ändra siffror där, men de kan inte ändra andra enheters data. De kan oftast inte importera/exportera utöver att ladda ner Excel för sina egna siffror om de vill (Export-knappen på budgetredigeraren för dem exporterar bara deras data).
	•	Användare (övrig användare): Denna roll har troligast lägst behörighet. Kanske Användare är en läs-roll – t.ex. vissa personer kan få läsa budgetar för en viss kostnadsställegrupp utan att vara chef. En användare kan då logga in, se Dashboard (med begränsad insyn, kanske bara KPI:er för deras avdelning), och köra Rapportvyer på läsnivå. De kan eventuellt inte redigera alls i Budgetredigeraren, eller så har de ett avgränsat redigeringsansvar (det beror på hur organisationen definierar denna roll; ibland kan “Användare” vara någon som föreslår siffror men inte ansvarar – men här antar vi det är läsande). Användare kan nyttja export av de rapporter de kan se. Import och admin-funktioner är inte tillgängliga för dem.

Exempel: Användarflöde genom systemet

För att belysa hur systemet kan användas i praktiken, följer här ett typiskt scenario från start av en budgetcykel till uppföljning:
	1.	Initial setup (Admin): Administratören loggar in först och navigerar till Accesskontroll. Där lägger hen upp alla relevanta användare – t.ex. skapar konton för Ekonomichef, controllers och chefer – och tilldelar dem roller. Admin ser till att kostnadsställehierarkin och projektlistan är korrekt upplagd i systemet (detta kan ske via en import av masterdata eller manuellt i databasen; om gränssnitt finns för det, görs det här). Admin skapar också en ny BudgetVersion för kommande året, t.ex. “Budget 2026”, via ett gränssnitt (möjligen i Dashboard eller en särskild Inställningar sida).
	2.	Förberedelser (Controller): Controllern får i uppgift att förbereda underlag. Hen loggar in och väljer rätt version (Budget 2026). Via Importfunktion laddar controllern upp en Excel-lista med alla anställdas löner och fördelning per kostnadsställe. Systemet importerar detta och uppdaterar budgetposterna för personalkostnader för varje kostnadsställe automatiskt. Controllern kontrollerar i Importlogg att importen lyckats (status OK, X rader inlästa). Hen kan nu gå till Budgetredigeraren, välja Kostnadsställebudget-fliken och se att varje kostnadsställe fått förifyllda värden för personalkostnader (låsta eller redigerbara beroende på hur man valt att hantera det). Detta sparar tid för cheferna och ökar precisionen.
	3.	Budgetinmatning (Chef/Användare): När budgetperioden öppnat får varje avdelningschef en uppgift att fylla i sin budget. En Chef-användare (t.ex. IT-chefen) loggar in. För henom visas efter inlogg en anpassad Dashboard där nyckeltal initialt kan vara tomma eller visa föregående års utfall som referens. IT-chefen går till Budgetredigeraren -> Kostnadsställebudget. Där väljer hen sitt kostnadsställe (om inte redan filtrerat automatiskt). Hen ser rader för olika kostnadsslag – Personalkostnader kan redan vara ifyllda från import, hyreskostnader kanske förifylldes centralt eller är tom. Hen fyller i sina övriga driftkostnader per månad. För att spara tid använder hen Excel-liknande funktioner: t.ex. skriver in 10000 i Jan och drar cellens hörn åt höger till Dec för att kopiera samma värde hela året, eller skriver en formel i total-kolumnen som summerar månadsbeloppen (systemet kan dock automatiskt summera om total-kolumnen är beräknad). I försäljningschefens fall skulle hen istället gå till Försäljningsbudget-fliken och fylla i intäkter per produkt. Under inmatningen kanske chefen vill anta en ökning på 5% varje månad – hen kan då i en tom hjälpkolumn använda formler, eller helt enkelt beräkna externt och klistra in värden. Systemet kan också ha en enkel funktion för “öka med X%” över markering, vilket sparar tid.
	4.	Spara och iterera: Chefen klickar Spara med jämna mellanrum; varje gång uppdateras värdena i databasen för den versionen. Om hen gör fel (t.ex. anger en formel felaktigt), systemet visar ett felmeddelande. När avdelningens siffror är ifyllda (eller deadline nås) markerar chefen sig som klar (antingen genom att systemet automatiskt noterar att alla obligatoriska fält är ifyllda, eller via en knapp “Markera som färdig”). Chefen kan nu titta på Rapportvy – t.ex. en resultatrapport filtrerad på sitt kostnadsställe – för att se en sammanställning av sin egen budget och kanske jämföra mot föregående år. Hen kan också använda Exportera-knappen om hen vill ladda ner siffrorna till Excel för eget arkiv.
	5.	Konsolidering (Controller/CFO): Under och efter att chefer matar in övervakar controllers processen. I Dashboard eller en särskild översiktssida kan controllern se vilka enheter som är klara och eventuellt skicka påminnelser till de som ej är färdiga (denna funktionalitet kan vara utanför systemet – t.ex. genom att se status och maila dem manuellt). När alla har fyllt i, granskar controllern budgeten i sin helhet: går in på Rapportvyer, väljer Resultatrapport för Budget 2026 och ser totalsummor per kostnadsställegrupp och totalt. Hen kan drilla ner i rapporten för att se detaljer per kostnadsställe och kontotyp. Om något sticker ut (t.ex. en avdelning har orimligt hög kostnad) kan controllern justera direkt i Budgetredigeraren (om rollen tillåter skrivning överallt) eller kontakta chefen för förtydliganden. Efter eventuell finjustering låser controllern eller CFO budgetversionen (ändrar flagga låst i systemet via en kontroll i UI).
	6.	Beslutsunderlag (CFO): Ekonomichefen tar fram övergripande rapporter för ledningen. CFO använder Dashboard för att snabbt se det budgeterade resultatet och kanske göra en sista sanity check. Därefter går CFO till Rapportvyer och drar ut en jämförelse mellan Budget 2026 och Utfall 2025 för att se till att budgeten ligger i linje med historiska siffror. Med några klick exporterar CFO en PDF-rapport med de viktigaste tabellerna och graferna (alternativt exporterar till Excel och skapar en presentation). Detta underlag delas med VD och styrelse.
	7.	Året pågår – uppföljning (Alla): När året 2026 startar och månader går, importerar controllern faktiskt utfall (realisationsbokföring) varje månad via Importfunktion (typ “Utfall per konto”). Dashboarden och rapporterna börjar då visa utfall vs budget. Chefer kan logga in efter varje månadsbokslut och via Rapportvyer se hur de ligger till mot budget. Systemet fortsätter att begränsa insynen – de ser bara sina egna resultat mot sin budget. Om företaget gör prognoser under året, kan Admin/Controller skapa en ny BudgetVersion (t.ex. “Prognos Q2 2026”). Chefer får då instruktion att uppdatera siffror för resterande månader. De loggar in, byter version i Budgetredigeraren till Prognos Q2 2026 och fyller i nya prognossiffror (ofta utfall för redan passerade månader är låsta och man justerar endast framtida månader). Denna process liknar budgetrundan, om än på kortare tid och med fokus på avvikelser. Rapporter kan därefter jämföra prognos mot ursprungsbudget och utfall.
	8.	Löpande administration: Under hela denna cykel kan Importlogg-sidan användas av admin/controller för att se att alla data har kommit in korrekt. Accesskontroll kan behöva uppdateras – t.ex. om en chef slutar mitt i processen och en ny tar över, admin byter behörighet för det kostnadsstället till den nya chefen. Systemet är robust så att historiska budgetar fortfarande kopplas till den gamla chefen i loggar, men nye chefen får åtkomst att ändra framåt.
	9.	Sammanfattning: Genom dessa flöden hjälper verktyget organisationen att automatisera och effektivisera budget- och prognosarbetet, minska manuell handpåläggning och fel, samt ge bättre överblick och delaktighet i processen ￼. Resultatet blir att användarna på olika nivåer får ett anpassat gränssnitt där de enkelt kan bidra med sin del, och ledningen får ett kvalitetssäkrat underlag för beslut.
