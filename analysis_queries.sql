-- Job Market Skills & Salary Analytics
-- Import outputs/cleaned_jobs.csv into a SQL table named job_market_jobs first.
-- SQL syntax targets MySQL 8+.

-- 1. Dataset size and salary coverage
SELECT COUNT(*) AS total_jobs,
       SUM(salary_available = 1) AS jobs_with_salary,
       ROUND(100 * AVG(salary_available = 1), 2) AS salary_disclosure_pct
FROM job_market_jobs;

-- 2. Top job titles
SELECT title, COUNT(*) AS job_postings
FROM job_market_jobs
GROUP BY title
ORDER BY job_postings DESC
LIMIT 15;

-- 3. Top companies by number of listings
SELECT companyName, COUNT(*) AS job_postings
FROM job_market_jobs
GROUP BY companyName
ORDER BY job_postings DESC
LIMIT 15;

-- 4. Top raw location labels
SELECT location, COUNT(*) AS job_postings
FROM job_market_jobs
GROUP BY location
ORDER BY job_postings DESC
LIMIT 15;

-- 5. Median/average salary by job title (average shown; use Python notebook for median)
SELECT title,
       COUNT(*) AS salary_postings,
       ROUND(AVG(salary_midpoint_lpa), 2) AS avg_salary_lpa
FROM job_market_jobs
WHERE salary_available = 1
GROUP BY title
HAVING COUNT(*) >= 10
ORDER BY avg_salary_lpa DESC
LIMIT 20;

-- 6. Salary by experience band
SELECT CASE
         WHEN experience_midpoint_years <= 1 THEN '0-1 years'
         WHEN experience_midpoint_years <= 3 THEN '1-3 years'
         WHEN experience_midpoint_years <= 5 THEN '3-5 years'
         WHEN experience_midpoint_years <= 10 THEN '5-10 years'
         WHEN experience_midpoint_years <= 15 THEN '10-15 years'
         ELSE '15+ years'
       END AS experience_band,
       COUNT(*) AS salary_postings,
       ROUND(AVG(salary_midpoint_lpa), 2) AS avg_salary_lpa
FROM job_market_jobs
WHERE salary_available = 1 AND experience_midpoint_years IS NOT NULL
GROUP BY experience_band
ORDER BY MIN(experience_midpoint_years);

-- 7. Duplicate job IDs (should return no rows after notebook cleaning)
SELECT jobId, COUNT(*) AS copies
FROM job_market_jobs
GROUP BY jobId
HAVING COUNT(*) > 1;
