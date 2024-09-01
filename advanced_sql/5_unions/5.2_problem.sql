Retrieve the job id, job title short, job location, job via, skill and skill type for each 
job posting from the first quarter (January to March). 
Using a subquery to combine job postings from the first quarter 
(these tables were created in the Advanced Section - Practice Problem 6 [include timestamp of Youtube video]) 
Only include postings with an average yearly salary greater than $70,000.

🔎 Hints:
Use UNION ALL to combine job postings from January, February, and March into a single dataset.
Apply a LEFT JOIN to include skills information, allowing for job postings without associated skills to be included.
Filter the results to only include job postings with an average yearly salary above $70,000.

-------

SELECT
    job_postings_q1.job_id,
    job_postings_q1.job_title_short,
    job_postings_q1.job_location,
    job_postings_q1.job_via,
    job_postings_q1.salary_year_avg,
    skills_dim.skills,
    skills_dim.type
FROM
-- Get job postings from the first quarter of 2023
    (
        SELECT *
        FROM january_jobs

        UNION ALL

        SELECT *
        FROM february_jobs

        UNION ALL

        SELECT *
		FROM march_jobs
    ) AS job_postings_q1
LEFT JOIN skills_job_dim ON job_postings_q1.job_id = skills_job_dim.job_id
LEFT JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_postings_q1.salary_year_avg > 70000
ORDER BY
	job_postings_q1.job_id