-- Find the average salary per skill.
-- We can reuse some of the query from the previous step!

SELECT
    skills,
    ROUND(AVG(job_postings_fact.salary_year_avg), 2) AS average_salary

FROM 
    job_postings_fact

INNER JOIN skills_job_dim AS skills_to_job
    ON job_postings_fact.job_id = skills_to_job.job_id

INNER JOIN skills_dim AS skills
    ON skills_to_job.skill_id = skills.skill_id

WHERE
    --job_postings_fact.job_location ILIKE 'new york%'
    job_postings_fact.job_title_short = 'Data Analyst'
    AND salary_year_avg IS NOT NULL

GROUP BY
    skills

ORDER BY 
    average_salary DESC
LIMIT 25;

SELECT
    skills,
    ROUND(AVG(job_postings_fact.salary_year_avg), 2) AS average_salary

FROM 
    job_postings_fact

INNER JOIN skills_job_dim AS skills_to_job
    ON job_postings_fact.job_id = skills_to_job.job_id

INNER JOIN skills_dim AS skills
    ON skills_to_job.skill_id = skills.skill_id

WHERE
    --job_postings_fact.job_location ILIKE 'new york%'
    job_postings_fact.job_title_short = 'Data Scientist'
    AND salary_year_avg IS NOT NULL

GROUP BY
    skills

ORDER BY 
    average_salary DESC
LIMIT 25;