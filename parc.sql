CREATE TABLE IF NOT EXISTS ETAT (
	NumeroEtat INTEGER NOT NULL,
	Libelle CHAR(50) NOT NULL,
	PRIMARY KEY (NumeroEtat)
) ENGINE = InnoDB ;

CREATE TABLE IF NOT EXISTS INSTALLATION (
	NumeroInstallation INTEGER NOT NULL,
	Nom CHAR(50) NOT NULL,
	HeureOuverture INTEGER NOT NULL,
	HeureFermeture INTEGER NOT NULL,
	NumeroEtat INTEGER NOT NULL,
	Cout INTEGER NOT NULL,
	CHECK (HeureOuverture >= 0 AND HeureOuverture <= 23),
	CHECK (HeureFermeture >= 0 AND HeureFermeture <= 23),
	CHECK (HeureOuverture < HeureFermeture),
	CHECK (Cout >= 0),
	FOREIGN KEY (NumeroEtat) REFERENCES ETAT(NumeroEtat),
	PRIMARY KEY (NumeroInstallation)
) ENGINE = InnoDB ;

CREATE TABLE IF NOT EXISTS ATTRACTION (
	NumeroInstallation INTEGER NOT NULL,
	Capacite INTEGER NOT NULL,
	TempsAttente TIME NOT NULL,
	NombreVisiteursHeure INTEGER NOT NULL,
	CHECK (Capacite >= 0),
	CHECK (NombreVisiteursHeure >= 0),
	FOREIGN KEY (NumeroInstallation) REFERENCES INSTALLATION(NumeroInstallation) ON DELETE CASCADE,
	PRIMARY KEY (NumeroInstallation)
) ENGINE = InnoDB ;

CREATE TABLE IF NOT EXISTS MAGASIN (
	NumeroInstallation INTEGER NOT NULL,
	Revenus INTEGER NOT NULL,
	CHECK (Revenus >= 0),
	FOREIGN KEY (NumeroInstallation) REFERENCES INSTALLATION(NumeroInstallation) ON DELETE CASCADE,
	PRIMARY KEY (NumeroInstallation)
) ENGINE = InnoDB ;

CREATE TABLE IF NOT EXISTS RESTAURANT (
	NumeroInstallation INTEGER NOT NULL,
	Revenus INTEGER NOT NULL,
	Capacite INTEGER NOT NULL,
	CHECK (Revenus >= 0),
	CHECK (Capacite >= 0),
	FOREIGN KEY (NumeroInstallation) REFERENCES INSTALLATION(NumeroInstallation) ON DELETE CASCADE,
	PRIMARY KEY (NumeroInstallation)
) ENGINE = InnoDB ;

CREATE TABLE IF NOT EXISTS EMPLOYE (
	NumeroEmploye INTEGER NOT NULL,
	Nom CHAR(50) NOT NULL,
	Prenom CHAR(50) NOT NULL,
	Salaire INTEGER NOT NULL,
	NumeroInstallation INTEGER NOT NULL,
	CHECK (Salaire >= 1300),
	FOREIGN KEY (NumeroInstallation) REFERENCES INSTALLATION(NumeroInstallation) ON DELETE CASCADE,
	PRIMARY key (NumeroEmploye)
) ENGINE = InnoDB ;

CREATE TABLE IF NOT EXISTS PRODUIT (
	NumeroProduit INTEGER NOT NULL,
	Nom CHAR(50) NOT NULL,
	Prix INTEGER NOT NULL,
	PRIMARY KEY (NumeroProduit)
) ENGINE = InnoDB ;

CREATE TABLE IF NOT EXISTS FOURNISSEUR (
	NumeroFournisseur INTEGER NOT NULL,
	Nom CHAR(20) NOT NULL,
	PRIMARY KEY (NumeroFournisseur)
) ENGINE = InnoDB ;

CREATE TABLE IF NOT EXISTS RESERVATION (
	NumeroReservation INTEGER NOT NULL,
	DateResa DATE NOT NULL,
	NombrePersonnes INTEGER NOT NULL,
	NumeroInstallation INTEGER NOT NULL,
	CHECK (DateResa >= CURDATE()),
	CHECK (NombrePersonnes > 0),
	FOREIGN KEY (NumeroInstallation) REFERENCES RESTAURANT(NumeroInstallation) ON DELETE CASCADE,
	PRIMARY KEY (NumeroReservation)
) ENGINE = InnoDB ;

CREATE TABLE IF NOT EXISTS VENDRE (
	NumeroProduit INTEGER NOT NULL,
	NumeroInstallation INTEGER NOT NULL,
	Quantite INTEGER NOT NULL,
	CHECK (Quantite >= 0),
	PRIMARY KEY (NumeroProduit,NumeroInstallation),
	FOREIGN KEY (NumeroProduit) REFERENCES PRODUIT(NumeroProduit) ON DELETE CASCADE,
	FOREIGN KEY (NumeroInstallation) REFERENCES MAGASIN(NumeroInstallation) ON DELETE CASCADE
)  ENGINE = InnoDB ;

CREATE TABLE IF NOT EXISTS FOURNIR (
	NumeroProduit INTEGER NOT NULL,
	NumeroInstallation INTEGER NOT NULL,
	NumeroFournisseur INTEGER NOT NULL,
	PRIMARY KEY (NumeroProduit,NumeroInstallation,NumeroFournisseur),
	FOREIGN KEY (NumeroProduit) REFERENCES PRODUIT(NumeroProduit) ON DELETE CASCADE,
	FOREIGN KEY (NumeroInstallation) REFERENCES MAGASIN(NumeroInstallation) ON DELETE CASCADE,
	FOREIGN KEY (NumeroFournisseur) REFERENCES FOURNISSEUR(NumeroFournisseur) ON DELETE CASCADE
) ENGINE = InnoDB ;

/* -- non valide en mysql 2, mais valide pour la version 5.5.27
ALTER TABLE ATTRACTION ADD CHECK ( NumeroInstallation IN ( SELECT NumeroInstallation FROM INSTALLATION ) AND NOT NumeroInstallation IN ( SELECT NumeroInstallation FROM MAGASIN ) AND NOT NumeroInstallation IN ( SELECT NumeroInstallation FROM RESTAURANT ) ) ;

ALTER TABLE MAGASIN ADD CHECK ( NumeroInstallation IN ( SELECT NumeroInstallation FROM INSTALLATION ) AND NOT NumeroInstallation IN ( SELECT NumeroInstallation FROM ATTRACTION ) AND NOT NumeroInstallation IN ( SELECT NumeroInstallation FROM RESTAURANT ) ) ;

ALTER TABLE RESTAURANT ADD CHECK ( NumeroInstallation IN ( SELECT NumeroInstallation FROM INSTALLATION ) AND NOT NumeroInstallation IN ( SELECT NumeroInstallation FROM ATTRACTION ) AND NOT NumeroInstallation IN ( SELECT NumeroInstallation FROM MAGASIN ) ) ;

ALTER TABLE RESERVATION ADD CHECK ( ( ( SELECT SUM(NombrePersonnes) FROM RESERVATION WHERE (RESERVATION.DateResa = DateResa AND RESERVATION.NumeroInstallation = NumeroInstallation) ) + NombrePersonnes ) <= ( SELECT SUM(Capacite) FROM RESTAURANT WHERE RESTAURANT.NumeroInstallation = NumeroInstallation) ) ;
*/

INSERT INTO ETAT(NumeroEtat,Libelle) VALUES
(1,"Ouvert"),
(2,"Fermé");

INSERT INTO INSTALLATION(NumeroInstallation,Nom,HeureOuverture,HeureFermeture,NumeroEtat,Cout) VALUES
(1,"Montagne Russe",'08:00:00','20:00:00',1,50000),
(2,"Carrousel",'08:00:00','18:00:00',1,15000),
(3,"Maison hantée",'10:00:00','23:00:00',1,20000),
(4,"Candies",'08:00:00','20:00:00',1,10000),
(5,"Mugs & co",'08:00:00','20:00:00',1,15000),
(6,"La taverne du perroquet bourré",'08:00:00','20:00:00',1,20000),
(7,"Zut, j'ai oublié mes clés",'08:00:00','20:00:00',1,23000);

INSERT INTO ATTRACTION(NumeroInstallation,Capacite,TempsAttente,NombreVisiteursHeure) VALUES
(1,50,'00:30:00',200),
(2,30,'01:00:00',150),
(3,80,'00:45:00',480);

INSERT INTO MAGASIN(NumeroInstallation,Revenus) VALUES
(4,25000),
(5,35000);

INSERT INTO RESTAURANT(NumeroInstallation,Revenus,Capacite) VALUES
(6,27000,120),
(7,30000,0);

INSERT INTO EMPLOYE(NumeroEmploye,Nom,Prenom,Salaire,NumeroInstallation) VALUES
(1,"Coavoux","Salomé",20000,3),
(2,"Turon","Jérémy",20000,1),
(3,"Senel","Yasin",20000,6),
(4,"Cheminade","Dorian",20000,5),
(5,"Ray","Charles",1300,2),
(6,"Lullaby","Vanelope",1300,4),
(7,"Azerty","Qwerty",1300,7);

INSERT INTO PRODUIT(NumeroProduit,Nom,Prix) VALUES
(1,"Nutella",4),
(2,"Malabar",1),
(3,"Réglisse",1),
(4,"Mug",15),
(5,"Pull",40),
(6,"Peluche",18);

INSERT INTO FOURNISSEUR(NumeroFournisseur,Nom) VALUES
(1,"Joseph le charpentier"),
(2,"Barbe bleue"),
(3,"Hello World !");

INSERT INTO RESERVATION(NumeroReservation,DateResa,NombrePersonnes,NumeroInstallation) VALUES
(1,'2014-01-01',15,6),
(2,'2014-01-01',2,6),
(3,'2014-05-10',5,6);

INSERT INTO FOURNIR(NumeroProduit,NumeroInstallation,NumeroFournisseur) VALUES
(1,4,1),
(2,4,2),
(3,4,2),
(4,5,3),
(5,5,3),
(6,5,1),
(6,4,2);

INSERT INTO VENDRE(NumeroProduit,NumeroInstallation,Quantite) VALUES
(1,4,100),
(2,4,1000),
(3,4,50000),
(4,5,500),
(5,5,200),
(6,5,17859),
(6,4,253);
