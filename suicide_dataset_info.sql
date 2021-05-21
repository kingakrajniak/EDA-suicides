CREATE TABLE suicide_rates(country varchar(255), 
						   year int, 
                           sex varchar(255), 
                           age varchar(255),
                           suicides_no int,
                           population varchar(255),
                           suicides_per_100k_pop float(2),
                           country_year varchar(255),
                           HDI_for_year varchar(255),  # dhi - human development index (long and healthy life, knowledge, decent standard of living)
                           gdp_for_year_$ varchar(255),  # gdp - gross domestic product (monetary measure of the market value of all the final goods and services produced in a specific time period)
                           gdp_per_capita_$ int,
                           generation varchar(255));

DROP TABLE suicide_rates;

LOAD DATA LOCAL INFILE 'C:\\Users\\Kinga\\Documents\\projects\\EDA-suicides\\master.csv'
INTO TABLE suicide_rates
FIELDS TERMINATED BY ','
	   OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r'
IGNORE 1 ROWS;  # last three columns merging into gdp_for_year_$; how to fix it?
# (country, year, sex, age, suicides_no, population, suicides_per_100k_pop, country_year, HDI_for_year, gdp_for_year_$, gdp_per_capita_$, generation);

SHOW GLOBAL VARIABLES LIKE 'local_infile';
SET GLOBAL local_infile=true;
SHOW VARIABLES LIKE 'secure_file_priv';

SELECT * FROM suicide_rates LIMIT 10;

# suicides number in each country by year
SELECT country, year, SUM(suicides_no) AS suicide_no_sum, HDI_for_year FROM suicide_rates GROUP BY country_year;
# comparison
SELECT country, year, SUM(suicides_no) AS suicide_no_sum FROM suicide_rates GROUP BY country, year;


# checking hdi data
SELECT country, 
	   year, 
       (SELECT COUNT(*) FROM suicide_rates s1 WHERE HDI_for_year LIKE '' AND s1.country = s2.country) AS no_hdi_data, 
       COUNT(*) AS country_data,
       ((SELECT COUNT(*) FROM suicide_rates s1 WHERE HDI_for_year LIKE '' AND s1.country = s2.country) / COUNT(*)) AS no_hdi_data_ratio
FROM suicide_rates s2
GROUP BY country;  # a looot of missing hdi data - should we use it?

SELECT country, 
	   year, 
       (SELECT COUNT(*) FROM suicide_rates s1 WHERE HDI_for_year LIKE '' AND s1.country = s2.country AND year >= 2000) AS no_hdi_data, 
       COUNT(*) AS country_data,
       ((SELECT COUNT(*) FROM suicide_rates s1 WHERE HDI_for_year LIKE '' AND s1.country = s2.country AND year >= 2000) / COUNT(*)) AS no_hdi_data_ratio
FROM suicide_rates s2
WHERE year >= 2000
GROUP BY country;

SELECT country, 
	   year, 
       (SELECT COUNT(*) FROM suicide_rates s1 WHERE HDI_for_year LIKE '' AND s1.country = s2.country AND year >= 2010) AS no_hdi_data, 
       COUNT(*) AS country_data,
       ((SELECT COUNT(*) FROM suicide_rates s1 WHERE HDI_for_year LIKE '' AND s1.country = s2.country AND year >= 2010) / COUNT(*)) AS no_hdi_data_ratio
FROM suicide_rates s2
WHERE year >= 2010
GROUP BY country;  # data improving with time