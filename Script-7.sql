SELECT COUNT(*) FROM czechia_payroll;


SELECT MIN(payroll_year), MAX(payroll_year)
FROM czechia_payroll;


SELECT COUNT(*) FROM czechia_payroll_calculation as cpc ;
SELECT *
FROM czechia_payroll_calculation as cpc ;
SELECT *
FROM czechia_payroll_industry_branch as cpib  ;
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


