##  projekt-SQL

Popis projektu
Příprava datových pokladů pro porovnání dostupnosti potravin na základě průměrných příjmů za časové období 2006 - 2018 v ČR. 

## Popis dat a výstupních tabulek

Pro účely analýzy byly z primárních zdrojů vytvořeny dvě finální tabulky, se kterými dále pracují analytické SQL skripty. Data pokrývají období let 2006 až 2018, které je společné pro mzdy i ceny potravin.

### 1. Tabulka `t_katerina_matouskova_project_SQL_primary_final`
Tato tabulka sjednocuje data o mzdách a cenách potravin v České republice.
* **Obsah:** Rok, odvětví, průměrná mzda, kategorie potravin a jejich průměrná cena.
* **Metodika:** Mzdy vycházejí z "přepočtených počtů" zaměstnanců. Ceny potravin jsou zprůměrovány za celou ČR pro daný rok.
* **Chybějící hodnoty:** V některých dřívějších letech nejsou dostupná data pro všechny kategorie potravin (např. u některých druhů ovoce/zeleniny), tyto záznamy byly při agregaci vynechány, aby nedocházelo ke zkreslení.

### 2. Tabulka `t_katerina_matouskova_project_SQL_secondary_final`
Tato tabulka slouží pro dodatečné srovnání s evropskými státy.
Rok, název země, HDP, GINI koeficient a populace.
* **Chybějící hodnoty:** Data o HDP nebo GINI koeficientu nejsou v zdrojové tabulce `economies` dostupná pro všechny země a roky. Analýza se proto zaměřuje primárně na státy, kde jsou časové řady kompletní.

### Otázky

#### 1 - Rostou v průběhu let mzdy ve všech odvětvích, nebo v některých klesají?
* **Obsah:** 
'industry_name' - odvětví
'year' - rok
'avg_salary' - průměrná hrubá mzda v daném roce a odvětví
'prev_year_salary' - průměrná hrubá mzda v předchozím roce
'pct_change' - procentuální změna

Dle analýzy dat z tabulky mezd vyplývá, že dlouhodobý trend je ve většině odvětví rostoucí. I přesto jsme však zaznamenali roky, kdy došlo k meziročnímu poklesu mezd. Nejvýraznější poklesy byly zaznamenány v letech 2009, 2011 a 2013, nevyšší pokles nastal v peněžnictví a pojišťovnictví v roce 2013 a to o 8,91 %.


## otázka č. 2 - Kolik je možné si koupit litrů mléka a kilogramů chleba za první a poslední srovnatelné období v dostupných datech cen a mezd?
### dotaz odpovídá na počet kusů/litrů v roce 2006 a 2018


## otázka č. 3 - Která kategorie potravin zdražuje nejpomaleji (je u ní nejnižší percentuální meziroční nárůst)? 
### cukr krystalový 

## otázka č. 4 - Existuje rok, ve kterém byl meziroční nárůst cen potravin výrazně vyšší než růst mezd (větší než 10 %)?
### výsledek - roky, kdy rostly ceny potravin rychleji než mzdy, potraviny nerostly nikdy o více  než 10%

## otázka č. 5 - Má výška HDP vliv na změny ve mzdách a cenách potravin? Neboli, pokud HDP vzroste výrazněji v jednom roce, projeví se to na cenách potravin či mzdách ve stejném nebo následujícím roce výraznějším růstem?
### výše HDP, meziroční nárůst HPD, platů, ceny potravin, porovnání meziroční růst HDP - meziroční růst mezd, HDP - potraviny, potraviny - mzdy


