--1. Rostou v průběhu let mzdy ve všech odvětvích, nebo v některých klesají?
---- tabulka ukazuje průměrná mzdu podle odvětví a roku, meziroční růst průměrných mezd v daném odvětví

SELECT 
    industry_name,
    year,
    avg_salary,
    LAG(avg_salary) OVER (PARTITION BY industry_name ORDER BY year) AS prev_year_salary,
    ROUND(
        (
            (avg_salary - LAG(avg_salary) OVER (PARTITION BY industry_name ORDER BY year)) 
            / LAG(avg_salary) OVER (PARTITION BY industry_name ORDER BY year) * 100
        )::numeric, 2  -- PŘIDÁNO ::numeric (Teď už to ladí s otázkami 2, 3, 4, 5)
    ) AS pct_change
FROM t_katerina_matouskova_project_SQL_primary_final
ORDER BY 
    industry_name,
    year;
