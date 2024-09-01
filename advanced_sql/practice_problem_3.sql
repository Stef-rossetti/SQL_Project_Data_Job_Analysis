/* 
    Write a query to find companies (include company name) that have posted jobs offering health
    insurance, where these postings were made in the second quarter of 2023. Use date extraction
    to filter by quarter.
*/

SELECT 
    company_dim.name,
    COUNT(job_postings_fact.job_id) AS job_postings_count
FROM job_postings_fact
    LEFT JOIN company_dim ON (job_postings_fact.company_id = company_dim.company_id)
WHERE 
    job_health_insurance = TRUE AND EXTRACT(QUARTER FROM job_posted_date) = 2
GROUP BY
    company_dim.name
HAVING
    COUNT(job_postings_fact.job_id) > 0
ORDER BY
	job_postings_count DESC

-------------------------

SELECT 
    companies.name AS name,
    COUNT(job_id) as jobs
FROM job_postings_fact AS postings
LEFT JOIN company_dim AS companies ON (postings.company_id = companies.company_id)
WHERE 
    job_health_insurance = TRUE AND EXTRACT(QUARTER FROM job_posted_date) = 2
GROUP BY
    name
HAVING
    COUNT(job_id) >0
ORDER BY 
    jobs DESC