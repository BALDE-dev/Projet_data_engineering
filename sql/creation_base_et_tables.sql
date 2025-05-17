
-- SELECT name FROM sys.databases WHERE name = 'Gestion_notes_etudiants' vérifie si la base de données existe avant de la créer
IF NOT EXISTS (
SELECT name FROM sys.databases WHERE name = 'Gestion_notes_etudiants'
)
BEGIN
CREATE DATABASE Gestion_notes_etudiants;
END

GO
USE Gestion_notes_etudiants;

-- Vérifie que la table n'existe pas avant de la créer
IF OBJECT_ID ('dbo.Professeurs', 'U') IS NULL
BEGIN
CREATE TABLE Professeurs (
id_professeur INT PRIMARY KEY IDENTITY(1,1),
prenom_prof VARCHAR(45) not null,
nom_prof VARCHAR(45),
age INT,
email_prof VARCHAR(70) not null,
telephone_prof INT not null,
adresse_prof VARCHAR(45)
);
END

IF OBJECT_ID ('dbo.Cours', 'U') IS NULL
BEGIN
CREATE TABLE Cours (
id_cours INT PRIMARY KEY IDENTITY(1,1),
nom_cours VARCHAR(45) not null,
credit INT not null,
date_creation DATE,
description_cours TEXT,
semestre INT not null
);
END

IF OBJECT_ID ('dbo.Niveaux', 'U') IS NULL
BEGIN
CREATE TABLE Niveaux (
id_niveau INT PRIMARY KEY IDENTITY(1,1),
nom_niveau VARCHAR(45) not null,
description_niveau TEXT
);
END

IF OBJECT_ID ('dbo.Facultes', 'U') IS NULL
BEGIN
CREATE TABLE Facultes (
id_faculte INT PRIMARY KEY IDENTITY(1,1),
nom_faculte VARCHAR(100) not null,
date_creation DATE,
description_faculte TEXT
);
END

IF OBJECT_ID ('dbo.Filieres', 'U') IS NULL
BEGIN
CREATE TABLE Filieres (
id_filiere INT PRIMARY KEY IDENTITY(1,1),
id_faculte INT FOREIGN KEY REFERENCES facultes(id_faculte),
nom_filiere VARCHAR(100) not null,
date_creation DATE,
description_filiere TEXT
);
END

IF OBJECT_ID ('dbo.Etudiants', 'U') IS NULL
BEGIN
CREATE TABLE Etudiants (
id_etudiant INT  PRIMARY KEY IDENTITY(1,1),
id_niveau INT FOREIGN KEY REFERENCES niveaux(id_niveau),
id_filiere INT FOREIGN KEY REFERENCES filieres(id_filiere),
prenom_etudiant VARCHAR(45) not null,
nom_etudiant VARCHAR(45) not null,
date_naissance DATE,
email_etudiant VARCHAR(70),
adresse_etudiant VARCHAR(45)
);
END

IF OBJECT_ID ('dbo.Enseignement', 'U') IS NULL
BEGIN
CREATE TABLE Enseignement (
id_cours INT FOREIGN KEY REFERENCES cours(id_cours),
id_professeur INT FOREIGN KEY REFERENCES professeurs(id_professeur),
id_niveau INT FOREIGN KEY REFERENCES niveaux(id_niveau),
date_enseignement DATE,
heure VARCHAR(20),
duree VARCHAR(20)
);
END

IF OBJECT_ID ('dbo.Evaluation', 'U') IS NULL
BEGIN
CREATE TABLE Evaluation (
id_cours INT FOREIGN KEY REFERENCES cours(id_cours),
id_etudiant INT FOREIGN KEY REFERENCES etudiants(id_etudiant),
note FLOAT not null,
date_evaluation DATE,
type_evaluation VARCHAR(45) not null
);
END

IF OBJECT_ID ('dbo.Programme', 'U') IS NULL
BEGIN
CREATE TABLE Programme (
id_filiere INT FOREIGN KEY REFERENCES filieres(id_filiere),
id_cours INT FOREIGN KEY REFERENCES cours(id_cours)
);
END
