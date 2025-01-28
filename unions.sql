SELECT
    *

FROM
    january_jobs

UNION

SELECT
    job_title_short,
    company_id,
    job_location

FROM
    february_jobs

UNION

SELECT
    job_title_short,
    company_id,
    job_location

FROM
    march_jobs

-- Problem #1 Create a unified queryt that categorizes job postings into two groups: those with salary information and those without

CREATE TABLE job_postings_with_salary AS
    SELECT
        job_id,
        job_title,
        'With Salary' AS salary_info
    FROM 
        job_postings_fact
    WHERE 
       salary_hour_avg IS NOT NULL
       AND salary_year_avg IS NOT NULL;



CREATE TABLE job_postings_without_salary AS
    SELECT
        job_id,
        job_title,
        'Without Salary' AS salary_info
    FROM 
        job_postings_fact
    WHERE 
        salary_hour_avg IS NULL
        AND salary_year_avg IS NULL;

DROP TABLE job_postings_with_salary


SELECT
    *
FROM
    job_postings_with_salary

UNION ALL

SELECT
    *
FROM
    job_postings_without_salary

ORDER BY
    salary_info DESC,
    job_id;


-----------------------------------------------------------------------------------------------

SELECT
    *
FROM (
    SELECT
        job_id,
        company_id,
        job_title_short,
        salary_year_avg

    FROM
        january_jobs

    UNION ALL

    SELECT
        job_id,
        company_id,
        job_title_short,
        salary_year_avg

    FROM
        february_jobs

    UNION ALL

    SELECT
        job_id,
        company_id,
        job_title_short,
        salary_year_avg

    FROM
        march_jobs
) AS first_quarter_jobs

WHERE
    salary_year_avg > 70000