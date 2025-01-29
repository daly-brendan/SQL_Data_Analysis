/*
This first query is going to return the top paying jobs for both data analysts and data scientists available in New York or remotely.
Identify the top 10 paying jobs for data analysts and data scientists.
Focus on job postings without missing information in the salary columns.
Why? We should highlight the top paying jobs for data analysts and data scientists to attract more candidates.
*/

-- Create a table for data analyst jobs so we can easily query it later.
-- We can also merge the tables later on if needed.

-- Find the top 10 paying jobs for data analysts in New York or remotely

SELECT
    job_id,
    job_title,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date,
    company_dim.name AS company_name

FROM
    job_postings_fact

LEFT JOIN company_dim
ON job_postings_fact.company_id = company_dim.company_id

WHERE
    job_title_short = 'Data Analyst'
    AND salary_year_avg IS NOT NULL
    AND job_location ILIKE 'new york%'
    


ORDER BY
    salary_year_avg DESC

LIMIT 10;


SELECT
    job_id,
    job_title,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date,
    company_dim.name AS company_name

FROM
    job_postings_fact

LEFT JOIN company_dim
ON job_postings_fact.company_id = company_dim.company_id

WHERE
    job_title_short = 'Data Scientist'
    AND salary_year_avg IS NOT NULL
    AND job_location ILIKE 'new york%'
    


ORDER BY
    salary_year_avg DESC

LIMIT 10;


COPY (
    WITH top_10_data_scientist_jobs AS (
        SELECT
            job_id,
            job_title,
            job_location,
            job_schedule_type,
            salary_year_avg,
            job_posted_date,
            company_dim.name AS company_name
        FROM job_postings_fact
        LEFT JOIN company_dim
        ON job_postings_fact.company_id = company_dim.company_id
        WHERE job_title_short = 'Data Scientist'
        AND salary_year_avg IS NOT NULL
        AND job_location ILIKE 'new york%'
        ORDER BY salary_year_avg DESC
        LIMIT 10
    )
    SELECT * FROM top_10_data_scientist_jobs
) TO 'C:\Users\dalys\OneDrive\Desktop\SQL_Data_Analysis\project_SQL\top_10_data_science_roles.csv' WITH CSV HEADER;

COPY (
    WITH top_10_data_analyst_jobs AS (
        SELECT
            job_id,
            job_title,
            job_location,
            job_schedule_type,
            salary_year_avg,
            job_posted_date,
            company_dim.name AS company_name
        FROM job_postings_fact
        LEFT JOIN company_dim
        ON job_postings_fact.company_id = company_dim.company_id
        WHERE job_title_short = 'Data Analyst'
        AND salary_year_avg IS NOT NULL
        AND job_location ILIKE 'new york%'
        ORDER BY salary_year_avg DESC
        LIMIT 10
    )
    SELECT * FROM top_10_data_analyst_jobs
) TO 'C:\Users\dalys\OneDrive\Desktop\SQL_Data_Analysis\project_SQL\top_10_data_analyst_roles.csv' WITH CSV HEADER;