-- Finding the most optimal skills for data analysts.
-- Optimal = highest average salary and highest demand

-- We can create a CTE for skills in high demand and a CTE of skills with the highest average salary and join them on their skill_id.

WITH skills_demand_data_analyst AS (
    SELECT
        skills_dim.skill_id,
        skills_dim.skills,
        COUNT(skills_job_dim.job_id) AS demand_count
    FROM
        job_postings_fact
    INNER JOIN skills_job_dim
        ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim
        ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE
        job_postings_fact.job_title_short = 'Data Analyst'
        AND salary_year_avg IS NOT NULL
    GROUP BY
        skills_dim.skill_id
), average_salary_data_analyst AS (
    SELECT
        skills_job_dim.skill_id,
        ROUND(AVG(job_postings_fact.salary_year_avg), 2) AS average_salary
    FROM 
        job_postings_fact
    INNER JOIN skills_job_dim
        ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim 
        ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE
        --job_postings_fact.job_location ILIKE 'new york%'
        job_postings_fact.job_title_short = 'Data Analyst'
        AND salary_year_avg IS NOT NULL
    GROUP BY
        skills_job_dim.skill_id
)

SELECT
    skills_demand_data_analyst.skill_id,
    skills_demand_data_analyst.skills,
    demand_count,
    average_salary

FROM
    skills_demand_data_analyst

INNER JOIN average_salary_data_analyst
    ON skills_demand_data_analyst.skill_id = average_salary_data_analyst.skill_id

WHERE
    demand_count > 10

ORDER BY
    average_salary DESC,
    demand_count DESC


LIMIT 25;
------------------------------------------------------------------------------------------
