-- Problem 1
SELECT
    salary_year_avg,
    CASE
        WHEN salary_year_avg > 100000 THEN 'High Salary'
        WHEN salary_year_avg BETWEEN 60000 AND 99999 THEN 'Standard Salary'
        ELSE 'Low Salary'
    END AS salaries


FROM
    job_postings_fact

WHERE
    salary_year_avg IS NOT NULL
    AND job_title_short = 'Data Analyst'

ORDER BY
    salary_year_avg DESC

-- Problem 2 Count the number of unique companies that offer WFH vs require work on-site

SELECT
    COUNT(DISTINCT company_id) AS unique_companies,
    CASE
        WHEN job_work_from_home = TRUE THEN 'WFH'
        ELSE 'On-Site'
    END AS work_location

FROM
    job_postings_fact

WHERE
    job_work_from_home IS NOT NULL

GROUP BY
    work_location

-- Problem 3 Write a query that lists all job postings with their job_id, salary_year_avg and two additional columns called experience level and remote option.

SELECT
    job_id,
    salary_year_avg,
    CASE
        WHEN job_title ILIKE '%Senior%' THEN 'Senior'
        WHEN job_title ILIKE '%Manager%' OR job_title ILIKE '%Lead%' THEN 'Lead/Manager'
        WHEN job_title ILIKE '%junior%' OR job_title ILIKE '%entry%' THEN 'Junior/Entry'
        ELSE 'Not Specified'
    END AS experience_level,
    CASE
        WHEN job_work_from_home = TRUE THEN 'Remote'
        ELSE 'On-Site'
    END AS remote_option

FROM
    job_postings_fact

WHERE
    salary_year_avg IS NOT NULL
;
     
     
/*

    WHEN job_title ILIKE '%Senior%' THEN 'Senior'
    WHEN job_title ILIKE '%Manager%' OR job_title ILIKE '%Lead%' THEN 'Lead/Manager'
    WHEN job_title ILIKE '%Junior%' OR job_title ILIKE '%Entry%' THEN 'Junior/Entry'
    ELSE 'Not Specified'

*/