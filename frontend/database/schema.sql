-- Tabell: Roller
CREATE TABLE Roller (
    rollID INT PRIMARY KEY,
    rollNamn VARCHAR(50) UNIQUE,
    beskrivning TEXT,
    behörighet_nivå INT
);

-- Tabell: Användare
CREATE TABLE Användare (
    anvID INT PRIMARY KEY,
    namn VARCHAR(255),
    epost VARCHAR(255) UNIQUE,
    lösenord_hash VARCHAR(255),
    rollID INT, -- FK to Roller.rollID
    aktiv BOOLEAN DEFAULT TRUE,
    skapadDatum DATETIME DEFAULT CURRENT_TIMESTAMP,
    senasteInlogg DATETIME,
    FOREIGN KEY (rollID) REFERENCES Roller(rollID)
);

-- Tabell: KostnadsställeGrupp
CREATE TABLE KostnadsställeGrupp (
    gruppID INT PRIMARY KEY,
    namn VARCHAR(255),
    överordnadGruppID INT,
    aktiv BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (överordnadGruppID) REFERENCES KostnadsställeGrupp(gruppID)
);

-- Tabell: Kostnadsställe
CREATE TABLE Kostnadsställe (
    ksID INT PRIMARY KEY,
    namn VARCHAR(255),
    kod VARCHAR(50),
    gruppID INT,
    chef_anvID INT,
    aktiv BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (gruppID) REFERENCES KostnadsställeGrupp(gruppID),
    FOREIGN KEY (chef_anvID) REFERENCES Användare(anvID)
);

-- Tabell: Projekt
CREATE TABLE Projekt (
    projektID INT PRIMARY KEY,
    namn VARCHAR(255),
    kostnadsställeID INT,
    startDatum DATE,
    slutDatum DATE,
    aktiv BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (kostnadsställeID) REFERENCES Kostnadsställe(ksID)
);

-- Tabell: BudgetVersion
CREATE TABLE BudgetVersion (
    versionID INT PRIMARY KEY,
    namn VARCHAR(255),
    typ VARCHAR(50), -- Budget, Prognos, Utfall
    år INT,
    låst BOOLEAN DEFAULT FALSE,
    skapadDatum DATETIME DEFAULT CURRENT_TIMESTAMP,
    skapadAv INT,
    FOREIGN KEY (skapadAv) REFERENCES Användare(anvID)
);

-- Tabell: BudgetPost
CREATE TABLE BudgetPost (
    postID INT PRIMARY KEY,
    versionID INT,
    kostnadsställeID INT,
    projektID INT,
    period VARCHAR(7), -- Format YYYY-MM
    kategori VARCHAR(255),
    värde DECIMAL(18, 2),
    kommentar TEXT,
    senastUppdaterad DATETIME DEFAULT CURRENT_TIMESTAMP,
    uppdateradAv INT,
    FOREIGN KEY (versionID) REFERENCES BudgetVersion(versionID),
    FOREIGN KEY (kostnadsställeID) REFERENCES Kostnadsställe(ksID),
    FOREIGN KEY (projektID) REFERENCES Projekt(projektID),
    FOREIGN KEY (uppdateradAv) REFERENCES Användare(anvID),
    CONSTRAINT chk_budgetpost_entity CHECK (kostnadsställeID IS NOT NULL OR projektID IS NOT NULL)
);

-- Tabell: Rättighet
CREATE TABLE Rättighet (
    rättighetID INT PRIMARY KEY,
    anvID INT,
    typ VARCHAR(50), -- "kostnadsställe", "grupp", "projekt"
    objektID INT, -- ksID, gruppID, or projektID
    läsbehörighet BOOLEAN DEFAULT TRUE,
    skrivbehörighet BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (anvID) REFERENCES Användare(anvID)
);

-- Tabell: ImportLogg
CREATE TABLE ImportLogg (
    importID INT PRIMARY KEY,
    anvID INT,
    typ VARCHAR(100), -- "Löner", "Utfall", "Budgetdata"
    filnamn VARCHAR(255),
    status VARCHAR(50), -- "OK", "Fel", "Delvis OK"
    radantal INT,
    felmeddelande TEXT,
    tidsstämpel DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (anvID) REFERENCES Användare(anvID)
);
