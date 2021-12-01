-- oppgave 1

CREATE TABLE tog(
  TogNr INT PRIMARY KEY UNIQUE NOT NULL,
  StartStasjon TEXT NOT NULL,
  EndeStasjon TEXT NOT NULL,
  AnkomstTid TIME NOT NULL
);

CREATE TABLE togTabell(
  TogNr INT UNIQUE NOT NULL,
  AvgangsTid TIME NOT NULL,
  Stasjon TEXT UNIQUE NOT NULL,

  PRIMARY KEY(TogNr, AvgangsTid)
  FOREIGN KEY(TogNr) REFERENCES tog(TogNr)

);

CREATE TABLE Plass(
  Dato DATE UNIQUE NOT NULL,
  TogNr INT UNIQUE NOT NULL,
  VognNr INT NOT NULL,
  PlassNr INT NOT NULL,
  Vindu BOOLEAN NOT NULL,
  Ledig BOOLEAN NOT NULL,

  PRIMARY KEY(Dato, TogNr, VognNr. PlassNr)
  FOREIGN KEY(TogNr) REFERENCES tog(TogNr)

);
