
CREATE TABLE t_katerina_matouskova_project_SQL_primary_final AS
SELECT
    py.year,
    i.name AS industry_name,
    py.avg_salary,
    cpc.name AS category_name,
    c.price
FROM data_academy_content.v_payroll_yearly AS py
JOIN data_academy_content.czechia_payroll_industry_branch AS i
    ON py.industry_branch_code = i.code
JOIN data_academy_content.v_price_normalized AS c
    ON py.year = c.year
JOIN data_academy_content.czechia_price_category AS cpc
    ON c.category_code = cpc.code;

select *
from t_katerina_matouskova_project_sql_primary_final as tkmpspf ;



