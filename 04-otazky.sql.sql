--1. Rostou v průběhu let mzdy ve všech odvětvích, nebo v některých klesají?
-- Průměrná mzda podle odvětví a roku
SELECT 
    industry_name,
    year,
    AVG(avg_salary) AS avg_salary
FROM t_katerina_matouskova_project_SQL_primary_final
GROUP BY industry_name, year
ORDER BY industry_name, year;

-- Meziroční růst průměrných mezd podle odvětví
SELECT 
    industry_name,
    year,
    avg_salary,
    LAG(avg_salary) OVER (PARTITION BY industry_name ORDER BY year) AS prev_year_salary,
    ROUND(
        (avg_salary - LAG(avg_salary) OVER (PARTITION BY industry_name ORDER BY year)) 
        / LAG(avg_salary) OVER (PARTITION BY industry_name ORDER BY year) * 100, 2
    ) AS pct_change
FROM t_katerina_matouskova_project_SQL_primary_final
ORDER BY industry_name, year;


--2. Kolik je možné si koupit litrů mléka a kilogramů chleba 
--za první a poslední srovnatelné období v dostupných datech cen a mezd?
WITH avg_salary_per_year AS (
    SELECT year, AVG(avg_salary) AS avg_salary
    FROM t_katerina_matouskova_project_SQL_primary_final
    GROUP BY year
),
price_per_year AS (
    SELECT 
        EXTRACT(YEAR FROM date_from)::int AS year,
        c.name AS category,
        AVG(p.value) AS price
    FROM czechia_price p
    JOIN czechia_price_category c 
        ON p.category_code = c.code
    WHERE c.name ILIKE 'Chléb%' OR c.name ILIKE 'Mléko%'
    GROUP BY EXTRACT(YEAR FROM date_from), c.name
)
SELECT 
    s.year,
    p.category,
    ROUND((s.avg_salary / p.price)::numeric, 2) AS units_can_buy
FROM avg_salary_per_year s
JOIN price_per_year p ON s.year = p.year
WHERE s.year IN (2006, 2018)
ORDER BY p.category, s.year;

--kontrola - průměrný plat v roce 06
SELECT year, AVG(avg_salary) AS avg_salary
FROM t_katerina_matouskova_project_SQL_primary_final
WHERE year = 2006
GROUP BY year;

--3. Která kategorie potravin zdražuje nejpomaleji 
--(je u ní nejnižší percentuální meziroční nárůst)? 

WITH yearly_price AS (
    SELECT
        c.name AS category_name,
        EXTRACT(YEAR FROM p.date_from) AS year,
        AVG(p.value) AS avg_price
    FROM czechia_price p
    JOIN czechia_price_category c
        ON p.category_code = c.code
    WHERE p.value IS NOT NULL
    GROUP BY c.name, EXTRACT(YEAR FROM p.date_from)
),
yearly_growth AS (
    SELECT
        y1.category_name,
        y1.year,
        ((y2.avg_price - y1.avg_price) / y1.avg_price) * 100 AS pct_growth
    FROM yearly_price y1
    JOIN yearly_price y2
        ON y1.category_name = y2.category_name
       AND y2.year = y1.year + 1
)
SELECT
    category_name,
    AVG(pct_growth) AS avg_annual_growth
FROM yearly_growth
GROUP BY category_name
ORDER BY avg_annual_growth ASC
LIMIT 1;

--4. Existuje rok, ve kterém byl meziroční nárůst cen potravin 
výrazně vyšší než růst mezd (větší než 10 %)?



WITH yearly_avg AS (
    SELECT
        year,
        AVG(avg_food_price) AS avg_food_price,
        AVG(avg_salary) AS avg_salary
    FROM t_katerina_matouskova_project_sql_primary_final
    GROUP BY year
),
growth AS (
    SELECT
        year,
        ((LEAD(avg_food_price) OVER (ORDER BY year) - avg_food_price) / avg_food_price) * 100 AS food_growth,
        ((LEAD(avg_salary) OVER (ORDER BY year) - avg_salary) / avg_salary) * 100 AS salary_growth
    FROM yearly_avg
)
SELECT
    year,
    food_growth,
    salary_growth,
    (food_growth - salary_growth) AS diff_growth
FROM growth
WHERE food_growth > salary_growth
ORDER BY diff_growth DESC;





--5. Má výška HDP vliv na změny ve mzdách a cenách potravin? 
--Neboli, pokud HDP vzroste výrazněji v jednom roce, projeví se 
--to na cenách potravin či mzdách ve stejném nebo následujícím roce výraznějším růstem?


select *
from t_katerina_matouskova_project_sql_secondary_final as tmpspf ;

--Průměr přes regiony pro každý rok
SELECT
    year,
    AVG(avg_salary) AS avg_salary,
    AVG(avg_food_price) AS avg_food_price
FROM t_katerina_matouskova_project_sql_primary_final
GROUP BY year
ORDER BY year;
--Meziroční růst mezd a cen
SELECT
    year,
    avg_salary,
    avg_food_price,
    ROUND(((LEAD(avg_salary) OVER (ORDER BY year) - avg_salary) / avg_salary)::numeric * 100, 2) AS salary_growth,
    ROUND(((LEAD(avg_food_price) OVER (ORDER BY year) - avg_food_price) / avg_food_price)::numeric * 100, 2) AS food_growth
FROM (
    SELECT
        year,
        AVG(avg_salary) AS avg_salary,
        AVG(avg_food_price) AS avg_food_price
    FROM t_katerina_matouskova_project_sql_primary_final
    GROUP BY year
) AS yearly_avg
ORDER BY year;

-- Průměrný HDP ČR podle roku
SELECT
    year,
    AVG(gdp) AS avg_gdp
FROM t_katerina_matouskova_project_sql_secondary_final
WHERE country = 'Czech Republic'
GROUP BY year
ORDER BY year;


-- 5. Má výška HDP vliv na změny ve mzdách a cenách potravin?
-- Neboli, pokud HDP vzroste výrazněji v jednom roce, projeví se 
-- to na cenách potravin či mzdách ve stejném nebo následujícím roce výraznějším růstem?

WITH yearly_avg AS (
    SELECT
        year,
        AVG(avg_salary) AS avg_salary,
        AVG(avg_food_price) AS avg_food_price
    FROM t_katerina_matouskova_project_sql_primary_final
    GROUP BY year
),
growth AS (
    SELECT
        year,
        ((LEAD(avg_salary) OVER (ORDER BY year) - avg_salary) / avg_salary) * 100 AS salary_growth,
        ((LEAD(avg_food_price) OVER (ORDER BY year) - avg_food_price) / avg_food_price) * 100 AS food_growth
    FROM yearly_avg
),
yearly_gdp AS (
    SELECT
        year,
        AVG(gdp) AS gdp
    FROM t_katerina_matouskova_project_sql_secondary_final
    WHERE country = 'Czech Republic'
    GROUP BY year
),
gdp_growth AS (
    SELECT
        year,
        gdp,
        ((gdp - LAG(gdp) OVER (ORDER BY year)) / gdp) * 100 AS gdp_growth
    FROM yearly_gdp
)
SELECT
    g.year,
    ROUND(g.gdp::numeric, 2) AS gdp,
    ROUND(g.gdp_growth::numeric, 2) AS gdp_growth_percent,
    ROUND(p.salary_growth::numeric, 2) AS salary_growth_percent,
    ROUND(p.food_growth::numeric, 2) AS food_growth_percent,
    ROUND((g.gdp_growth - p.salary_growth)::numeric, 2) AS diff_gdp_vs_salary,
    ROUND((g.gdp_growth - p.food_growth)::numeric, 2) AS diff_gdp_vs_food,
    ROUND((p.food_growth - p.salary_growth)::numeric, 2) AS diff_food_vs_salary
FROM growth p
JOIN gdp_growth g ON p.year = g.year
ORDER BY g.year;




