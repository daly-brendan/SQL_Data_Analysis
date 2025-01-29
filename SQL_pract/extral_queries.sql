SELECT
    job_postings_fact.job_id,
    job_title,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date,
    company_dim.name AS company_name,
    STRING_AGG(skills.skills, ', ') AS skills
  

FROM
    job_postings_fact

LEFT JOIN company_dim
ON job_postings_fact.company_id = company_dim.company_id

LEFT JOIN skills_job_dim as skills_dim
ON job_postings_fact.job_id = skills_dim.job_id

LEFT JOIN skills_dim as skills
ON skills_dim.skill_id = skills.skill_id

WHERE
    job_title_short = 'Data Analyst'
    AND salary_year_avg IS NOT NULL
    AND job_location ILIKE 'new york%'

GROUP BY
    job_postings_fact.job_id,
    job_title,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date,
    company_dim.name

ORDER BY
    salary_year_avg DESC

LIMIT 10;