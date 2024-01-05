# DATA USED FROM : https://www.kaggle.com/datasets/harishkumardatalab/data-science-salary-2021-to-2023
## 💰 Data Science Salary 💰 2021 to 2023
## Unveiling Data Science Salary 💸 Trends 2021-2023󠀤 💸

### 1. Visualizing the whole table
```ruby
SELECT *
FROM PortfolioProject1..DataScienceSalary
ORDER BY 1,7 DESC;
```
![image](https://github.com/sheeksha/MSSQL_PortFolio_File/assets/69764380/8c9294dc-1143-44a2-84d4-47a931dad296)

### 2. Finding all unique job_titles in the table in ascending order
```ruby
SELECT DISTINCT job_title
FROM PortfolioProject1..DataScienceSalary 
ORDER BY 1 ASC;
```
![image](https://github.com/sheeksha/MSSQL_PortFolio_File/assets/69764380/43f6e5e0-5840-4e6a-b140-899089dcf899)


### 3. Finding all unique company_location in ascending order
```ruby
SELECT DISTINCT company_location
FROM PortfolioProject1..DataScienceSalary 
ORDER BY 1;
```
![image](https://github.com/sheeksha/MSSQL_PortFolio_File/assets/69764380/22b593cc-6e6e-4a79-a3d4-081e6656c9f7)

### 4. Looking at salary in Canada (Salary is rounded to 2 decimal places)
```ruby
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
```
![image](https://github.com/sheeksha/MSSQL_PortFolio_File/assets/69764380/d470642e-d08d-463f-aae5-ffefa27d751f)

### 5. Looking at salary in Canada (Salary is rounded to a whole number)
```ruby
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
```
![image](https://github.com/sheeksha/MSSQL_PortFolio_File/assets/69764380/de5fd057-f480-49be-9592-e046d24a64e7)

### 6. Looking at salary in Switzerland (Salary is rounded to a whole number)
```ruby
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
```
![image](https://github.com/sheeksha/MSSQL_PortFolio_File/assets/69764380/4fa019e7-c1ba-4cb5-85dc-88113158f455)

### 7. Looking at maximum salary in Canada
```ruby
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
```
![image](https://github.com/sheeksha/MSSQL_PortFolio_File/assets/69764380/ba82bba9-17ff-4a47-8f4e-7766bf1b3cec)

### 8. Looking at maximum salary in Canada for a Data Scientist for different experience_level
```ruby
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
```
![image](https://github.com/sheeksha/MSSQL_PortFolio_File/assets/69764380/dde5d878-3e92-42c8-b478-1968832ac18c)

### 9. Looking at maximum salary for all job titles around the world
```ruby
SELECT 
	work_year, 
	job_title,
	company_location, 
	MAX(CAST(salary_in_usd_monthly AS INT)) AS salary_usd_mon, 
	MAX(CAST(salary_in_usd_monthly AS INT) * 45.31) AS salary_mur_mon
FROM PortfolioProject1..DataScienceSalary
GROUP BY work_year,job_title,company_location
ORDER BY 1,4 DESC;
```
![image](https://github.com/sheeksha/MSSQL_PortFolio_File/assets/69764380/cc778d93-94f0-42bb-91a8-1654049ff317)

### 10. Salary Analysis by Job Title : Calculating the average, minimum, maximum salary for each unique job title in 2023
```ruby
SELECT 
	job_title, 
	AVG(CAST(salary_in_usd_monthly AS INT)) AS AverageMonthlySalary, 
	MIN(CAST(salary_in_usd_monthly AS INT)) AS MinimumMonthlySalary, 
	MAX(CAST(salary_in_usd_monthly AS INT)) AS MaximumMonthlySalary
FROM PortfolioProject1..DataScienceSalary
WHERE work_year LIKE 2023
GROUP BY job_title
ORDER BY MaximumMonthlySalary DESC;
```
![image](https://github.com/sheeksha/MSSQL_PortFolio_File/assets/69764380/815859be-ebde-430a-bdc7-9ddc85aa1211)

### 11. Salary Analysis by Job Title : Identifying the top-paying and lowest-paying job titles based on average salary in 2023
- Using TOP 1 WITH TIES
```ruby
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
```
![image](https://github.com/sheeksha/MSSQL_PortFolio_File/assets/69764380/ae88de6a-f889-4e9c-81b6-308ff6a1265c)

- Using Common Table Expressions (CTE)
```ruby
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
```
![image](https://github.com/sheeksha/MSSQL_PortFolio_File/assets/69764380/caa6a160-2da1-4740-99b9-b5842c559d99)

### 12. Salary Analysis by Job Title : Finding the job title with the highest salary increase from 2021 to 2023
```ruby
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
```
![image](https://github.com/sheeksha/MSSQL_PortFolio_File/assets/69764380/66d15811-84f0-4d2a-9046-d7010a6a6bff)

## 13. Salary Distribution by Experience: Grouping salaries by experience levels and calculate the average salary for each group.
```ruby
SELECT 
	experience_level, 
	AVG(CAST(salary_in_usd_monthly AS INT)) AS AverageSalaries
FROM PortfolioProject1..DataScienceSalary
GROUP BY experience_level
ORDER BY AverageSalaries DESC;
```
![image](https://github.com/sheeksha/MSSQL_PortFolio_File/assets/69764380/4913da66-5883-48d9-ac48-b418012184fe)

### 14. Salary Distribution by Experience: Calculate the median salary for different experience levels.
```ruby
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
```
![image](https://github.com/sheeksha/MSSQL_PortFolio_File/assets/69764380/b7bf3ff8-a278-4dbd-be52-ef89810a2dde)

### 15. Salary Distribution by Experience: Compare the salary growth percentage for different experience levels over the years.
```ruby
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
```
![image](https://github.com/sheeksha/MSSQL_PortFolio_File/assets/69764380/b74a6782-0e13-4454-8f54-57f501db1cdd)

### 16. Location-Based Insights: Determine the average salary for different company locations.
```ruby
SELECT company_location, AVG(CAST(salary_in_usd_monthly AS INT)) AS AverageSalary
FROM PortfolioProject1..DataScienceSalary
GROUP BY company_location
ORDER BY AverageSalary DESC;
```
![image](https://github.com/sheeksha/MSSQL_PortFolio_File/assets/69764380/de3aed28-a987-4351-9b41-0f16d1dbb0f8)

### 17. Location-Based Insights: Identifying the top-paying and lowest-paying company_location based on average salary in 2023
```ruby
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
```
![image](https://github.com/sheeksha/MSSQL_PortFolio_File/assets/69764380/50241ded-d7dd-4087-8372-ab5c33d4cf68)

### 18. Yearly Salary Trends: Calculate the overall average salary for each year (2021, 2022, 2023).
```ruby
SELECT work_year, AVG(CAST(salary_in_usd_monthly AS INT)) AS AverageSalary
FROM PortfolioProject1..DataScienceSalary
GROUP BY work_year
ORDER BY AverageSalary DESC;
```
![image](https://github.com/sheeksha/MSSQL_PortFolio_File/assets/69764380/9789fd22-bdc4-499b-b6e7-2a4611aaa329)

### 19. Percentile Analysis: Calculate the 25th, 50th (median), and 75th percentiles of salaries for specific job titles.
```ruby
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
```
![image](https://github.com/sheeksha/MSSQL_PortFolio_File/assets/69764380/057c5dba-b77e-49ca-9c57-35495b6bf8e2)


### 20. Percentile Analysis: Calculate the 25th, 50th (median), and 75th percentiles of salaries for specific experience levels in year 2023.
```ruby
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
```
![image](https://github.com/sheeksha/MSSQL_PortFolio_File/assets/69764380/225a3328-d566-46c8-88a9-b7cad9dd9e97)

### 21. Percentile Analysis: Identify salary outliers and anomalies using percentiles.
```ruby
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
```
![image](https://github.com/sheeksha/MSSQL_PortFolio_File/assets/69764380/251b8aab-5850-4ca5-8833-12b404e41a21)

### 22. Advanced Filtering and Subqueries: Retrieve records of individuals with salaries above a certain threshold.
- Advanced Filtering and Subqueries: Unique job titles with salary above 400,000 MUR in Canada in 2023
```ruby
SELECT job_title, MAX(CAST(salary_in_mur_monthly AS INT)) as MaxSalary
FROM PortfolioProject1..DataScienceSalary
WHERE CAST(salary_in_mur_monthly AS INT) > 400000 AND company_location = 'CA' AND work_year = 2023
GROUP BY job_title
ORDER BY MaxSalary DESC;
```
![image](https://github.com/sheeksha/MSSQL_PortFolio_File/assets/69764380/9a2c6990-cf55-4be3-b170-676f98de857f)

### 23. Advanced Filtering and Subqueries: Job titles with salary greater than average salary in 2023 using CTE
```ruby
WITH AvgSalary AS (
	SELECT AVG(CAST(salary_in_mur_monthly AS INT)) AS AverageSalary
	FROM PortfolioProject1..DataScienceSalary
)
SELECT job_title, (CAST(salary_in_mur_monthly AS INT)) AS SalaryInMur, company_location
FROM PortfolioProject1..DataScienceSalary
CROSS JOIN AvgSalary
WHERE (CAST(salary_in_mur_monthly AS INT)) > AvgSalary.AverageSalary AND work_year = 2023
ORDER BY 2 DESC;
```
![image](https://github.com/sheeksha/MSSQL_PortFolio_File/assets/69764380/66d4e898-9139-4288-bcc5-b9d7b4e43316)

### 24. Advanced Filtering and Subqueries: The top 5 jobs by salary_in_usd in 2023
```ruby
SELECT TOP 5 *
FROM PortfolioProject1..DataScienceSalary
WHERE work_year = 2023
ORDER BY salary_in_usd_annually DESC
```
![image](https://github.com/sheeksha/MSSQL_PortFolio_File/assets/69764380/9903e809-177c-4fd9-8442-8097fa7d2ecc)

### 25. Advanced Filtering and Subqueries: Categorize salary into range with CASE statement for year 2023
```ruby
SELECT experience_level, employment_type, job_title, salary_in_usd_annually, salary_in_mur_annually, company_location,company_size,
CASE 
	WHEN salary_in_usd_annually < 10000 THEN 'Low'
	WHEN salary_in_usd_annually >= 10000 AND salary_in_usd_annually < 50000 THEN 'Medium'
	ELSE 'High'
END AS SalaryRange
FROM PortfolioProject1..DataScienceSalary
WHERE work_year = 2023
ORDER BY salary_in_usd_annually DESC
```
![image](https://github.com/sheeksha/MSSQL_PortFolio_File/assets/69764380/ae33fe19-2123-48b5-9e41-73288ba09912)

### 26. CREATE TEMP TABLE TO STORE DATA
```ruby
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
```
![image](https://github.com/sheeksha/MSSQL_PortFolio_File/assets/69764380/dea7080b-4ca4-4768-9d37-5f063679c787)

### 27. CREATE VIEW TO STORE DATA FOR VISUALIZATION
```ruby
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
```
![image](https://github.com/sheeksha/MSSQL_PortFolio_File/assets/69764380/220e9ed2-7233-4b78-abc7-029b05c32fc0)
