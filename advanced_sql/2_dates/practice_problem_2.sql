/*Write a query to count the number of job postings for each month in 2023, adjusting the job_posting_date to be in 'America/New_York' time zone before extracting (hint) the month.
Assume the job_posted_date is stored in UTC. Group by and order by the month.
*/


SELECT 
    EXTRACT(MONTH FROM job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'EST') AS month,
    EXTRACT(YEAR FROM job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'EST') AS year,
    COUNT(job_id) AS job_postings
FROM job_postings_fact
WHERE
    EXTRACT(YEAR FROM job_posted_date) = '2023'
GROUP BY
    month, year
ORDER BY
    job_postings DESC
    

