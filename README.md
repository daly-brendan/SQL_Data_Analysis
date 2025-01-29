# SQL Exploratory Analysis

## Introduction
In this project I follow Luke Barousse's SQL for [Data Analytics course and certification](https://www.youtube.com/watch?v=7mz73uXD9DA&ab_channel=LukeBarousse) where we use SQL to analyze the data job market as of 2023. Zeroing in on data analyst and data science roles, this project aimed to find the top-paying jobs along with the most in-demand and optimal skills a data professional should be considering adding to their repretoire.

Interested in my SQL queries? [Click Here!](/project_SQL/SQL/)

Check out my python analysis and visualizations [here!](/project_SQL/Python/)

## Background
This project is important to me as someone who is navigating the job market as a data professional. I wanted to see the breadth of job market and find skills that are in high demand along with companies that are hiring the most. This project also serves as a portfolio project showing off my SQL and python analysis skills.

## Tools/Technology Used
List the tools and technologies you used for this project:
- SQL
- Python (pandas, numpy, matplotlib, seaborn)
- PostgreSQL DBMS

## Analysis
This project was centered around 5 queries that were aimed at learning more about the data job market and the skills required to succeed in said market:

### 1. What are the top Paying Jobs for Data Analysts and Data Scientists
To identify which job postings were the highest paying for each role I queried the job posting table from the database and filtered in such a way that showed the 10 highest paying jobs for both data scientists and data analysts located in New York.

```sql
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
ON job_postings_fact.company_id = company_dim.company_i
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
```
Here's what those 2 queries revealed:

- **High Salary Range for Both Roles:** The top 10 data analyst jobs ranged from $175,000 to $240,000 and the salaries for the top 10 data scientist roles ranged from $250,000 to $585,000. These high salary ranges are not that surprising as some of the names on these tables are tech giants such as TikTok, Snap Inc, Figma and Asana. 

- **Executive/High-Level Roles:** Most of the roles in both tables were either principal level or senior level roles which could explain the very high and wide range of salaries across both tables.

- **Many Sectors Represented:** The top 10 roles for both data analysts and data scientists showed companies from tech, finance, health, and even adTech. 

### 2. What skills are the highest paying for data analysts and data scientists?

I wanted to know which set of skills a data professional in either data analytics or data science should be focusing on if they wish to land one of those high-paying roles.

This is the query I used to find that information for both roles:


```sql
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
```
I was able to use a CTE here to create a temporary table that I could then query down further to reveal the information I was looking for. 

See below for the visualizations I created to represent the results for each role:

### Top 10 Skills for Data Analysts
![Alt Text](/project_SQL/Pictures/top_10_skill_DA_dark.png)

### Top 10 Skills for Data Scientists
![Alt Text](/project_SQL/Pictures/top_10_skill_DS_dark.png)

- **The Main Takeaway**: For both data scientists and data analysts the highest paying skills according to the job postings are python, SQL, and Excel. It is interesting to note that some of the highest-paying skills for data scientists are development languages like C and Go (we will see more of this in questions 3 and 4).

If you wish to see the code I used to create these viusalizations and read more analysis please [click here!](/project_SQL/Python/skill_analysis.ipynb)

## 3. What are the most in-demand skills for both data analysts and data scientists?
To find the most in-demand skills across all job postings for both data scientists we used this query:

``` sql
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
```
This query utilizes a CTE so we can query this sub-table down further and get the results we are looking for. 

## The Most In-Demand Skills for Data Analysts:
| Skill Name | Times Requested |
|------------|-----------------|
| SQL | 1753 |
| Excel | 1327 |
| Python | 1021 |
| Tableau | 997 |
| R | 577

## The Most In-Demand Skills for Data Scientists:
| Skill Name | Times Requested |
|------------|-----------------|
| Python | 1536 |
| SQL | 1177 |
| R | 858 |
| Tableau | 405 |
| AWS | 370 |

- **Python, SQL, and Tableau** As we can see python, SQL, and Tableau are all in high-demand for job postings for both roles. A data professional should most definitely focus on those 3 if they are planning on entering the workforce as a data analyst or a data scientist.

## 4. What are the highest paying skills for all job postings for data analysts and data scientists.

## Highest Paying Data Analyst Skills

As you can see right away from this graph there is a large outlier - the version control system SVN has an average salary of $400,000. If you compare the average between the data analyst skills and the data science skills they are roughy the same with DS leading by 20,000 annually (145,000 vs 167,000). 

I was shocked to see a lot of AI/machine learning tools mentioned in this list like HuggingFace, tensorflow, pytorch, and keras as that is something I would expect a data scientist be required to know and not a data analyst.

Its also interesting that the most common data analysis tools such as SQL, python, or excel are not mentioned in this top 25 which might mean that the highest paying data analyst roles are more specialized than a normal data or business analyst.

### The highest paying skills for Data Analysts
![Alt Text](/project_SQL/Pictures/highest_paying_skills_DA.png)

## Highest Paying Data Science Skills

From this graph we can see that most of these skills aren't programming languages but tools and software that revolve around programming languages like Asana and atlassian for project management; airtable, neo4j, and redhat for data management/databases and so on. The only languages mentioned in the top 25 skills are haskell, lua and objective-c which are all used for development rather than data analysis.

Its also interesting that unity and unreal are mentioned in the top 25 skills as they are both video game engines and not something I would think a data scientist would be required to ever know.

### The highest paying skills for Data Scientists
![Alt Text](/project_SQL/Pictures/highest_paying_skills_DS.png)

## 5. What are the most optimal skills a data professional should be looking into?

I wanted to understand which skills were the most optimal for someone to learn if they wanted to get into data analytics. I define optimal here as a skill that is in high demand as well as a high-paying skill.

To find the query for this question you can [click here!](/project_SQL/SQL/5_optimal_skills.sql) and the results are located [here!](/project_SQL/CSVs/most_optimal_skills.csv)

- **Apache Applications:** The main interesting takeaway from this question was that several Apache data systems appeared on this list (See below). 

| Skill Name | Avg Salary For Skill |
|------------|------------------|
| Apache Cassandra | $118,406.68 |
| Apache Kafka | $129,999.16 |
| Apache Hadoop | $110,888.27 |


# What I Learned
In completing this project I learned which companies are have the highest paying role for data analysts and data scientist located in New York and the skills required to attain said roles, I also learned which skills are in the highest demand for both data scientists and data analysts, and finally I was able to determine which skills were the most optimal for a data analyst looking for work in New York. 

Please look around this repository to learn more about my SQL queries and the python data analysis/visualizations I created.

