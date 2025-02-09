-- 5. What are the most optimal skills to learn (High Demand and high paying)?
-- SELECT skills_dim.skills,
--     COUNT(job_postings_fact.job_id) as job_count,
--     ROUND(AVG(job_postings_fact.salary_year_avg))  as avg_salary
-- FROM job_postings_fact
--     INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
--     INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
-- WHERE job_title_short = 'Data Analyst'
--     AND job_location = 'Anywhere'
--     AND job_postings_fact.salary_year_avg IS NOT NULL
-- GROUP BY skills_dim.skills
-- ORDER BY job_count DESC, avg_salary DESC
-- LIMIT 15;
WITH skills_count AS (
    SELECT skills_dim.skill_id,
        skills_dim.skills,
        COUNT(job_postings_fact.job_id) as job_count
    FROM job_postings_fact
        INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
        INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE job_title_short = 'Data Analyst'
        AND job_location = 'Anywhere'
        AND job_postings_fact.salary_year_avg IS NOT NULL
    GROUP BY skills_dim.skill_id
),
avg_salary AS (
    SELECT skills_dim.skill_id,
        skills_dim.skills,
        ROUND(AVG(job_postings_fact.salary_year_avg)) as avg_salary
    FROM job_postings_fact
        INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
        INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE job_title_short = 'Data Analyst'
        AND job_location = 'Anywhere'
        AND job_postings_fact.salary_year_avg IS NOT NULL
    GROUP BY skills_dim.skill_id
)
SELECT skills_count.skills,
    skills_count.job_count,
    avg_salary.avg_salary
FROM skills_count
    INNER JOIN avg_salary ON skills_count.skill_id = avg_salary.skill_id
WHERE job_count > 10
    AND avg_salary > 100000
ORDER BY avg_salary DESC,
    job_count DESC
LIMIT 25;

-- same as above but in a single query
SELECT skills_dim.skills,
    COUNT(job_postings_fact.job_id) as job_count,
    ROUND(AVG(job_postings_fact.salary_year_avg))  as avg_salary
FROM job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE job_title_short = 'Data Analyst'
    AND job_location = 'Anywhere'
    AND job_postings_fact.salary_year_avg IS NOT NULL
GROUP BY skills_dim.skills
HAVING COUNT(job_postings_fact.job_id) > 10
ORDER BY avg_salary DESC, job_count DESC 
LIMIT 25;