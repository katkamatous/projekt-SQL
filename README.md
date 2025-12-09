##  projekt-SQL

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
* **názvy sloupců:** 
`industry_name` - odvětví
`year` - rok
`avg_salary` - průměrná hrubá mzda v daném roce a odvětví
`prev_year_salary` - průměrná hrubá mzda v předchozím roce
`pct_change` - procentuální změna

Dle analýzy dat z tabulky mezd vyplývá, že dlouhodobý trend je ve většině odvětví rostoucí. I přesto jsme však zaznamenali roky, kdy došlo k meziročnímu poklesu mezd. Nejvýraznější poklesy byly zaznamenány v letech 2009, 2011 a 2013, nevyšší pokles nastal v peněžnictví a pojišťovnictví v roce 2013 a to o 8,91 %.


#### 2 - Kolik je možné si koupit litrů mléka a kilogramů chleba za první a poslední srovnatelné období v dostupných datech cen a mezd?
* **názvy sloupců:** 
`year` - rok
`category_name` - název kategorie
`avg_wages` - průměrná hrubá měsíční mzdy v ČR za daný rok, průměr ze všech odvětví
`avg_price` - průměrná cena sledované potraviny
`unit_to_buy` - počet jednotek k zakoupení 

Pro tuto analýzu jsme porovnávali první dostupný rok (2006) a poslední dostupný rok (2018). Výsledky ukazují nárůst kupní síly v obou kategoriích. Zatímco v roce 2006 bylo možné za průměrnou mzdu koupit přibližně 1 287 kg chleba, v roce 2018 to bylo již 1 342 kg. U mléka je trend podobný, kdy jsme zaznamenali nárůst z 1 437 litrů v roce 2006 na 1 642 litrů v roce 2018.


#### 3 - Která kategorie potravin zdražuje nejpomaleji (je u ní nejnižší percentuální meziroční nárůst)? 
* **názvy sloupců:** 
`category_name` - název kategorie
`avg_yearly_growth_percent` - průměrný roční procentuální růst, tempo zdražování


Na základě průměrného meziročního procentuálního nárůstu jsme identifikovali kategorie, které zdražují nejpomaleji, nebo jejichž cena dokonce dlouhodobě klesá. Nejpomalejší tempo růstu (případně pokles) jsme zaznamenali u kategorie "Cukr krystalový" s průměrnou změnou -1,92 % ročně. Mezi další stabilní potraviny patřily například "Rajská jablka červená kulatá". Na opačném konci spektra se nachází "Papriky", které zdražovaly nejrychleji.

#### 4 - Existuje rok, ve kterém byl meziroční nárůst cen potravin výrazně vyšší než růst mezd (větší než 10 %)?
* **názvy sloupců:** 
`year` - rok
`wage_growth_percent` - růst mezd v %
`price_growth_perc` - růst cen potravin v %
`growth_difference_points` - rozdíl v procentních bodech

Analýza meziročních změn průměrných mezd a průměrných cen potravin neukázala žádný rok, ve kterém by nárůst cen potravin přesáhl růst mezd o více než stanovených 10 %. Nejvýraznější rozdíl byl zaznamenán v roce 2013, kdy ceny potravin vzrostly o 5,55 % %, zatímco mzdy klesaly o 1,56 %. Výsledný rozdíl v tomto roce činil 7,11 procentních bodů, což však stále nedosahuje hranice definované ve výzkumné otázce.

#### 5 - Má výška HDP vliv na změny ve mzdách a cenách potravin? Neboli, pokud HDP vzroste výrazněji v jednom roce, projeví se to na cenách potravin či mzdách ve stejném nebo následujícím roce výraznějším růstem?
* **názvy sloupců:** 
`gdp_growth` - růst HDP v %
`salary_growth` - růst mezd v %
`food_price_growth` - růst cen potravin v %
Na základě provedené analýzy nebyla prokázána přímá závislost mezi vývojem HDP, mzdami a cenami potravin. Data ukazují, že se tyto veličiny v mnoha letech vyvíjejí nezávisle na sobě. Například nárůst HDP v roce 2007 se projevil ve mzdách v letech 2007 a 2008, ale nárůst HDP v roce 2015 se již ve mzdách projevil v mnohem menší míře. Dalším příkladem je i rok 2009, kdy HDP výrazně kleslo (-4,7 %), ale průměrné mzdy přesto vzrostly (+3 %).

Ceny potravin vs. HDP: Ceny potravin vykazují mnohem výraznější výkyvy a jejich křivka nekopíruje vývoj HDP. Jejich změny jsou pravděpodobně ovlivněny jinými faktory (např. změny DPH, úroda, importní ceny) než jen výkonem české ekonomiky. 




