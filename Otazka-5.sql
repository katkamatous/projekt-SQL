
-- 5. Má výška HDP vliv na změny ve mzdách a cenách potravin?
-- Neboli, pokud HDP vzroste výrazněji v jednom roce, projeví se 
-- to na cenách potravin či mzdách ve stejném nebo následujícím roce výraznějším růstem?

WITH cz_gdp_clean AS (
    -- 1. Krok: Očištění dat o HDP (zbavení se duplicit pomocí GROUP BY)
    SELECT 
        year,
        AVG(GDP) AS GDP -- Pokud jsou řádky duplicitní, průměr je nezmění, ale sjednotí je do jednoho řádku
    FROM t_katerina_matouskova_project_SQL_secondary_final
    WHERE country = 'Czech Republic'
    GROUP BY year
),
cz_gdp_growth AS (
    -- 2. Krok: Výpočet růstu HDP z očištěných dat
    SELECT 
        year,
        ROUND(( (GDP - LAG(GDP) OVER (ORDER BY year)) / LAG(GDP) OVER (ORDER BY year) * 100 )::numeric, 2) AS gdp_growth_perc
    FROM cz_gdp_clean
),
cz_stats AS (
    -- 3. Krok: Data o mzdách a cenách (z primary_final)
    SELECT 
        year,
        ROUND(AVG(avg_salary)::numeric, 2) AS avg_salary,
        ROUND(AVG(price)::numeric, 2) AS avg_price
    FROM t_katerina_matouskova_project_SQL_primary_final
    GROUP BY year
),
cz_stats_growth AS (
    -- 4. Krok: Výpočet růstu mezd a cen
    SELECT
        year,
        ROUND(( (avg_salary - LAG(avg_salary) OVER (ORDER BY year)) / LAG(avg_salary) OVER (ORDER BY year) * 100 )::numeric, 2) AS salary_growth_perc,
        ROUND(( (avg_price - LAG(avg_price) OVER (ORDER BY year)) / LAG(avg_price) OVER (ORDER BY year) * 100 )::numeric, 2) AS price_growth_perc
    FROM cz_stats
)
-- 5. Krok: Finální spojení
SELECT 
    g.year,
    g.gdp_growth_perc AS gdp_growth,
    s.salary_growth_perc AS salary_growth,
    s.price_growth_perc AS food_price_growth
FROM cz_gdp_growth g
JOIN cz_stats_growth s 
    ON g.year = s.year
WHERE g.year > 2006
ORDER BY g.year;