SELECT job_posted_date
FROM job_postings_fact
LIMIT 10;

SELECT
    job_title_short AS title,
    job_location AS location,
    job_posted_date::DATE AS date
FROM job_postings_fact;


--SELECT column name AT TIME ZONE 'EST'


SELECT 
    job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'EST' AS modified_time,
    job_posted_date
FROM job_postings_fact
LIMIT 5;

--SELECT EXTRACT(MONTH FROM column_name) AS column_month

SELECT
    job_title_short AS title,
    job_location AS location,
    job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'EST' AS date_time,
    EXTRACT(MONTH FROM job_posted_date) AS date_month,
    EXTRACT(YEAR FROM job_posted_date) AS date_year
FROM job_postings_fact
LIMIT 5;

SELECT 
    COUNT (job_id) AS job_posted_count,
    EXTRACT (MONTH FROM job_posted_date) as month
FROM job_postings_fact
WHERE 
    job_title_short = 'Data Analyst'
GROUP BY
    month
ORDER BY
    job_posted_count DESC