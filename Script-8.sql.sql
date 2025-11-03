CREATE TABLE t_matouskova_project_SQL_primary_final AS
SELECT
    py.year,
    i.name AS industry_name,
    AVG(py.avg_salary) AS avg_salary,          
    AVG(c.price) AS avg_food_price,
    MAX(CASE WHEN py.avg_salary IS NULL THEN 1 ELSE 0 END) AS salary_was_null,
    MAX(CASE WHEN c.price IS NULL THEN 1 ELSE 0 END) AS price_was_null
FROM v_payroll_yearly AS py
JOIN czechia_payroll_industry_branch AS i
    ON py.industry_branch_code = i.code
JOIN v_price_normalized AS c
    ON py.year = c.year
GROUP BY py.year, i.name
ORDER BY py.year, i.name;

select *
from t_matouskova_project_SQL_primary_final;




