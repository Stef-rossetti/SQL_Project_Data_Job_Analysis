/*Explore job postings by listing job id, job titles, company names, and their average salary rates, 
while categorizing these salaries relative to the average in their respective countries. 
Include the month of the job posted date. 
Use CTEs, conditional logic, and date functions, to compare individual salaries with national averages.

Tables: 
    job_postings_fact
    company_dim
*/
WITH avg_salaries AS (
    SELECT 
        job_country,
        AVG(salary_year_avg)::INT AS location_avg_salary
    FROM job_postings_fact
    GROUP BY
        job_country
)

SELECT
    job_postings_fact.job_country,
    job_postings_fact.job_title_short,
    company_dim.name AS company_name,
    EXTRACT(MONTH FROM job_posted_date) AS posting_month,
    EXTRACT(YEAR FROM job_posted_date) AS posting_year,
    salary_year_avg,
    CASE
        WHEN salary_year_avg < location_avg_salary THEN 'Below average'
        WHEN salary_year_avg > location_avg_salary THEN 'Above average'
        WHEN salary_year_avg = location_avg_salary THEN 'Average'
        END AS salary_category
FROM job_postings_fact
INNER JOIN avg_salaries ON avg_salaries.job_country = job_postings_fact.job_country
INNER JOIN company_dim ON company_dim.company_id = job_postings_fact.company_id
WHERE
    salary_year_avg IS NOT NULL
ORDER BY
    job_posted_date DESC
