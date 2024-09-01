Identify the top 5 skills that are most frequently mentioned in job postings. 
Use a subquery to find the skill IDs with the highest counts in the skills_job_dim table and then join this result with the skills_dim table to get the skill names.

SELECT 
    skills_dim.skills,
    top_skills.skill_count
FROM
    skills_dim
    INNER JOIN ( -- it filters and then merge the info with inner to not show any other data
        SELECT
            skill_id,
            COUNT(job_id) AS skill_count
        FROM
            skills_job_dim
        GROUP BY
            skill_id
        ORDER BY COUNT(job_id) DESC
        LIMIT 5 
    ) AS top_skills ON skills_dim.skill_id = top_skills.skill_id
ORDER BY
    top_skills.skill_count DESC

-- Stefano's

    SELECT
        skills_job_dim.skill_id,
        skills_dim.skills,
        COUNT(job_id) AS skill_count
    FROM
        skills_job_dim
        INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    GROUP BY
        skills_job_dim.skill_id, skills_dim.skills
    ORDER BY   
        skill_count DESC
    LIMIT 5


