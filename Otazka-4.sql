--4. Existuje rok, ve kterém byl meziroční nárůst cen potravin 
--výrazně vyšší než růst mezd (větší než 10 %)?


WITH annual_averages AS (
    -- 1. Krok: Spočítáme průměrné hodnoty za každý rok (celá ČR)
    SELECT 
        year,
        AVG(avg_salary) AS avg_salary,
        AVG(price) AS avg_price
    FROM t_katerina_matouskova_project_SQL_primary_final
    GROUP BY year
),
yoy_growth AS (
    -- 2. Krok: Spočítáme meziroční nárůsty v procentech
    SELECT 
        year,
        avg_salary,
        LAG(avg_salary) OVER (ORDER BY year) AS prev_salary,
        avg_price,
        LAG(avg_price) OVER (ORDER BY year) AS prev_price
    FROM annual_averages
)
SELECT 
    year,
    -- Růst mezd v %
    ROUND(((avg_salary - prev_salary) / prev_salary * 100)::numeric, 2) AS wage_growth_perc,
    -- Růst cen v %
    ROUND(((avg_price - prev_price) / prev_price * 100)::numeric, 2) AS price_growth_perc,
    -- Rozdíl (Ceny - Mzdy)
    ROUND(
        (((avg_price - prev_price) / prev_price * 100) - 
        ((avg_salary - prev_salary) / prev_salary * 100))::numeric, 
    2) AS growth_difference_points
FROM yoy_growth
WHERE prev_salary IS NOT NULL -- Odstraníme první rok (nemá předchůdce)
ORDER BY growth_difference_points DESC;