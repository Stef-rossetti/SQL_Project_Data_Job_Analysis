SELECT
    AVG(salary_year_avg)::INT AS salary_year,
    AVG(salary_hour_avg)::INT AS salary_hour,
    job_schedule_type
FROM job_postings_fact
WHERE job_posted_date > '2023-06-01'
GROUP BY
    job_schedule_type
ORDER BY
    job_schedule_type