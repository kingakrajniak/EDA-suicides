CREATE TABLE suicide_rates(country varchar(255), 
						   year int, 
                           sex varchar(255), 
                           age varchar(255),
                           suicides_no int,
                           population varchar(255),
                           suicides_per_100k_pop float(2),
                           country_year varchar(255),
                           HDI_for_year float(3), 
                           gdp_for_year_$ varchar(255),
                           gdp_per_capita_$ int,
                           generation varchar(255));

DROP TABLE suicide_rates;

LOAD DATA LOCAL INFILE 'C:\\Users\\Kinga\\Documents\\projects\\EDA-suicides\\master.csv'
INTO TABLE suicide_rates
FIELDS TERMINATED BY ','
	   OPTIONALLY ENCLOSED BY '"'
      # ESCAPED BY '"'
LINES STARTING BY '"'
	 TERMINATED BY '\r'
IGNORE 1 ROWS;  # last three columns merging into gdp_for_year_$; how to fix it?
# (country, year, sex, age, suicides_no, population, suicides_per_100k_pop, country_year, HDI_for_year, gdp_for_year_$, gdp_per_capita_$, generation);

SHOW GLOBAL VARIABLES LIKE 'local_infile';
SET GLOBAL local_infile=true;
SHOW VARIABLES LIKE 'secure_file_priv';

SELECT * FROM suicide_rates LIMIT 10;