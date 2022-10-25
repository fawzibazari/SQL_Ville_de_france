#1
SELECT ville_nom from villes_france_free ORDER by ville_population_2012 DESC limit 10
#2
SELECT ville_nom from villes_france_free ORDER BY ville_surface asc LIMIT 50
#3
SELECT ville_nom,LEFT(ville_code_postal, 2) as outre_mer FROM villes_france_free WHERE LEFT(ville_code_postal, 2) = 97
#4
SELECT ville_nom, departement_nom, ville_population_2012 from villes_france_free ,departement WHERE ville_departement = departement_code ORDER by ville_population_2012 DESC limit 10
#5 
SELECT departement_nom, departement_code, COUNT(ville_id) as nombre_de_commune FROM departement,villes_france_free WHERE ville_departement = departement_code GROUP BY departement_nom, departement_code ORDER by COUNT(ville_id) DESC
#6 
SELECT departement_nom, ROUND(SUM(ville_surface)) as highest_surface from villes_france_free,departement WHERE ville_departement=departement_code GROUP BY departement_nom ORDER by highest_surface DESC LIMIT 10
#7
SELECT COUNT(ville_nom) as nombre_de_ville FROM villes_france_free WHERE LEFT(ville_nom,5) LIKE '%SAINT%'
#8
SELECT COUNT(ville_nom) as nombre, ville_nom from villes_france_free GROUP BY ville_nom ORDER by nombre DESC
#9
SELECT ville_nom,ville_surface FROM villes_france_free WHERE ville_surface>(SELECT ROUND(AVG(ville_surface))AS average FROM villes_france_free)
#10 
SELECT departement_nom,SUM(ville_population_2012)AS habitant FROM villes_france_free,departement WHERE ville_departement=departement_code GROUP BY departement_nom HAVING habitant>2000000
#11
SELECT ville_nom, REPLACE(ville_nom, '-', ' ') as replaced FROM villes_france_free WHERE LEFT(ville_nom,6) LIKE '%SAINT-%'
#BONUS population ile de france en 2012
SELECT SUM(ville_population_2012)AS population_ile_de_france FROM villes_france_free WHERE ville_departement in(75, 77, 78, 91, 92, 93, 94, 95)