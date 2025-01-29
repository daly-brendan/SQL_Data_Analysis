/*

Question to answer:
    1. What are the skills required for the top paying jobs in New York City?
    2. Skills used here: JOINS, CTEs, COPY/EXPORT
*/


WITH top_10_data_analyst_job_skills AS (
    SELECT
        job_id,
        job_title,
        salary_year_avg,
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

    LIMIT 10
)

SELECT
    top_10_data_analyst_job_skills.*,
    skills
FROM
    top_10_data_analyst_job_skills

INNER JOIN skills_job_dim
    ON top_10_data_analyst_job_skills.job_id = skills_job_dim.job_id

INNER JOIN skills_dim
    ON skills_job_dim.skill_id = skills_dim.skill_id

ORDER BY
    salary_year_avg DESC


/*

Now do the same thing for data science jobs in New York City.

*/

WITH top_10_data_science_job_skills AS (
    SELECT
        job_id,
        job_title,
        salary_year_avg,
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

    LIMIT 10
)

SELECT
    top_10_data_science_job_skills.*,
    skills
FROM
    top_10_data_science_job_skills

INNER JOIN skills_job_dim
    ON top_10_data_science_job_skills.job_id = skills_job_dim.job_id

INNER JOIN skills_dim
    ON skills_job_dim.skill_id = skills_dim.skill_id

ORDER BY
    salary_year_avg DESC