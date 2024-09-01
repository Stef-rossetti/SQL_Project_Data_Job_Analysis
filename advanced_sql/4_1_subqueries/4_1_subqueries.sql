/*
    • Subquery - query within another query
*/
• It can be used in several places in the main query
    • Such as the SELECT, FROM, WHERE, or HAVING CLAUSES
• Its executed first, and the results are passed to the outer query
    • It is used when you want to perform a calculation before the main query can complete its calculation
--SQL

    SELECT *
    FROM ( --SubQuery starts here
        SELECT *
        FROM job_postings_fact
        WHERE EXTRACT(MONTH FROM job_posted_date) = 1
    ) AS january_jobs;
    -- SubQuery ends here


-- You can filter a criteria from another table:

SELECT 
    company_id,
    name AS company_name
FROM 
    company_dim
WHERE company_id IN (

    SELECT
        company_id
    FROM
        job_postings_fact
    WHERE
        job_no_degree_mention = true
    ORDER BY
        company_id
)