SELECT COUNT(*) FROM czechia_payroll;


SELECT MIN(payroll_year), MAX(payroll_year)
FROM czechia_payroll;


SELECT COUNT(*) FROM czechia_payroll_calculation as cpc ;
SELECT *
FROM czechia_payroll_calculation as cpc ;
SELECT *
FROM czechia_payroll_industry_branch as i  ;
SELECT *
FROM czechia_payroll_unit as cpu  ;
SELECT *
FROM czechia_payroll_value_type as cpvt   ;
SELECT *
FROM czechia_price as cp   ;
SELECT COUNT(*) FROM czechia_price as cp ;
SELECT COUNT(*) FROM czechia_price_category as cpc  ;
select *
from czechia_price_category as cpc ;
select *
from czechia_region as cr  ;
select *
from czechia_district as cd  ;
select *
from countries as c  ;
SELECT COUNT(*) 
FROM countries as c  ;
select *
from economies as e   ;
SELECT COUNT(*) 
from economies as e   ;
SELECT MIN(payroll_year), MAX(payroll_year)
FROM czechia_payroll;
SELECT MIN(date_from), MAX(date_to)
FROM czechia_price as cp ;
SELECT COUNT(*) FROM czechia_payroll WHERE value IS NULL;
SELECT MIN(date_from), MAX(date_to)
FROM czechia_price as cp ;

SELECT 
    EXTRACT(YEAR FROM date_from) AS year,
    MIN(date_from) AS first_date,
    MAX(date_from) AS last_date,
    COUNT(*) AS num_records
FROM czechia_price
GROUP BY EXTRACT(YEAR FROM date_from)
ORDER BY year;

select *
from czechia_price as cp;

select *
from czechia_price_category as cpc ;

select *
from czechia_payroll as cp ;

CREATE VIEW v_payroll_yearly as
SELECT
    payroll_year AS year,
    industry_branch_code,
    AVG(value) AS avg_salary
FROM czechia_payroll
WHERE value IS NOT NULL
  AND value_type_code = 5958   -- jen průměrná mzda
  AND unit_code = 200           -- měsíční mzda
GROUP BY payroll_year, industry_branch_code
ORDER BY payroll_year, industry_branch_code;

CREATE OR REPLACE VIEW v_price_normalized_2 AS
SELECT
    EXTRACT(YEAR FROM p.date_from) AS year,
    p.category_code,
    (p.value / pc.price_value) *
        CASE 
            WHEN pc.price_unit = 'g' THEN 1000
            ELSE 1
        END AS normalized_price,
    CASE WHEN p.value IS NULL THEN 1 ELSE 0 END AS price_was_null
FROM czechia_price AS p
JOIN czechia_price_category AS pc
    ON p.category_code = pc.code;


select *
from v_price_normalized_2;


SELECT *
FROM v_price_normalized
WHERE category_code = 114401
ORDER BY year;

SELECT *
FROM czechia_price as cp 
WHERE category_code = 114401
;



select *
from v_payroll_yearly;
select *
from v_payroll_yearly;




