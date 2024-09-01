Calculate the number of unique skills required by each company. 
Aim to quantify the unique skills required per company and identify which of these companies
offer the highest average salary for positions necessitating at least one skill. 
For entities without skill-related job postings, list it as a zero skill requirement and a null salary. 
Use CTEs to separately assess the unique skill count and the maximum average salary offered by these companies.

Use two CTEs.
The first should focus on counting the unique skills required by each company.
The second CTE should aim to find the highest average salary offered by these companies.

-- 1st CTE, count the skills per company

WITH required_skills AS (
  SELECT
    companies.company_id,
    COUNT(DISTINCT skills_to_job.skill_id) AS unique_skills_required
  FROM
    company_dim AS companies 
  LEFT JOIN job_postings_fact as job_postings ON companies.company_id = job_postings.company_id
  LEFT JOIN skills_job_dim as skills_to_job ON job_postings.job_id = skills_to_job.job_id
  GROUP BY
    companies.company_id
),
-- Gets the highest average yearly salary from the jobs that require at least one skills 
max_salary AS (
  SELECT
    job_postings.company_id,
    MAX(job_postings.salary_year_avg) AS highest_average_salary
  FROM
    job_postings_fact AS job_postings
  WHERE
    job_postings.job_id IN (SELECT job_id FROM skills_job_dim)
  GROUP BY
    job_postings.company_id
)
-- Joins 2 CTEs with table to get the query
SELECT
  companies.name,
  required_skills.unique_skills_required as unique_skills_required, --handle companies w/o any skills required
  max_salary.highest_average_salary
FROM
  company_dim AS companies
LEFT JOIN required_skills ON companies.company_id = required_skills.company_id
LEFT JOIN max_salary ON companies.company_id = max_salary.company_id
ORDER BY
	companies.name;

