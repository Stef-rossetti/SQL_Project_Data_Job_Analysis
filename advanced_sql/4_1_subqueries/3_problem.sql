Find companies that offer an average salary above the overall average yearly salary of all job postings. 
Use subqueries to select companies with an average salary higher than the overall average salary (which is another subquery).

 Hints:

Start by separating the task into two main steps:
    calculating the overall average salary
    identifying companies with higher averages.
Use a subquery (subquery 1) to find the average yearly salary across all job postings. Then join this subquery onto the company_dim table.
Use another a subquery (subquery 2) to establish the overall average salary, which will help in filtering in the WHERE clause companies with higher average salaries.
Determine each companys average salary (what you got from the subquery 1) and compare it to the overall average you calculated (subquery 2). 
Focus on companies that greater than this average.


-- calculating the overall average salary

SELECT
    company_dim.name,
    company_salaries.average_salary
FROM
    company_dim
    INNER JOIN ( -- subquery 1.
        SELECT
            company_id,
            AVG(salary_year_avg)::INT AS average_salary
        FROM job_postings_fact
        GROUP BY
            company_id
    ) AS company_salaries  ON company_salaries.company_id = company_dim.company_id
    WHERE 
        ( -- subquery 2.
        SELECT
            AVG(salary_year_avg)::INT
        FROM job_postings_fact
        ) < company_salaries.average_salary
    ORDER BY
        company_salaries.average_salary ASC