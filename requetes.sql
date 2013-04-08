--restaurants reservables
CREATE FUNCTION reservables (D DATE, RETURNS CHAR(50))
RETURN(
R1 = ETAT WHERE Libelle = "ouvert"  NATURAL JOIN INSTALLATION
R2 = INSTALLATION NATURAL JOIN RESTAURANT
R3 = R1 NATURAL JOIN R2 --restaurants ouverts
R4 = SELECT NumeroRestaurant, SUM( NombrePersonnes) AS Total FROM RESERVATION WHERE (Date = D AND Numero = R3.Numero) GROUPE BY Numero --restaurants ouverts a la date 'D' triés par numero

SELECT NomRestaurant FROM R4 WHERE Total < R3.Capacite NATURAL JOIN R3);
 
--magasin qui rapport le plus	
SELECT MAX(MAGASIN.Revenus - INSTALLATION.Couts) FROM MAGASIN NATURAL JOIN INSTALLATION 
-- Magasin ouvert à l'heure h.
CREATE FUNCTION ouvertH (h INTEGER, RETURNS CHAR(50))
RETURN(
M1 = INSTALLATION NATURAL JOIN ETAT WHERE Libelle = "ouvert" --installation ouverte
M2 = MAGASIN NATURAL JOIN M1 --Magasin ouvert

SELECT INSTALLATION.Nom FROM( 
	( M2 NATURAL JOIN (INSTALLATION WHERE h BETWEEN INSTALLATION.HeureOuverture AND INSTALLATION.HeureFermeture) -- ouvert a l'heure 'h'
	))

--
