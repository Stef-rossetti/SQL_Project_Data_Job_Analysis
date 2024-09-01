/*
    Common Table Expressions (CTEs): define a temporary result set that you can reference
*/
    • Can reference within a SELECT, INSERT, UPDATE, or DELETE statement
    • Defined with WITH at the beginning of a query
    • Exists only during the execution of a query
    • Its a defined query that can be referenced in the main query or other CTEs

-- SQL

WITH january_jobs AS ( -- CTE definition starts here
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 1
) -- CTE definition ends here

SELECT *
FROM january_jobs;


/* Find the companies that have the most job openings.
- Get the total number of job postings per company id (job_posting_fact)
- Return the total number of jobs with the company name (company_dim)
*/

WITH company_job_count AS (
SELECT
    company_id,
    COUNT(*) AS total_jobs
FROM
    job_postings_fact
GROUP BY
    company_id
)
SELECT 
    company_dim.company_id,
    company_dim.name AS company_name,
    company_job_count.total_jobs
FROM company_dim
LEFT JOIN company_job_count ON company_job_count.company_id = company_dim.company_id
ORDER BY
    total_jobs DESC