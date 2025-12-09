--2. Kolik je možné si koupit litrů mléka a kilogramů chleba 
--za první a poslední srovnatelné období v dostupných datech cen a mezd?


SELECT 
    year,
    category_name,
    ROUND(AVG(avg_salary)::numeric, 2) AS avg_wages,   
    ROUND(AVG(price)::numeric, 2) AS avg_price,           
    ROUND((AVG(avg_salary) / AVG(price))::numeric, 0) AS units_to_buy 
FROM t_katerina_matouskova_project_SQL_primary_final
WHERE 
	category_name IN ('Mléko polotučné pasterované', 'Chléb konzumní kmínový')
  	AND year IN (2006, 2018)
GROUP BY 
	year, 
	category_name
ORDER BY 
	category_name, 
	year;