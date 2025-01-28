SELECT name AS company_name

FROM company_dim

WHERE company_id IN (
    SELECT
        company_id
    FROM 
        job_postings_fact
    WHERE
        job_no_degree_mention = true
)

-- CTE

WITH company_job_count AS (
    SELECT
        company_id,
        COUNT(*) AS total_jobs
    FROM
        job_postings_fact
    GROUP BY
        company_id
)

SELECT
    company_dim.name AS company_name,
    company_job_count.total_jobs
FROM
    company_dim

LEFT JOIN company_job_count ON company_job_count.company_id = company_dim.company_id


-- Subqueries Problem Set

-- Problem 1: Identify top 5 skills that are most frequently mentioned in job postings. use a subquery to find the skill ids
/*
SELECT
    skills_dim.skills,
    skills_sub.skill_count
FROM (
    SELECT 
        COUNT(skill_id) AS skill_count,
        skill_id
    FROM
        skills_job_dim
    GROUP BY
        skill_id
    ORDER BY
        skill_count DESC
) AS skills_sub

LEFT JOIN skills_dim ON skills_sub.skill_id = skills_dim.skill_id

LIMIT 5; <- This was incorrect. See below for correct query
*/

SELECT skills_dim.skills
FROM skills_dim
INNER JOIN (
    SELECT 
       skill_id,
       COUNT(job_id) AS skill_count
    FROM skills_job_dim
    GROUP BY skill_id
    ORDER BY COUNT(job_id) DESC
    LIMIT 5
) AS top_skills ON skills_dim.skill_id = top_skills.skill_id
ORDER BY top_skills.skill_count DESC;


-- Problem 2: Determine the size of a company based on the number of job postings. Use a subquery to find the company ids

SELECT
    company_sizes.company_id,
    company_sizes.name,
    CASE
        WHEN company_sizes.job_count < 10 THEN 'Small'
        WHEN company_sizes.job_count < 50 THEN 'Medium'
        ELSE 'Large'
    END AS company_size_category

FROM (
    SELECT
        company_dim.company_id,
        company_dim.name AS name,
        COUNT(job_postings_fact.job_id) AS job_count
    FROM
        company_dim

    INNER JOIN job_postings_fact 
        ON company_dim.company_id = job_postings_fact.company_id
    GROUP BY
        company_dim.company_id
    ORDER BY
        company_id ASC

) AS company_sizes
;


-- Practice Problem #7

-- Find the number of remote job postings per skill
    -- display the top 5 skills by their demand in remote jobs
    -- include skill id,  name, and count of postings requiring that skill

WITH remote_job_skills AS (
    SELECT
        skill_id,
        COUNT(*) AS skill_count
    FROM
        skills_job_dim AS skills_to_job

    INNER JOIN job_postings_fact AS job_postings
        ON job_postings.job_id = skills_to_job.job_id

    WHERE
        job_postings.job_work_from_home = true
        AND job_postings.job_title_short = 'Data Analyst'
        
    GROUP BY
        skill_id
)

SELECT
    skills.skill_id,
    skills AS skill_name,
    skill_count
FROM remote_job_skills

INNER JOIN skills_dim AS skills
    ON skills.skill_id = remote_job_skills.skill_id
ORDER BY
    skill_count DESC
LIMIT 5;


SELECT
    skill_id,
    COUNT(*) AS skill_count
FROM
    skills_job_dim AS skills_to_job

INNER JOIN job_postings_fact AS job_postings
    ON job_postings.job_id = skills_to_job.job_id

WHERE
    job_postings.job_work_from_home = true
    AND job_postings.job_title_short = 'Data Analyst'
    
GROUP BY
    skill_id