--Evaluation queries for RIF
--Query Type 1: Explicit Facts Retrieval
-- 1.1. What was the population of France in 2010?
VALUE(?x,population_total(France,?x,2010))
-- 1.2. What was the rural population of India in 1990?
VALUE(?x,rural_population(India,?x,1990))
-- 1.3. What was the GDP of Brazil in 2008?
VALUE(?x,gdp(Brazil,?x,2008))
-- 1.4. What was the total agricultural land area of Norway in 2001?
VALUE(?x,agricultural_land(norway,?x,2001))
-- 1.5. What was the total unemployment of Germany in 2002?
VALUE(?x,unemployment_total(Germany,?x,2002)) 
-- 1.6. What was the total population of UK in 2010?
VALUE(?x,total_population(UK,?x,2010))
-- 1.7. What was the birth rate of China in 2005?
VALUE(?x,birth_rate(China,?x,2005))
-- 1.8. What was the urban population of Ghana in 1998?
VALUE(?x,urban_population(Ghana,?x,1998))
-- 1.9. What was the fertility rate of Chile in 2010?
VALUE(?x,fertility_rate(Chile,?x,2010)) 
-- 1.10. What was the female unemployment rate of Japan in 2011?
VALUE(?x,female_unemployment(Japan,?x,2011))

--Query Type 2: Aggregation
--2.1. What was the total population in 2001 of countries in Europe?
SUM(?y,COMP(<$x,?y>,total_population($x,?y,2001):type($x,country) & location($x,Europe)))
--2.2. What was the average gdp in 2003 of countries in South America?
AVG(?y,COMP(<$x,?y>,gdp($x,?y,2003):type($x,country) & location($x,South_America)))
--2.3. Which country in Africa had the largest agricultural land area in 2006?
MAX($y,COMP(<?x,$y>,agricultural_land(?x,$y,2006):type(?x,country) & location(?x,Africa)))
--2.4. Which country in Asia had the lowest GDP growth rate in 2007?
MIN($y,COMP(<?x,$y>,gdp_rate(?x,$y,2007):type(?x,country) & location(?x,Asia)))
--2.6. Which country in Europe had the highest male unemployment in 2005?
MAX($y,COMP(<?x,$y>,unemployment_male(?x,$y,2005):type(?x,country) & location(?x,Europe)))
--2.6. What was the total wind energy consumption in Europe in 2007?
SUM(?y,COMP(<$x,?y>,wind_energy_consumption($x,?y,2007):type($x,country) & location($x,Europe)))
--2.7. Which country in Asia had the lowest female unemployment in 2003?
MIN($y,COMP(<?x,$y>,female_unemployment(?x,$y,2003):type(?x,country) & location(?x,Asia)))
--2.8. What is the highest urban population of countries in Africa in 2001?
MAX(?y,COMP(<$x,?y>,urban_population($x,?y,2001):type($x,country) & location($x,Africa)))
--2.9. Which country in South America had the highest birth rate in 1995?
MAX($y,COMP(<?x,$y>,birth_rate(?x,$y,1995):type(?x,country) & location(?x,South_America)))
--2.10.Which country had the largest cereal export in Africa in 2000?
MAX($y,COMP(<?x,$y>,cereal_export(?x,$y,2000):type(?x,country) & location(?x,Africa)))

--Query Type 3: Nested Queries
--3.1. What was the GDP in 2010 of the country with the largest agricultural land in Africa?
VALUE(?y,gdp(MAX($b,COMP(<?a,$b>,agricultural_land(?a,$b,2010):type(?a,country) & location(?a,Africa))),?y,2010))
--3.2. Was the rural population of the country with the largest urban population in Africa greater than the rural population of the country with the lowest urban population in Africa in 2003?
GT(?y, MAX(?y,rural_population(COMP(<$a,?y>,urban_population($a,?y,2003):type($a,country)&location($a,Africa)),?y,2003)), MIN(?y,rural_population(COMP(<$b,?y>,urban_population($b,?y,2003):type($b,country) & location($b,Africa)),?y,2003)))
--3.3. What was the female unemployment in 2011 of the country with the largest male unemployment in Europe in 2000? OK
VALUE(?y,female_unemployment(MAX($b,COMP(<?a,$b>,male_unemployment(?a,$b,2000):type(?a,Country) & location(?a,Europe))),?y,2011))
--3.4. Was the gdp in 2005 of the country with the largest cereal export in Africa lower than the gdp of the country with the largest cereal export in South America in 2005? OK
LT(?y, VALUE(?y,gdp(MAX($b,COMP(<?a,$b>,cereal_export(?a,$b,2005):type(?a,country) & location(?a,Africa))),?y,2005)), VALUE(?y,gdp(MAX($b,COMP(<?a,$b>,cereal_export(?a,$b,2005):type(?a,country) & location(?a,South_America))))
--3.5. Was the gdp of the country with the largest land in South America in 2009 greater than the gdp of the country with the largest arable land in Europe in 2009?
GT(?y, VALUE(?y,gdp(MAX($b,COMP(<?a,$b>,arable_land(?a,$b,2010):type(?a,country) & location(?a,South_America))),?y,2010)), VALUE(?y,gdp(MAX($b,COMP(<?a,$b>,arable_land(?a,$b,2010):type(?a,country) & location(?a,Europe))))
--3.6. Is the agricultural land area in Africa greater than the agricultural land area in South America in 2010?
GT(?y, VALUE(?x,agricultural_land(Africa,?x,2010)), VALUE(?x,agricultural_land(South_America,?x,2010)))
--3.7. Was the fertility rate in Taiwan in 2005 less than the fertility rate of Cameroon in 2010?
LT(?y, VALUE(?x,fertility_rate(Taiwan,?x,2010)), VALUE(?x,fertility_rate(Cameroon,?x,2010)))
--3.8. Was the female unemployment rate of Germany less than the average female unemployment in Europe in 2011? 
LT(?y, VALUE(?x,female_unemployment(Germany,?x,2011)), AVG(?y,COMP(<$x,?y>,female_unemployment($x,?y,2010):type($x,Country)&location($x,Europe))))
--3.9. What was the birth rate of the country with the lowest rural populaton in Asia in 2004?
VALUE(?y,birth_rate(MIN($b,COMP(<?a,$b>,rural_population(?a,$b,2004):type(?a,Country) & location(?a,Asia))),?y,2004))
--3.10. What was the urban population of the country with the highest total population in Africa in 2002?
VALUE(?y,urban_population(MAX($b,COMP(<?a,$b>,population_total(?a,$b,2002):type(?a,Country) & location(?a,Asia))),?y,2002))

--Query Type 4: Function learning (Extrapolation and interpolation)
--4.1. What is the predicted population of Japan in 2017?
VALUE(?x,population_total(Japan,?x,2017))
--4.2. What is the estimated birth rate of China in 2022?
VALUE(?x,birth_rate(China,?x,2022))
--4.3. What will be the urban population of Ghana in 2019?
VALUE(?x,urban_population(Ghana,?x,2019))
--4.4. Which country in Europe will have the highest youth unemployment rate in 2018?
MAX($y,COMP(<?x,$y>,youth_unemployment_rate(?x,$y,2018):type(?x,country) & location(?x,Africa)))
--4.5. What will be the female unemployment in 2019 of the country with the largest male unemployment in Europe in 2004?
VALUE(?y,female_unemployment(MAX($b,COMP(<?a,$b>,male_population(?a,$b,2004):type(?a,country) & location(?a,Europe))),?y,2019))
--4.6. Will the birth rate of Nigeria in 2025 greater than the birth rate of Brazil in 2025?
GT(?y, VALUE(?x,birth_rate(Africa,?x,2025)), VALUE(?x,birth_rate(Brazil,?x,2025)))
--4.7. Will the youth unemployment rate of UK be less than the average youth unemployment rate in Europe in 2021? 
LT(?y, VALUE(?x,youth_unemployment(Africa,?x,2010)), AVG(?y,COMP(<$x,?y>,youth_unemployment_rate($x,?y,2021):type($x,country) & location($x,Europe))))
--4.8. What will be the labour force in 2022 of the country with the highest rural population in Asia in 2004?
VALUE(?y,labour_force(MAX($b,COMP(<?a,$b>,rural_population(?a,$b,2004):type(?a,Country) & location($a,Asia))),?y,2022))
--4.9. Which country in South America will have the lowest arable land in 2017?
MAX($y,COMP(<?x,$y>,arable_land(?x,$y,2017):type(?x,Country)&location(?x,South_America)))
--4.10. What was the GPD in 2010 of the country to predicted to have the largest labor force in Europe in 2018?
VALUE(?y,gdp(MAX($b,COMP(<?a,$b>,labor_force(?a,$b,2018):type(?a,Country) & location($a,Europe))),?y,2010))

