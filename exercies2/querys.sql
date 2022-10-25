#1
SELECT * from client WHERE prenom = "Muriel" AND PASSWORD = SHA1('test11')
#2
SELECT COUNT(*) as duplicate,nom from commande_ligne GROUP by nom HAVING duplicate > 1 ORDER by duplicate desc
#3
SELECT COUNT(*) as duplicate,nom,commande_id from commande_ligne GROUP by nom HAVING duplicate > 1 ORDER by duplicate desc
#4
UPDATE commande_ligne SET prix_total = ROUND(quantite * prix_unitaire)
#5
SELECT SUM(prix_total)AS prix_total_commande,commande.id,date_achat,prenom,client.nom FROM commande_ligne,commande,client WHERE commande_ligne.commande_id=commande.id AND commande.client_id=client.id GROUP BY commande.id
#6
/*j'avoue c'etait triky 😅 */
UPDATE commande,(SELECT t.prix_total_commande,t.id FROM(SELECT SUM(prix_total)AS prix_total_commande,commande.id FROM commande_ligne INNER JOIN commande ON commande_ligne.commande_id=commande.id INNER JOIN client ON commande.client_id=client.id GROUP BY commande.id)AS t)p SET commande.cache_prix_total=p.prix_total_commande WHERE commande.id=p.id
#7
SELECT MONTHNAME(CAST(DATE_FORMAT(date_achat, '%Y-%m-01') AS DATE)) AS months,SUM(cache_prix_total) as global_amount from commande GROUP by months
#8
SELECT client_id,prenom,nom,SUM(cache_prix_total) as montant from commande INNER JOIN client ON commande.client_id=client.id GROUP by client_id ORDER by cache_prix_total DESC LIMIT 10
#9
SELECT date_achat,SUM(cache_prix_total) as global_amount from commande GROUP by date_achat ORDER by global_amount DESC
#10 
ALTER TABLE commande ADD category INT(20)NULL
#11
UPDATE commande SET category=(CASE WHEN cache_prix_total<200 THEN 1 WHEN cache_prix_total<500 THEN 2 WHEN cache_prix_total<1000 THEN 3 WHEN cache_prix_total>1000 THEN 4 ELSE 0 END)
#12
CREATE TABLE commande_category(id INT(20)NOT NULL,description VARCHAR(255)NULL)
#13
INSERT INTO commande_category(id,description)VALUES(1,'les commandes de moins de 200€'),(2,'les commandes entre 200€ et 500€'),(3,'les commandes entre 500€ et 1.000€'),(4,'les commandes supérieures à 1.000€')
#14
DELETE a.*,b.* from commande a,commande_ligne b WHERE a.id = b.commande_id AND a.date_achat < "2019-02-01"