-- Displaying the population of all countries in 2023 Alphabetically
SELECT Entity,Code,MAX(Year) RecentYear, MAX([Population - Sex: all - Age: all - Variant: estimates]) CurrentPopulation FROM population
WHERE CODE is not NULL
GROUP BY entity,code
ORDER BY ENTITY

-- Displaying the country with the highest population - 2023
SELECT Entity,Code,MAX(Year) RecentYear, MAX([Population - Sex: all - Age: all - Variant: estimates]) CurrentPopulation FROM population
WHERE CODE is  NULL AND Entity like '%(UN)%'
GROUP BY entity,Code
ORDER BY  CurrentPopulation desc

-- Displaying the country with the highest population - 1950
SELECT Entity,Code,MIN(Year) StartYear, MIN([Population - Sex: all - Age: all - Variant: estimates]) StartPopulation FROM population
WHERE CODE is  NULL AND Entity like '%(UN)%'
GROUP BY entity,Code
ORDER BY  StartPopulation desc

-- Displaying the country with the highest population - 2023
SELECT Entity,MIN(Year) StartYear, MIN([Population - Sex: all - Age: all - Variant: estimates]) StartPopulation,
MAX(Year) RecentYear, MAX([Population - Sex: all - Age: all - Variant: estimates]) 
CurrentPopulation FROM population
WHERE CODE is  NULL AND Entity like '%(UN)%'
GROUP BY entity
ORDER BY  CurrentPopulation desc,StartPopulation desc

-- Ratio Increase from 1950 to 2023
SELECT Entity,MIN(Year) StartYear, MIN([Population - Sex: all - Age: all - Variant: estimates]) StartPopulation,
MAX(Year) RecentYear, MAX([Population - Sex: all - Age: all - Variant: estimates]) 
CurrentPopulation FROM population
WHERE CODE is  NULL AND Entity like '%(UN)%'
GROUP BY entity
ORDER BY  CurrentPopulation desc,StartPopulation desc

-- Ratio Increase from 1950 to 2023
WITH cte_1 as (
SELECT Entity,MIN(Year) StartYear, MIN([Population - Sex: all - Age: all - Variant: estimates]) StartPopulation,
MAX(Year) RecentYear, MAX([Population - Sex: all - Age: all - Variant: estimates]) 
CurrentPopulation FROM population
WHERE CODE is  NULL AND Entity like '%(UN)%'
GROUP BY entity
)
SELECT *, ((CurrentPopulation-StartPopulation)/StartPopulation)*100 PopulationGrowth FROM cte_1
ORDER BY PopulationGrowth desc

-- To see population of India
SELECT Entity,Year,[Population - Sex: all - Age: all - Variant: estimates] FROM population
WHERE entity= 'India' 


-- To see growth rate of India
WITH cte_1 as (
SELECT Entity,MIN(Year) StartYear, MIN([Population - Sex: all - Age: all - Variant: estimates]) StartPopulation,
MAX(Year) RecentYear, MAX([Population - Sex: all - Age: all - Variant: estimates]) 
CurrentPopulation FROM population
WHERE CODE is NOT NULL AND entity = 'India'
GROUP BY entity
)
SELECT *, ((CurrentPopulation-StartPopulation)/StartPopulation)*100 PopulationGrowth FROM cte_1
ORDER BY PopulationGrowth desc


-- All countries 
SELECT Entity,year,[Population - Sex: all - Age: all - Variant: estimates] FROM population WHERE CODE IS not null
and Year=2023 AND code not like '%owid%'
GROUP BY Entity,year,[Population - Sex: all - Age: all - Variant: estimates]
ORDER BY Entity
