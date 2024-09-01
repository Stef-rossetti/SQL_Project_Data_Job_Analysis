SELECT
    job_title_short,
    company_dim.name AS company_name,
    job_location,
    salary_year_avg
FROM job_postings_fact
INNER JOIN
    company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE
    search_location = 'Spain' AND
    salary_year_avg IS NOT NULL AND
    job_title_short LIKE '%Analyst%'
GROUP BY
    job_title_short,
    company_name,
    job_location,
    salary_year_avg
ORDER BY
    salary_year_avg ASC,
    company_name