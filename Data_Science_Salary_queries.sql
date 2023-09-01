-- Visualizing the whole table
SELECT *
FROM PortfolioProject1..DataScienceSalary
ORDER BY 1,7 DESC;

-- Finding all unique job_titles in the table in ascending order
SELECT DISTINCT job_title
FROM PortfolioProject1..DataScienceSalary 
ORDER BY 1 ASC;

-- Finding all unique company_location in ascending order
SELECT DISTINCT company_location
FROM PortfolioProject1..DataScienceSalary 
ORDER BY 1;

-- Looking at salary in Canada
-- Salary is rounded to 2 decimal places 
SELECT 
	work_year,
	job_title,
	company_location, 
	experience_level, 
	employment_type, 
	FORMAT(salary_in_usd_monthly, 'N2') AS salary_usd_mon,
	FORMAT(salary_in_mur_monthly, 'N2') AS salary_usd_mon
FROM PortfolioProject1..DataScienceSalary
WHERE company_location LIKE 'CA'
ORDER BY 1,6 DESC;

-- Looking at salary in Canada
-- Salary is rounded to a whole number
SELECT 
	work_year,
	job_title,
	company_location, 
	experience_level, 
	employment_type, 
	CAST(salary_in_usd_monthly AS INT) AS salary_usd_mon,
	CAST(salary_in_mur_monthly AS INT) AS salary_usd_mon
FROM PortfolioProject1..DataScienceSalary
WHERE company_location LIKE 'CA'
ORDER BY 1,2,6 DESC;

-- Looking at salary in Switzerland
-- Salary is rounded to a whole number
SELECT 
	work_year,
	job_title,
	company_location,
	experience_level, 
	employment_type, 
	CAST(salary_in_usd_monthly AS INT) AS salary_usd_mon,
	CAST(salary_in_mur_monthly AS INT) AS salary_usd_mon
FROM PortfolioProject1..DataScienceSalary
WHERE company_location LIKE 'CH'
ORDER BY 1,2,6 DESC;

-- Looking at maximum salary in Canada
SELECT 
	work_year, 
	job_title,
	experience_level, 
	company_location, 
	MAX(CAST(salary_in_usd_monthly AS INT)) AS salary_usd_mon, 
	MAX(CAST(salary_in_usd_monthly AS INT) * 45.31) AS salary_mur_mon
FROM PortfolioProject1..DataScienceSalary
WHERE company_location LIKE 'CA'
GROUP BY work_year,experience_level,company_location,job_title
ORDER BY 1,4 DESC;

-- Looking at maximum salary in Canada for a Data Scientist for different experience_level
SELECT 
	work_year, 
	job_title, 
	experience_level,
	company_location, 
	MAX(CAST(salary_in_usd_monthly AS INT)) AS salary_usd_mon,
	MAX(CAST(salary_in_usd_monthly AS INT) * 45.31) AS salary_mur_mon
FROM PortfolioProject1..DataScienceSalary
WHERE company_location LIKE 'CA' AND job_title LIKE 'Data Scientist'
GROUP BY work_year,job_title,experience_level,company_location
ORDER BY 1,4 DESC;

-- Looking at maximum salary for all job titles around the world
SELECT 
	work_year, 
	job_title,
	company_location, 
	MAX(CAST(salary_in_usd_monthly AS INT)) AS salary_usd_mon, 
	MAX(CAST(salary_in_usd_monthly AS INT) * 45.31) AS salary_mur_mon
FROM PortfolioProject1..DataScienceSalary
GROUP BY work_year,job_title,company_location
ORDER BY 1,4 DESC;

-- Salary Analysis by Job Title : Calculating the average, minimum, maximum salary for each unique job title in 2023
SELECT 
	job_title, 
	AVG(CAST(salary_in_usd_monthly AS INT)) AS AverageMonthlySalary, 
	MIN(CAST(salary_in_usd_monthly AS INT)) AS MinimumMonthlySalary, 
	MAX(CAST(salary_in_usd_monthly AS INT)) AS MaximumMonthlySalary
FROM PortfolioProject1..DataScienceSalary
WHERE work_year LIKE 2023
GROUP BY job_title
ORDER BY MaximumMonthlySalary DESC;

-- Salary Analysis by Job Title : Identifying the top-paying and lowest-paying job titles based on average salary in 2023
--Using TOP 1 WITH TIES
SELECT TOP 1 WITH TIES 
	job_title, 
	AVG(CAST(salary_in_usd_monthly AS INT)) AS TopPayingSalary
FROM PortfolioProject1..DataScienceSalary
WHERE work_year = 2023
GROUP BY job_title
ORDER BY TopPayingSalary DESC;

SELECT TOP 1 WITH TIES 
	job_title, 
	AVG(CAST(salary_in_usd_monthly AS INT)) AS LowestPayingSalary
FROM PortfolioProject1..DataScienceSalary
WHERE work_year = 2023
GROUP BY job_title
ORDER BY LowestPayingSalary;

-- Using Common Table Expressions (CTE)
WITH AverageSalaries AS (
	SELECT job_title, AVG(CAST(salary_in_usd_monthly AS INT)) AS AverageMonthlySalary
	FROM PortfolioProject1..DataScienceSalary
	WHERE work_year = 2023
	GROUP BY job_title
	)
SELECT job_title, AverageMonthlySalary
FROM AverageSalaries
WHERE
	AverageMonthlySalary = (SELECT MAX(AverageMonthlySalary) FROM AverageSalaries)
	OR
	AverageMonthlySalary = (SELECT MIN(AverageMonthlySalary) FROM AverageSalaries)

-- Salary Analysis by Job Title : Finding the job title with the highest salary increase from 2021 to 2023
WITH SalaryChanges As (
	SELECT job_title, 
			AVG(CASE WHEN work_year = 2021 THEN CAST(salary_in_usd_monthly AS INT) END) AS AverageSalary2021,
			AVG(CASE WHEN work_year = 2023 THEN CAST(salary_in_usd_monthly AS INT) END) AS AverageSalary2023
	FROM PortfolioProject1..DataScienceSalary
	WHERE work_year IN(2021, 2023)
	GROUP BY job_title
	)
SELECT TOP 1 WITH TIES job_title, AverageSalary2021, AverageSalary2023, (AverageSalary2023 - AverageSalary2021) AS salaryIncrease
FROM SalaryChanges
ORDER BY salaryIncrease DESC;

-- Salary Distribution by Experience: Grouping salaries by experience levels and calculate the average salary for each group.
SELECT 
	experience_level, 
	AVG(CAST(salary_in_usd_monthly AS INT)) AS AverageSalaries
FROM PortfolioProject1..DataScienceSalary
GROUP BY experience_level
ORDER BY AverageSalaries DESC;

-- Salary Distribution by Experience: Calculate the median salary for different experience levels.
WITH MedianSalaries AS(
	SELECT 
		experience_level, 
		PERCENTILE_CONT(0.5) WITHIN GROUP(ORDER BY CAST(salary_in_usd_monthly AS INT)) OVER (PARTITION BY experience_level) as MedianSalary
	FROM PortfolioProject1..DataScienceSalary
	)
SELECT experience_level, MedianSalary
FROM MedianSalaries
GROUP BY experience_level, MedianSalary
ORDER BY MedianSalary DESC;

-- Salary Distribution by Experience: Compare the salary growth percentage for different experience levels over the years.
WITH AverageSalaries As (
	SELECT 
		experience_level, 
		work_year, 
		AVG(CAST(salary_in_usd_monthly AS INT)) AS avg_salary
	FROM PortfolioProject1..DataScienceSalary
	GROUP BY experience_level, work_year
	)
SELECT
    A.experience_level,
    A.work_year AS year_start,
    B.work_year AS year_end,
    A.avg_salary AS avg_salary_start,
    B.avg_salary AS avg_salary_end,
    ((B.avg_salary - A.avg_salary) / B.avg_salary) * 100 AS growth_percentage
FROM
    AverageSalaries A
JOIN
    AverageSalaries B ON A.experience_level = B.experience_level AND A.work_year + 1 = B.work_year
ORDER BY
    A.experience_level,
    A.work_year;

-- Location-Based Insights: Determine the average salary for different company locations.
SELECT company_location, AVG(CAST(salary_in_usd_monthly AS INT)) AS AverageSalary
FROM PortfolioProject1..DataScienceSalary
GROUP BY company_location
ORDER BY AverageSalary DESC;

-- Location-Based Insights: Identifying the top-paying and lowest-paying company_location based on average salary in 2023
SELECT TOP 1 WITH TIES company_location, AVG(CAST(salary_in_usd_monthly AS INT)) AS TopPayingSalary
FROM PortfolioProject1..DataScienceSalary
WHERE work_year = 2023
GROUP BY company_location
ORDER BY TopPayingSalary desc;

SELECT TOP 1 WITH TIES company_location, AVG(CAST(salary_in_usd_monthly AS INT)) AS LowestPayingSalary
FROM PortfolioProject1..DataScienceSalary
WHERE work_year = 2023
GROUP BY company_location
ORDER BY LowestPayingSalary asc;

-- Yearly Salary Trends: Calculate the overall average salary for each year (2021, 2022, 2023).
SELECT work_year, AVG(CAST(salary_in_usd_monthly AS INT)) AS AverageSalary
FROM PortfolioProject1..DataScienceSalary
GROUP BY work_year
ORDER BY AverageSalary DESC;

-- Percentile Analysis: Calculate the 25th, 50th (median), and 75th percentiles of salaries for specific job titles.
WITH PercentileData AS (
    SELECT 
        job_title,
        CAST(PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY CAST(salary_in_usd_monthly AS INT)) OVER (PARTITION BY job_title) AS DECIMAL(10, 2)) AS Q1Salary,
        CAST(PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY CAST(salary_in_usd_monthly AS INT)) OVER (PARTITION BY job_title) AS DECIMAL(10, 2)) AS MedianSalary,
        CAST(PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY CAST(salary_in_usd_monthly AS INT)) OVER (PARTITION BY job_title) AS DECIMAL(10, 2)) AS Q3Salary
    FROM PortfolioProject1..DataScienceSalary
    GROUP BY job_title,salary_in_usd_monthly
)
SELECT 
    D.job_title, 
    P.Q1Salary,
    P.MedianSalary,
    P.Q3Salary
FROM PortfolioProject1..DataScienceSalary D
JOIN PercentileData P ON D.job_title = P.job_title
GROUP BY D.job_title, P.Q1Salary, P.MedianSalary, P.Q3Salary
ORDER BY D.job_title DESC;


-- Percentile Analysis: Calculate the 25th, 50th (median), and 75th percentiles of salaries for specific experience levels in year 2023.
WITH PercentileData AS (
    SELECT 
        experience_level,
        CAST(PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY CAST(salary_in_usd_monthly AS INT)) OVER (PARTITION BY experience_level) AS DECIMAL(10, 2)) AS Q1Salary,
        CAST(PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY CAST(salary_in_usd_monthly AS INT)) OVER (PARTITION BY experience_level) AS DECIMAL(10, 2)) AS MedianSalary,
        CAST(PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY CAST(salary_in_usd_monthly AS INT)) OVER (PARTITION BY experience_level) AS DECIMAL(10, 2)) AS Q3Salary
    FROM PortfolioProject1..DataScienceSalary
	WHERE work_year = 2023
    GROUP BY experience_level,salary_in_usd_monthly
)
SELECT 
    D.experience_level, 
    P.Q1Salary,
    P.MedianSalary,
    P.Q3Salary
FROM PortfolioProject1..DataScienceSalary D
JOIN PercentileData P ON D.experience_level = P.experience_level
GROUP BY D.experience_level, P.Q1Salary, P.MedianSalary, P.Q3Salary
ORDER BY D.experience_level DESC;

-- Percentile Analysis: Identify salary outliers and anomalies using percentiles.
WITH SalaryData AS (
    SELECT job_title, CAST(salary_in_usd_monthly AS INT) AS monthly_salary
    FROM PortfolioProject1..DataScienceSalary
    WHERE work_year = 2023  -- Choose the relevant year for analysis
)
SELECT job_title, monthly_salary,
    CASE WHEN monthly_salary < Q1 - 1.5 * IQR OR monthly_salary > Q3 + 1.5 * IQR THEN 'Outlier'
    ELSE 'Not an Outlier'
    END AS outlier_status
FROM (
    SELECT
        job_title,
        monthly_salary,
        PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY monthly_salary) OVER (PARTITION BY job_title) AS Q1,
        PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY monthly_salary) OVER (PARTITION BY job_title) AS Q3,
        (PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY monthly_salary) OVER (PARTITION BY job_title) -
         PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY monthly_salary) OVER (PARTITION BY job_title)) AS IQR
    FROM SalaryData
) AS Percentiles
ORDER BY outlier_status DESC;

-- Advanced Filtering and Subqueries: Retrieve records of individuals with salaries above a certain threshold.

-- Advanced Filtering and Subqueries: Unique job titles with salary above 400,000 MUR in Canada in 2023
SELECT job_title, MAX(CAST(salary_in_mur_monthly AS INT)) as MaxSalary
FROM PortfolioProject1..DataScienceSalary
WHERE CAST(salary_in_mur_monthly AS INT) > 400000 AND company_location = 'CA' AND work_year = 2023
GROUP BY job_title
ORDER BY MaxSalary DESC;

-- Advanced Filtering and Subqueries: Job titles with salary greater than average salary in 2023 using CTE
WITH AvgSalary AS (
	SELECT AVG(CAST(salary_in_mur_monthly AS INT)) AS AverageSalary
	FROM PortfolioProject1..DataScienceSalary
)
SELECT job_title, (CAST(salary_in_mur_monthly AS INT)) AS SalaryInMur, company_location
FROM PortfolioProject1..DataScienceSalary
CROSS JOIN AvgSalary
WHERE (CAST(salary_in_mur_monthly AS INT)) > AvgSalary.AverageSalary AND work_year = 2023
ORDER BY 2 DESC;

-- Advanced Filtering and Subqueries: The top 5 jobs by salary_in_usd in 2023
SELECT TOP 5 *
FROM PortfolioProject1..DataScienceSalary
WHERE work_year = 2023
ORDER BY salary_in_usd_annually DESC

-- Advanced Filtering and Subqueries: Categorize salary into range with CASE statement for year 2023
SELECT experience_level, employment_type, job_title, salary_in_usd_annually, salary_in_mur_annually, company_location,company_size,
CASE 
	WHEN salary_in_usd_annually < 10000 THEN 'Low'
	WHEN salary_in_usd_annually >= 10000 AND salary_in_usd_annually < 50000 THEN 'Medium'
	ELSE 'High'
END AS SalaryRange
FROM PortfolioProject1..DataScienceSalary
WHERE work_year = 2023
ORDER BY salary_in_usd_annually DESC

-- CREATE TEMP TABLE TO STORE DATA
DROP TABLE IF EXISTS #SalaryInCanada2023
CREATE TABLE #SalaryInCanada2023 (
	Year numeric,
	Job_Title nvarchar(50),
	Location nvarchar(5),
	Experience_Level nvarchar(5),
	Experience_Type nvarchar(5),
	Annual_Salary_USD float,
	Annual_Salary_MUR float
)

INSERT INTO #SalaryInCanada2023
SELECT 
	work_year,
	job_title,
	company_location, 
	experience_level, 
	employment_type, 
	CAST(salary_in_usd_annually AS INT) AS salary_usd_ann,
	CAST(salary_in_mur_annually AS INT) AS salary_mur_ann
FROM PortfolioProject1..DataScienceSalary
WHERE company_location LIKE 'CA' AND work_year = 2023

SELECT *
FROM #SalaryInCanada2023
ORDER BY 1,6 DESC;

-- CREATE VIEW TO STORE DATA FOR VISUALIZATION
CREATE VIEW SalaryInCanada2023 AS
SELECT 
	work_year,
	job_title,
	company_location, 
	experience_level, 
	employment_type, 
	CAST(salary_in_usd_monthly AS INT) AS salary_usd_mon,
	CAST(salary_in_mur_monthly AS INT) AS salary_mur_mon
FROM PortfolioProject1..DataScienceSalary
WHERE company_location LIKE 'CA' AND work_year = 2023

SELECT *
FROM SalaryInCanada2023
ORDER BY 1,6 DESC;