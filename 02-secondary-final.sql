CREATE TABLE t_katerina_matouskova_project_SQL_secondary_final AS
SELECT
    e.year,
    e.country,
    e.GDP,
    e.gini,
    e.population
FROM economies e
JOIN countries c
    ON e.country = c.country
WHERE c.continent = 'Europe'
  AND e.year BETWEEN 2006 AND 2018
ORDER BY e.country, e.year;

SELECT *
FROM t_katerina_matouskova_project_sql_secondary_final;





