
--  the total number of tourists for each continent over the entire period.
 
 SELECT Continent, SUM(International_touristarrivals_region) AS Totaltourism
 FROM tourism
 GROUP BY Continent
 ORDER BY Totaltourism DESC
 
 -- the year with the highest and lowest total tourist arrivals per continent.
 
SELECT Continent, 
       MAX(Year) AS Year_with_highest_tourist_arrivals,
       MAX(International_touristarrivals_region) AS Max_tourism_arrivals,
       MIN(Year) AS Year_with_lowest_tourist_arrivals,
       MIN(International_touristarrivals_region) AS Min_tourism_arrivals
FROM tourism
GROUP BY Continent;

-- average number of tourists in each continent

SELECT continent, AVG(International_touristarrivals_region) AS Avg_Tourists
FROM tourism
GROUP BY continent
ORDER BY Avg_Tourists DESC;

Comparison between the total tourist arrivals for different continents in 2020.

SELECT continent, International_touristarrivals_region
FROM tourism
WHERE year = '2020'
ORDER BY 2 DESC

-- annual growth rate of tourist arrivals per continent

SELECT Continent, Year,
(International_touristarrivals_region- LAG(International_touristarrivals_region)
OVER (PARTITION BY Continent ORDER BY year)) / LAG(International_touristarrivals_region)
 OVER (PARTITION BY Continent ORDER BY year)*100.0  AS Annual_Growth_Rate
FROM tourism

-- Identifying the year with the highest total tourist arrivals globally.
SELECT 
Year,
SUM(International_touristarrivals_region) AS Global_tourists
FROM tourism
GROUP BY Year
ORDER BY Global_tourists DESC

--growth rate for each continent over the entire period

SELECT 
    Continent,
    ((MAX(International_touristarrivals_region) - MIN(International_touristarrivals_region)) 
    * 100.0 / MIN(International_touristarrivals_region)) AS Growth_rate_percontinent
FROM 
    tourism
GROUP BY 
    Continent;

-- Annual comparison between average tourists arrivals in Europe and Africa

SELECT Continent,Year, (AVG(International_touristarrivals_region)) AS Average_tourismAnnually
FROM tourism
WHERE Continent IN ('Africa', 'Europe')
GROUP BY Continent,Year
ORDER BY Average_tourismAnnually DESC

--Creating views for visualisation later

CREATE VIEW Total_Tourism_Globally
AS
SELECT Continent, SUM(International_touristarrivals_region) AS Totaltourism
 FROM tourism
 GROUP BY Continent
 ORDER BY Totaltourism DESC

 CREATE VIEW Tourist_per_year
 AS
SELECT 
Year,
SUM(International_touristarrivals_region) AS Global_tourists
FROM tourism
GROUP BY Year
ORDER BY Global_tourists DESC

CREATE VIEW Growthrate_comparison_percontinent
 AS
SELECT Continent, Year,
(International_touristarrivals_region- LAG(International_touristarrivals_region)
OVER (PARTITION BY Continent ORDER BY year)) / LAG(International_touristarrivals_region)
 OVER (PARTITION BY Continent ORDER BY year)*100.0  AS Annual_Growth_Rate
FROM tourism
 
CREATE VIEW Comparison_Africa_Europe AS
SELECT Continent, Year, AVG(International_touristarrivals_region) AS Average_tourism_Annually
FROM tourism
WHERE Continent IN ('Africa', 'Europe')
GROUP BY Continent, Year
ORDER BY Average_tourism_Annually DESC;

 






  


 
 
 
 