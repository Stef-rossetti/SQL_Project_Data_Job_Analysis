Find the count of the number of remote job postings per skill
— Display the top 5 skills by their demand in remote jobs
— Include skill ID, name, and count of postings requiring the skill



-- 1. Create the CTEs for displaying the top 5 skills by their demand in remote jobs

WITH remote_work_skills AS
    (
    SELECT
        skills_job_dim.skill_id,
        COUNT(*) AS skill_count

    FROM skills_job_dim
    INNER JOIN
        job_postings_fact ON job_postings_fact.job_id = skills_job_dim.job_id
    WHERE
        job_postings_fact.job_work_from_home = TRUE AND 
        job_postings_fact.job_title_short = 'Data Analyst'
    GROUP BY
        skills_job_dim.skill_id
    )

-- 2 Connect the created CTE to the skills_dim to get the skills name
SELECT
    skills_dim.skill_id,
    skills_dim.skills,
    skill_count
FROM remote_work_skills
INNER JOIN skills_dim ON remote_work_skills.skill_id = skills_dim.skill_id
    ORDER BY
        skill_count DESC
    LIMIT 5


