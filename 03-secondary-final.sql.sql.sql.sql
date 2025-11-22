SELECT *
FROM countries as c  ;

select *
from economies as e ;

select c.continent  
from countries as c ;

select *
from countries as c 
where c.continent = 'Europe'
ORDER BY country
;

SELECT 
    e.country,
    e.year,
    e.gdp,
    e.gini,
    e.population
FROM economies e
JOIN countries c ON e.country = c.country
WHERE c.continent = 'Europe'
  AND e.year BETWEEN 2006 AND 2018
ORDER BY c.country, e.year;

CREATE TABLE t_matouskova_project_SQL_secondary_final AS
SELECT 
    e.country,
    e.year,
    e.gdp,
    e.gini,
    e.population
FROM economies e
JOIN countries c ON e.country = c.country
WHERE c.continent = 'Europe'
  AND e.year BETWEEN 2006 AND 2018
ORDER BY e.country, e.year;

SELECT *
FROM t_katerina_matouskova_project_SQL_secondary_final
where country = 'Czech Republic';

SELECT COUNT(*) AS pocet_zaznamu, MIN(year) AS prvni_rok, MAX(year) AS posledni_rok
FROM t_katerina_matouskova_project_SQL_secondary_final;

SELECT 
    SUM(CASE WHEN gdp IS NULL THEN 1 ELSE 0 END) AS null_gdp,
    SUM(CASE WHEN gini IS NULL THEN 1 ELSE 0 END) AS null_gini,
    SUM(CASE WHEN population IS NULL THEN 1 ELSE 0 END) AS null_population
FROM t_katerina_matouskova_project_SQL_secondary_final;

ALTER TABLE t_matouskova_project_sql_secondary_final
RENAME TO t_katerina_matouskova_project_sql_secondary_final;

select *
from economies as e 
where country = 'Czech Republic';


