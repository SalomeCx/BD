--restaurants reservables
SELECT ListeRestaurant.NomRestaurant FROM ListeRestaurant NATURAL JOIN HoraireRestaurant WHERE Reservable = 1
-- attractions dans la zone (X,Y)
SELECT ListeAttraction.NomAttraction FROM ListeAttraction NATURAL JOIN HoraireAttraction NATURAL JOIN Emplacements WHERE (Lattitude = x AND Longitude = y)
--magasin qui rapport le plus
SELECT MAX(Recettes.Revenus - Recettes.Couts) FROM ListeMagasin NATURAL JOIN Recettes 
-- Magasin ouvert à l'heure h.
SELECT ListeMagasin.NomMagasin FROM( 
	(ListeMagasin NATURAL JOIN EtatAMR WHERE EtatAMR.Etat = 1) 
	NATURAL JOIN 
	(ListeMagasin NATURAL JOIN HoraireMagasin WHERE h BETWEEN HoraireMagasin.HeureOuverture AND HoraireMagasin.HeureFermeture)
	)

--
