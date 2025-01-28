-- Problem 1
SELECT
    job_schedule_type,
    AVG(salary_year_avg) AS avg_salary,
    AVG(salary_hour_avg) AS avg_hourly_salary

FROM
    job_postings_fact

WHERE
    job_posted_date > '2023-06-01'
--    AND salary_hour_avg IS NOT NULL
--    AND salary_year_avg IS NOT NULL

GROUP BY
    job_schedule_type;

-- Problem 3

SELECT
    COUNT(job_postings_fact.job_id) as job_count,
    companies.name
FROM
    job_postings_fact 


LEFT JOIN company_dim as companies 
    ON job_postings_fact.company_id = companies.company_id

WHERE
    job_postings_fact.job_health_insurance = TRUE
    AND EXTRACT(QUARTER FROM job_postings_fact.job_posted_date) = 2
    AND EXTRACT(YEAR FROM job_postings_fact.job_posted_date) = 2023

GROUP BY
    companies.name

ORDER BY
    job_count DESC
    ;





