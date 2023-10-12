-- Tableau tables

--TABLE 1
-- Location-Based Insights: Identifying the top-paying and lowest-paying company_location based on average salary in 2023
SELECT TOP 1 WITH TIES company_location, AVG(CAST(salary_in_usd_monthly AS INT)) AS TopPayingSalary
FROM PortfolioProject1..DataScienceSalary
WHERE work_year = 2023
GROUP BY company_location
ORDER BY TopPayingSalary desc;

-- TABLE 2
-- Salary Distribution by Experience: Grouping salaries by experience levels and calculate the average salary for each group.
SELECT 
	experience_level, 
	AVG(CAST(salary_in_usd_monthly AS INT)) AS AverageSalaries
FROM PortfolioProject1..DataScienceSalary
GROUP BY experience_level
ORDER BY AverageSalaries DESC;

-- TABLE 3
-- Location-Based Insights: Determine the average salary for different company locations.
SELECT company_location, AVG(CAST(salary_in_usd_monthly AS INT)) AS AverageSalary
FROM PortfolioProject1..DataScienceSalary
GROUP BY company_location
ORDER BY AverageSalary DESC;

-- TABLE 4
-- Looking at progression of salary for  data scientist
SELECT 
	work_year, 
	job_title,
	company_location, 
	MAX(CAST(salary_in_usd_monthly AS INT)) AS salary_usd_mon, 
	MAX(CAST(salary_in_usd_monthly AS INT) * 45.31) AS salary_mur_mon
FROM PortfolioProject1..DataScienceSalary
WHERE job_title LIKE 'Data Scientist'
GROUP BY work_year,job_title,company_location
ORDER BY 1,4 DESC;