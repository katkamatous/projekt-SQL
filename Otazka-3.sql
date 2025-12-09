--3. Která kategorie potravin zdražuje nejpomaleji 
--(je u ní nejnižší percentuální meziroční nárůst)?

WITH prices_per_year AS (
    SELECT 
        year,
        category_name,
        AVG(price) AS price
    FROM t_katerina_matouskova_project_SQL_primary_final
    GROUP BY 
    	year, 
    	category_name
),
yoy_changes AS (
    SELECT 
        year,
        category_name,
        price,
        LAG(price) OVER (PARTITION BY category_name ORDER BY year) AS prev_price,
        ((price - LAG(price) OVER (PARTITION BY category_name ORDER BY year)) 
         / LAG(price) OVER (PARTITION BY category_name ORDER BY year)) * 100 AS yoy_growth
    FROM prices_per_year
)
SELECT 
    category_name,
    ROUND(AVG(yoy_growth)::numeric, 2) AS avg_yearly_growth_percent
FROM 
	yoy_changes
WHERE 
	year > 2006 
GROUP BY 
	category_name
ORDER BY 
	avg_yearly_growth_percent ASC;