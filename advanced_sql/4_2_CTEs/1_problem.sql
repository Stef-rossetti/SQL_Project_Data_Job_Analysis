Identify companies with the most diverse (unique) job titles. 
Use a CTE to count the number of unique job titles per company, then select companies with the
highest diversity in job titles.

-- WITH CTE

WITH title_diversity AS (
    SELECT
        COUNT(DISTINCT job_title) AS unique_titles,
        company_id
    FROM job_postings_fact
    GROUP BY
        company_id
)

SELECT
    name AS company_name,
    unique_titles
FROM company_dim
INNER JOIN title_diversity ON title_diversity.company_id = company_dim.company_id
ORDER BY
    unique_titles DESC
LIMIT 10

-- Without CTE

SELECT
    name AS company_name,
    COUNT(DISTINCT job_title) AS unique_titles
FROM company_dim
LEFT JOIN
    job_postings_fact ON company_dim.company_id = job_postings_fact.company_id
GROUP BY
    company_name
ORDER BY
    unique_titles DESC
LIMIT 10