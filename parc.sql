CREATE TABLE ListeAttraction (
	NomAttraction NOT NULL VARCHAR(30),
	Numero INTEGER PRIMARY KEY,
	HeureOuverture NOT NULL INTEGER,
	HeureFermeture NOT NULL INTEGER,
	Capacite NOT NULL INTEGER,
	CHECK (HeureOuverture >= 0 AND HeureOuverture <= 23),
	CHECK (HeureFermeture >= 0 AND HeureFermeture <= 23),
	CHECK (HeureOuverture < HeureFermeture)
	CHECK (Capacite > 0));

CREATE TABLE ListeMagasin (
	NomMagasin NOT NULL VARCHAR(30),
	Numero INTEGER PRIMARY KEY,
	HeureOuverture NOT NULL INTEGER,
	HeureFermeture NOT NULL INTEGER,
	CHECK (HeureOuverture >= 0 AND HeureOuverture <= 23),
	CHECK (HeureFermeture >= 0 AND HeureFermeture <= 23),
	CHECK (HeureOuverture < HeureFermeture));

CREATE TABLE ListeRestaurant (
	NomRestaurant NOT NULL VARCHAR(30),
	Numero INTEGER PRIMARY KEY,
	HeureOuverture NOT NULL INTEGER,
	HeureFermeture NOT NULL INTEGER,
	Capacite NOT NULL INTEGER,
	Reservable NOT NULL INTEGER,
	CHECK (HeureOuverture >= 0 AND HeureOuverture <= 23),
	CHECK (HeureFermeture >= 0 AND HeureFermeture <= 23),
	CHECK (HeureOuverture < HeureFermeture)
	CHECK (Capacite > 0)
	CHECK (Reservable == 0 OR Reservable == 1));

CREATE TABLE Reservation (
	NumeroResa INTEGER PRIMARY KEY,
	Numero INTEGER FOREIGN KEY,
	DateResa NOT NULL DATE,
	NbPersonnes NOT NULL INTEGER,
	CHECK (NbPersonnes > 0));

CREATE TABLE EtatAMR (
	Numero INTEGER FOREIGN KEY,
	Etat NOT NULL INTEGER,
	NbVisiteurHeure NOT NULL INTEGER,
	TmpAttente NOT NULL INTEGER,
	CHECK (Etat >= 0 AND Etat <= 2),
	CHECK (NbVisiteurHeure >= 0),
	CHECK (TmpAttente >= 0));

CREATE TABLE ListeEmploye (
	NumeroEmploye INTEGER PRIMARY KEY,
	Numero INTEGER FOREIGN KEY,
	Nom NOT NULL VARCHAR(30),
	Prenom NOT NULL VARCHAR(30),
	Salaire NOT NULL INTEGER,
	CHECK (Salaire >= 1300));

CREATE TABLE Produits (
	NumeroProduit INTEGER PRIMARY KEY,
	NomProduit NOT NULL VARCHAR(30),
	Prix NOT NULL INTEGER,
	CHECK (Prix > 0));

CREATE TABLE Emplacements (
	Numero INTEGER FOREIGN KEY,
	Quartier NOT NULL VARCHAR(30),
	Lattitude NOT NULL INTEGER,
	Longitude NOT NULL INTEGER,
	CHECK (Lattitude > 0 AND Lattitude < 15),
	CHECK (Longitude > 0 AND Longitude < 15));

CREATE TABLE Fournisseurs (
	NumeroFournisseur INTEGER PRIMARY KEY,
	NomFournisseur NOT NULL VARCHAR(30),
	Numero INTEGER FOREIGN KEY,
	NumeroProduit INTEGER FOREIGN KEY,
	Quantite NOT NULL INTEGER,
	DerniereLivraison NOT NULL DATE,
	CHECK (Quantite > 0));

CREATE TABLE ProduitsDispo (
	NumeroProduit INTEGER FOREIGN KEY,
	Numero INTEGER FOREIGN KEY,
	Quantite NOT NULL INTEGER,
	CHECK (Quantite >= 0));

CREATE TABLE Recettes (
	Couts NOT NULL INTEGER,
	Revenus NOT NULL INTEGER,
	Numero INTEGER FOREIGN KEY,
	CHECK (Couts >= 0),
	CHECK (Revenus >= 0));

