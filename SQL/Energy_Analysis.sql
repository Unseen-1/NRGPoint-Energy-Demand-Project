USE NRGPointDB
-- Query 1: Average energy demand by temperature range
-- Output: U-shaped curve — Below 0°C=914.2, 0-10°C=697.41, 10-20°C=517.63, 20-30°C=614.97, Above 30°C=818.6
SELECT
    CASE
        WHEN Temperature_C < 0 THEN 'Below 0°C'
        WHEN Temperature_C BETWEEN 0 AND 10 THEN '0-10°C'
        WHEN Temperature_C BETWEEN 10 AND 20 THEN '10-20°C'
        WHEN Temperature_C BETWEEN 20 AND 30 THEN '20-30°C'
        ELSE 'Above 30°C'
    END AS Temp_Range,
    COUNT(*) AS Days,
    ROUND(AVG(Energy_Demand_MWh), 2) AS Avg_Demand
FROM nrgpoint_energy_data
GROUP BY
    CASE
        WHEN Temperature_C < 0 THEN 'Below 0°C'
        WHEN Temperature_C BETWEEN 0 AND 10 THEN '0-10°C'
        WHEN Temperature_C BETWEEN 10 AND 20 THEN '10-20°C'
        WHEN Temperature_C BETWEEN 20 AND 30 THEN '20-30°C'
        ELSE 'Above 30°C'
    END
ORDER BY Avg_Demand DESC;

-- Query 2: Average energy demand by season
-- Output: Winter=843.21, Summer=758.24, Spring=532.55, Autumn=531.55
SELECT
    Season,
    COUNT(*) AS Days,
    ROUND(AVG(Energy_Demand_MWh), 2) AS Avg_Demand
FROM nrgpoint_energy_data
GROUP BY Season
ORDER BY Avg_Demand DESC;

-- Query 3: Peak energy demand day and conditions
-- Output: Top day had unrealistic -12.8°C temp in July — flagged as a data quality/imputation issue
SELECT TOP 5
    Date, Temperature_C, Humidity_pct, Condition, Season, Energy_Demand_MWh
FROM nrgpoint_energy_data
ORDER BY Energy_Demand_MWh DESC;

-- Query 4: Weekday vs Weekend average demand
-- Output: Weekday=673.31, Weekend=647.45
SELECT
    CASE WHEN DATEPART(WEEKDAY, Date) IN (1,7) THEN 'Weekend' ELSE 'Weekday' END AS Day_Type,
    ROUND(AVG(Energy_Demand_MWh), 2) AS Avg_Demand
FROM nrgpoint_energy_data
GROUP BY CASE WHEN DATEPART(WEEKDAY, Date) IN (1,7) THEN 'Weekend' ELSE 'Weekday' END;

-- Query 5: Monthly average energy demand trend
-- Output: Clear seasonal pattern — dips in Apr-May and Sep-Nov, peaks in Jan and Jun-Aug
SELECT
    FORMAT(Date, 'yyyy-MM') AS Month,
    ROUND(AVG(Energy_Demand_MWh), 2) AS Avg_Demand
FROM nrgpoint_energy_data
GROUP BY FORMAT(Date, 'yyyy-MM')
ORDER BY Month;

-- Query 6: Average demand by weather condition
-- Output: Snowy=906.76, Sunny=779.89, Cloudy=691.44, Rainy=605.99, Partly Cloudy=601.68, Drizzle=576.38
SELECT Condition, COUNT(*) AS Days, ROUND(AVG(Energy_Demand_MWh), 2) AS Avg_Demand
FROM nrgpoint_energy_data
GROUP BY Condition
ORDER BY Avg_Demand DESC;

-- Query 7: Humidity effect on demand when temperature is high (>25°C)
-- Output: Low Humidity=752.7, Medium=738.76, High=714.58 (High Humidity sample size only 10 days — limited)
SELECT
    CASE
        WHEN Humidity_pct < 50 THEN 'Low Humidity (<50%)'
        WHEN Humidity_pct BETWEEN 50 AND 70 THEN 'Medium Humidity (50-70%)'
        ELSE 'High Humidity (>70%)'
    END AS Humidity_Range,
    COUNT(*) AS Days,
    ROUND(AVG(Energy_Demand_MWh), 2) AS Avg_Demand
FROM nrgpoint_energy_data
WHERE Temperature_C > 25
GROUP BY
    CASE
        WHEN Humidity_pct < 50 THEN 'Low Humidity (<50%)'
        WHEN Humidity_pct BETWEEN 50 AND 70 THEN 'Medium Humidity (50-70%)'
        ELSE 'High Humidity (>70%)'
    END
ORDER BY Avg_Demand DESC;
