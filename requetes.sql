 /* Qui vend le produit de numero NP */
set @NP = 6 ;
select NumeroInstallation , Nom from INSTALLATION natural join VENDRE where NumeroProduit = @NP ;

/* Quelle est le Benefice d'un restaurant de numero NR */
set @NR = 6 ;
select 
(select sum(Revenus) from RESTAURANT where NumeroInstallation = @NR)
-
(select sum(Cout) from INSTALLATION natural join RESTAURANT where NumeroInstallation = @NR)
-
(select sum(Salaire) from EMPLOYE natural join RESTAURANT where NumeroInstallation = @NR)
;

/* Quelle est le Benefice d'un magasin de numero NM */
set @NM = 4 ;
select 
(select sum(Revenus) from MAGASIN where NumeroInstallation = @NM)
-
(select sum(Cout) from INSTALLATION natural join MAGASIN where NumeroInstallation = @NM)
-
(select sum(Salaire) from EMPLOYE natural join MAGASIN where NumeroInstallation = @NM)
;

/* Magasin qui a le revenus le plus important */
select NumeroInstallation, Nom from MAGASIN natural join INSTALLATION where Revenus = (select max(revenus) from MAGASIN) ;

/* Installations ouvertes */
select NumeroInstallation, Nom from INSTALLATION where NumeroEtat = 1 ;

/* Quels magasins vendent tous les produits, équivalent à (MAGASIN NATURAL JOIN INSTALLATION natural join VENDRE) diviser par (select NumeroProduit from Produit) */
SELECT NumeroInstallation,Nom FROM MAGASIN NATURAL JOIN INSTALLATION natural join VENDRE
GROUP BY NumeroInstallation
HAVING COUNT(*) = (SELECT COUNT(NumeroProduit) FROM Produit) ;

/*restaurants reservables*/

CREATE TEMPORARY TABLE R1 AS SELECT * FROM INSTALLATION WHERE NumeroEtat = 1;  
CREATE TEMPORARY TABLE R2 AS SELECT * FROM INSTALLATION NATURAL JOIN RESTAURANT; 
CREATE TEMPORARY TABLE R3 AS SELECT * FROM R1 NATURAL JOIN R2; 
SELECT Nom AS RestaurantsReservables FROM R3 WHERE Capacite > 0;

/* Nombre de places restantes dans un restaurant à une date d*/
SET @d='2014-01-01';
SET @nomRestaurant='La taverne du perroquet bourré';
CREATE TEMPORARY TABLE D1 AS SELECT * FROM INSTALLATION WHERE Nom = @nomRestaurant;
CREATE TEMPORARY TABLE D2 AS SELECT * FROM D1 NATURAL JOIN RESTAURANT;
CREATE TEMPORARY TABLE D3 AS SELECT * FROM RESERVATION WHERE DateResa = @d; 
CREATE TEMPORARY TABLE D4 AS SELECT * FROM D2 NATURAL JOIN D3;
SELECT Nom AS Restaurant, Capacite - SUM(NombrePersonnes) AS PlacesRestantes FROM D4;

