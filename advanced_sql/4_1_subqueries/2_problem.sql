Determine the size category ('Small', 'Medium', or 'Large') for each company by first identifying the number of job postings they have. 
Use a subquery to calculate the total job postings per company. 
A company is considered 'Small' if it has less than 10 job postings, 'Medium' if the number of job postings is between 10 and 50, and 'Large' if it has more than 50 job postings. 
Implement a subquery to aggregate job counts per company before classifying them based on size.

-- Course, he created a new table and from that one selected the columns.
SELECT 
	company_id,
    name,
    CASE
        WHEN job_count < 10 THEN 'Small'
            WHEN job_count BETWEEN 10 AND 50 THEN 'Medium'
            ELSE 'Large'
            END AS company_size
FROM (
  SELECT 
		company_dim.company_id, 
		company_dim.name, 
		COUNT(job_postings_fact.job_id) as job_count
  FROM 
		company_dim
  INNER JOIN job_postings_fact ON company_dim.company_id = job_postings_fact.company_id
  GROUP BY 
		company_dim.company_id, 
		company_dim.name
) AS company_job_count;

-- Optimized solution, from the company_dim table it merges the job_postings_fact to be able to use job_id to count the positions.
SELECT 
    company_dim.company_id, 
    name,
    COUNT(job_id) AS job_count,
    CASE
        WHEN COUNT(job_id) <= 10 THEN 'Small'
        WHEN COUNT(job_id) >= 60 THEN 'Large'
        ELSE 'Medium'
        END AS company_size
FROM company_dim
INNER JOIN job_postings_fact ON job_postings_fact.company_id = company_dim.company_id
GROUP BY 
    company_dim.company_id, name



