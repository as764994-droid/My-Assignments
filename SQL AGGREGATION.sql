-- Use the World database

USE world;

-- SOLUTIONS

-- Question 1: Count how many cities are there in each country?
SELECT 
    co.Name AS CountryName,
    COUNT(ci.ID) AS NumberOfCities
FROM country co
LEFT JOIN city ci 
ON co.Code = ci.CountryCode
GROUP BY co.Code, co.Name
ORDER BY NumberOfCities DESC;


-- Question 2: Display all continents having more than 30 countries
SELECT 
    Continent,
    COUNT(*) AS NumberOfCountries
FROM country
GROUP BY Continent
HAVING COUNT(*) > 30
ORDER BY NumberOfCountries DESC;


-- Question 3: List regions whose total population exceeds 200 million
SELECT 
    Region,
    SUM(Population) AS TotalPopulation
FROM country
GROUP BY Region
HAVING SUM(Population) > 200000000
ORDER BY TotalPopulation DESC;


-- Question 4: Find the top 5 continents by average GNP per country
SELECT 
    Continent,
    AVG(GNP) AS AverageGNP,
    COUNT(*) AS NumberOfCountries
FROM country
WHERE GNP > 0  -- Exclude countries with no GNP data
GROUP BY Continent
ORDER BY AverageGNP DESC
LIMIT 5;


-- Question 5: Find the total number of official languages spoken in each continent
SELECT 
    co.Continent,
    COUNT(DISTINCT cl.Language) AS TotalOfficialLanguages
FROM country co
INNER JOIN countrylanguage cl 
ON co.Code = cl.CountryCode
WHERE cl.IsOfficial = 'T'
GROUP BY co.Continent
ORDER BY TotalOfficialLanguages DESC;


-- Question 6: Find the maximum and minimum GNP for each continent
SELECT 
    Continent,
    MAX(GNP) AS MaximumGNP,
    MIN(GNP) AS MinimumGNP,
    MAX(GNP) - MIN(GNP) AS GNPRange
FROM country
WHERE GNP > 0  -- Exclude countries with no GNP data
GROUP BY Continent
ORDER BY MaximumGNP DESC;


-- Question 7: Find the country with the highest average city population
SELECT 
    co.Name AS CountryName,
    co.Code AS CountryCode,
    AVG(ci.Population) AS AverageCityPopulation,
    COUNT(ci.ID) AS NumberOfCities
FROM country co
INNER JOIN city ci
ON co.Code = ci.CountryCode
GROUP BY co.Code, co.Name
ORDER BY AverageCityPopulation DESC
LIMIT 1;


-- Question 8: List continents where the average city population is greater than 200,000
SELECT 
    co.Continent,
    AVG(ci.Population) AS AverageCityPopulation,
    COUNT(ci.ID) AS TotalCities
FROM country co
INNER JOIN city ci 
ON co.Code = ci.CountryCode
GROUP BY co.Continent
HAVING AVG(ci.Population) > 200000
ORDER BY AverageCityPopulation DESC;


-- Question 9: Find the total population and average life expectancy for each continent, 
-- ordered by average life expectancy descending
SELECT 
    Continent,
    SUM(Population) AS TotalPopulation,
    ROUND(AVG(LifeExpectancy), 2) AS AverageLifeExpectancy,
    COUNT(*) AS NumberOfCountries
FROM country
WHERE LifeExpectancy IS NOT NULL  -- Exclude countries with no life expectancy data
GROUP BY Continent
ORDER BY AverageLifeExpectancy DESC;


-- Question 10: Find the top 3 continents with the highest average life expectancy, 
-- but only include those where the total population is over 200 million
SELECT 
    Continent,
    ROUND(AVG(LifeExpectancy), 2) AS AverageLifeExpectancy,
    SUM(Population) AS TotalPopulation,
    COUNT(*) AS NumberOfCountries
FROM country
WHERE LifeExpectancy IS NOT NULL
GROUP BY Continent
HAVING SUM(Population) > 200000000
ORDER BY AverageLifeExpectancy DESC
LIMIT 3;

