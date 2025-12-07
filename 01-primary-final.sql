CREATE TABLE t_matouskova_project_SQL_primary_final AS
SELECT
    py.year,
    i.name AS industry_name,
    AVG(py.avg_salary) AS avg_salary,          
    AVG(c.price) AS avg_food_price,
    MAX(CASE WHEN py.avg_salary IS NULL THEN 1 ELSE 0 END) AS salary_was_null,
    MAX(CASE WHEN c.price IS NULL THEN 1 ELSE 0 END) AS price_was_null
FROM data_academy_content.v_payroll_yearly AS py
JOIN data_academy_content.czechia_payroll_industry_branch AS i
    ON py.industry_branch_code = i.code
JOIN data_academy_content.v_price_normalized AS c
    ON py.year = c.year
GROUP BY py.year, i.name
ORDER BY py.year, i.name;



select *
from t_katerina_matouskova_project_SQL_primary_final;


ALTER TABLE t_matouskova_project_sql_primary_final
RENAME TO t_katerina_matouskova_project_sql_primary_final;




