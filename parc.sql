CREATE TABLE ListeAttraction (
	NomAttraction VARCHAR(30) NOT NULL,
	Numero INTEGER PRIMARY KEY CHECK (Numero LIKE "1%") );

CREATE TABLE HoraireAttraction (
	Numero INTEGER ,
	HeureOuverture INTEGER NOT NULL,
	HeureFermeture INTEGER NOT NULL,
	Capacite INTEGER NOT NULL ,
	CHECK (HeureOuverture >= 0 AND HeureOuverture <= 23),
	CHECK (HeureFermeture >= 0 AND HeureFermeture <= 23),
	CHECK (HeureOuverture < HeureFermeture),
	CHECK (Capacite > 0),
	FOREIGN KEY (Numero) REFERENCES ListeAttraction(Numero) ON DELETE CASCADE);

CREATE TABLE ListeMagasin (
	NomMagasin VARCHAR(30) NOT NULL,
	Numero INTEGER PRIMARY KEY CHECK (Numero LIKE "2%") );

CREATE TABLE HoraireMagasin (
	Numero INTEGER ,
	HeureOuverture INTEGER NOT NULL,
	HeureFermeture INTEGER NOT NULL,
	CHECK (HeureOuverture >= 0 AND HeureOuverture <= 23),
	CHECK (HeureFermeture >= 0 AND HeureFermeture <= 23),
	CHECK (HeureOuverture < HeureFermeture),
	FOREIGN KEY (Numero) REFERENCES ListeMagasin(Numero) ON DELETE CASCADE);

CREATE TABLE ListeRestaurant (
	NomRestaurant VARCHAR(30) NOT NULL, 
	Numero INTEGER PRIMARY KEY CHECK (Numero LIKE "3%"));

CREATE TABLE HoraireRestaurant (
	Numero INTEGER ,
	HeureOuverture INTEGER NOT NULL,
	HeureFermeture INTEGER NOT NULL ,
	Capacite INTEGER NOT NULL ,
	Reservable INTEGER NOT NULL,
	CHECK (HeureOuverture >= 0 AND HeureOuverture <= 23),
	CHECK (HeureFermeture >= 0 AND HeureFermeture <= 23),
	CHECK (HeureOuverture < HeureFermeture),
	CHECK (Capacite > 0),
	CHECK ( (Reservable = 0) OR (Reservable = 1) ),
	FOREIGN KEY (Numero) REFERENCES ListeRestaurant(Numero) ON DELETE CASCADE);

CREATE TABLE Reservation (
	NumeroResa INTEGER PRIMARY KEY,
	Numero INTEGER REFERENCES ListeRestaurant(Numero),
	DateResa DATE NOT NULL,
	NbPersonnes INTEGER NOT NULL,
	CHECK (NbPersonnes > 0));

CREATE TABLE EtatAMR (
	Numero INTEGER ,
	Etat INTEGER NOT NULL,
	NbVisiteurHeure INTEGER NOT NULL,
	TmpAttente INTEGER NOT NULL,
	CHECK (Etat >= 0 AND Etat <= 2),
	CHECK (NbVisiteurHeure >= 0),
	CHECK (TmpAttente >= 0),
	CHECK (Numero IN (select Numero from ListeRestaurant UNION 
						select Numero from ListeMagasin UNION
						 select Numero from ListeAttraction)));

CREATE TABLE ListeEmploye (
	NumeroEmploye INTEGER PRIMARY KEY,
	Numero INTEGER ,
	Nom VARCHAR(30) NOT NULL,
	Prenom VARCHAR(30) NOT NULL,
	Salaire INTEGER NOT NULL,
	CHECK (Salaire >= 1300),
	CHECK (Numero IN (select Numero from ListeRestaurant UNION 
						select Numero from ListeMagasin UNION
						 select Numero from ListeAttraction)));

CREATE TABLE Produits (
	NumeroProduit INTEGER PRIMARY KEY,
	NomProduit VARCHAR(30) NOT NULL,
	Prix INTEGER NOT NULL,
	CHECK (Prix > 0));

CREATE TABLE Emplacements (
	Numero INTEGER,
	Quartier VARCHAR(30) NOT NULL,
	Lattitude INTEGER NOT NULL,
	Longitude INTEGER NOT NULL,
	CHECK (Lattitude > 0 AND Lattitude < 15),
	CHECK (Longitude > 0 AND Longitude < 15),
	FOREIGN KEY (Numero) REFERENCES ListeRestaurant(Numero) ON DELETE CASCADE);

CREATE TABLE Fournisseurs (
	NumeroFournisseur INTEGER PRIMARY KEY,
	NomFournisseur VARCHAR(30) NOT NULL,
	Numero INTEGER ,
	NumeroProduit INTEGER ,
	Quantite INTEGER NOT NULL,
	DerniereLivraison DATE NOT NULL,
	CHECK (Quantite > 0),
	FOREIGN KEY (Numero) REFERENCES ListeMagasin(Numero) ON DELETE CASCADE);

CREATE TABLE ProduitsDispo (
	NumeroProduit INTEGER ,
	Numero INTEGER ,
	Quantite INTEGER NOT NULL,
	CHECK (Quantite >= 0),
	FOREIGN KEY (NumeroProduit) REFERENCES Produits(NumeroProduit) ON DELETE CASCADE,
	FOREIGN KEY (Numero) REFERENCES ListeMagasin(Numero) ON DELETE CASCADE);

CREATE TABLE Recettes (
	Couts INTEGER NOT NULL,
	Revenus INTEGER NOT NULL,
	Numero INTEGER PRIMARY KEY,
	CHECK (Couts >= 0),
	CHECK (Revenus >= 0),
	CHECK (Numero IN (select Numero from ListeRestaurant UNION 
						select Numero from ListeMagasin)));

