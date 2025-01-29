-- Write a query using a CTE that find the top 5 most in demand skills for Data Analysts who work in New York.

WITH data_analyst_remote_job_skills AS (
    SELECT
        skill_id,
        COUNT(*) AS skill_count
    FROM
        skills_job_dim AS skills_to_job

    INNER JOIN job_postings_fact AS job_postings
        ON job_postings.job_id = skills_to_job.job_id

    WHERE
        job_postings.job_location ILIKE 'new york%'
        AND job_postings.job_title_short = 'Data Analyst'
        
    GROUP BY
        skill_id
)

SELECT
    skills.skill_id,
    skills AS skill_name,
    skill_count
FROM data_analyst_remote_job_skills

INNER JOIN skills_dim AS skills
    ON skills.skill_id = data_analyst_remote_job_skills.skill_id
ORDER BY
    skill_count DESC
LIMIT 5;

-- Write the same query but this time for Data Scientists looking for work in New York.

WITH data_science_remote_job_skills AS (
    SELECT
        skill_id,
        COUNT(*) AS skill_count
    FROM
        skills_job_dim AS skills_to_job

    INNER JOIN job_postings_fact AS job_postings
        ON job_postings.job_id = skills_to_job.job_id

    WHERE
        job_postings.job_location ILIKE 'new york%'
        AND job_postings.job_title_short = 'Data Scientist'
        
    GROUP BY
        skill_id
)

SELECT
    skills.skill_id,
    skills AS skill_name,
    skill_count
FROM data_science_remote_job_skills

INNER JOIN skills_dim AS skills
    ON skills.skill_id = data_science_remote_job_skills.skill_id
ORDER BY
    skill_count DESC
LIMIT 5;