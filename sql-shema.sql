DROP TABLE IF EXISTS citizen CASCADE;
DROP TABLE IF EXISTS voter;
DROP TABLE IF EXISTS party CASCADE; 
DROP TABLE IF EXISTS candidate;
DROP TABLE IF EXISTS viceCandidate;
DROP TABLE IF EXISTS partyEmail; 
DROP TABLE IF EXISTS partyPhone;
DROP TABLE IF EXISTS usState CASCADE;
DROP TABLE IF EXISTS elector; 
DROP TABLE IF EXISTS pollingStation CASCADE; 
DROP TABLE IF EXISTS observer CASCADE;
DROP TABLE IF EXISTS observerPhone; 
DROP TABLE IF EXISTS boss;
DROP TABLE IF EXISTS observerAffilation;
 
CREATE TABLE citizen (
    id INTEGER PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    age INTEGER NOT NULL,
    zip CHAR(5) NOT NULL,
    city VARCHAR(30),
    street VARCHAR(100)
);
     
CREATE TABLE voter(
    sign VARCHAR(50) NOT NULL,
    name VARCHAR(50) NOT NULL,
    citizen INTEGER NOT NULL CONSTRAINT voter_fk_citizen REFERENCES citizen (id) 
        ON UPDATE CASCADE
        ON DELETE SET NULL,
    PRIMARY KEY (sign, name)
);
 
CREATE TABLE party (
    partyName VARCHAR(40) PRIMARY KEY
);
 
CREATE TABLE candidate (
    id INTEGER PRIMARY KEY CONSTRAINT candidate_fk_id REFERENCES citizen (id) 
        ON UPDATE CASCADE
        ON DELETE SET NULL,
    partyName VARCHAR(40)CONSTRAINT candidate_fk_partyName REFERENCES party (partyName)
);
 
CREATE TABLE viceCandidate (
    id INTEGER PRIMARY KEY CONSTRAINT viceCandidate_fk_id REFERENCES citizen (id) 
        ON UPDATE CASCADE
        ON DELETE SET NULL,
    partyName VARCHAR(40)CONSTRAINT viceCandidate_fk_partyName REFERENCES party (partyName)
);
 
CREATE TABLE partyPhone (
    party VARCHAR(40) NOT NULL,
    phone CHAR(9) NOT NULL,
    PRIMARY KEY (party, phone),
    CONSTRAINT partyPhone_fk_party FOREIGN KEY (party) REFERENCES party (partyName)
);
 
CREATE TABLE partyEmail (
    party VARCHAR(40) NOT NULL,
    email VARCHAR(100) NOT NULL,
    PRIMARY KEY (party, email),
    CONSTRAINT partyEmail_fk_party FOREIGN KEY (party) REFERENCES party (partyName),
    CONSTRAINT partyEmail_ch_email CHECK (email LIKE '_%@_%.__%')
);
 
CREATE TABLE usState (
    name VARCHAR(30) PRIMARY KEY,
    zip CHAR(5) NOT NULL UNIQUE,
    winningCandidate VARCHAR(30)
);
 
CREATE TABLE elector (
    id INTEGER PRIMARY KEY,
    usState VARCHAR(30) NOT NULL,
    vote VARCHAR(30),
    CONSTRAINT elector_fk_usState 
        FOREIGN KEY (usState) 
        REFERENCES usState (name)
        ON UPDATE CASCADE,
    CONSTRAINT elector_fk_id 
        FOREIGN KEY (id) 
        REFERENCES citizen (id)
        ON UPDATE CASCADE
        ON DELETE SET NULL
);
 
CREATE TABLE pollingStation (
    id INTEGER PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    usState VARCHAR(30) NOT NULL CONSTRAINT pollingStation_fk_usState REFERENCES usState (name)
);
 
CREATE TABLE observer (
    name VARCHAR(50) NOT NULL,
    pollingStation INTEGER NOT NULL CONSTRAINT observer_fk_pollingStation 
        REFERENCES pollingStation (id) 
        ON UPDATE CASCADE
        ON DELETE SET NULL,
    PRIMARY KEY (name, pollingStation)
);
 
CREATE TABLE observerPhone (
    observer VARCHAR(50) NOT NULL,
    phone CHAR(9) NOT NULL,
    pollingStation INTEGER NOT NULL,
    PRIMARY KEY (observer, phone),
    CONSTRAINT observerPhone_fk_observer_pollingStation 
        FOREIGN KEY (observer, pollingStation) 
        REFERENCES observer (name, pollingStation)
);
 
CREATE TABLE boss (
    observer VARCHAR(50) PRIMARY KEY,
    supervisor VARCHAR(50),
    pollingStation INTEGER NOT NULL,
    CONSTRAINT boss_fk_observer 
        FOREIGN KEY (observer, pollingStation) REFERENCES observer (name, pollingStation)
);
 
CREATE TABLE observerAffilation (
    partyName VARCHAR(40),
    pollingStation INTEGER NOT NULL,
    name VARCHAR(50) NOT NULL,
    PRIMARY KEY (name, pollingStation),
    CONSTRAINT observerAffilation_fk_partyName 
        FOREIGN KEY (partyName) REFERENCES party (partyName) 
        ON UPDATE CASCADE
        ON DELETE SET NULL,
    CONSTRAINT observerAffilation_fk_pollingStation_name 
        FOREIGN KEY (name, pollingStation) REFERENCES observer (name, pollingStation)
);