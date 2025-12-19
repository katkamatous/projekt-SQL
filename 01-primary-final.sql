CREATE TABLE t_katerina_matouskova_project_SQL_primary_final AS
WITH payroll_data AS (
    SELECT
        payroll_year,
        industry_branch_code,
        AVG(value) AS avg_salary
    FROM czechia_payroll
    WHERE value_type_code = 5958    
      AND calculation_code = 200      -- Přepočtené počty
      AND industry_branch_code IS NOT NULL
    GROUP BY payroll_year, industry_branch_code
),
price_data AS (
    SELECT
        EXTRACT(YEAR FROM date_from) AS year,
        category_code,
        AVG(value) AS avg_price
    FROM czechia_price
    GROUP BY EXTRACT(YEAR FROM date_from), category_code
)
SELECT
    pd.payroll_year AS year,
    ib.name AS industry_name,
    pd.avg_salary,
    cpc.name AS category_name,
    pr.avg_price AS price
FROM payroll_data pd
JOIN czechia_payroll_industry_branch ib
    ON pd.industry_branch_code = ib.code
JOIN price_data pr
    ON pd.payroll_year = pr.year
JOIN czechia_price_category cpc
    ON pr.category_code = cpc.code;



SELECT *
FROM t_katerina_matouskova_project_sql_primary_final as tkmpspf 
ORDER by YEAR;








