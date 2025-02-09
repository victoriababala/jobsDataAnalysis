-- 4. What are the top skills based on salary for this role?

SELECT skills_dim.skills,
   ROUND(AVG(job_postings_fact.salary_year_avg))  as avg_salary
FROM job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE job_title_short = 'Data Analyst'
    AND job_location = 'Anywhere'
    AND job_postings_fact.salary_year_avg IS NOT NULL
GROUP BY skills_dim.skills
ORDER BY avg_salary DESC
LIMIT 25;


-- Trends in Top-Paying Data Analyst Jobs (2023)
-- Big Data & Cloud Computing Dominate High Salaries

-- PySpark ($208,172) and Databricks ($141,907) indicate that expertise in big data processing frameworks is highly valued.
-- GCP ($122,500) and Kubernetes ($132,500) suggest cloud computing skills are in demand for managing scalable data infrastructures.
-- Version Control & DevOps Are Gaining Importance

-- Bitbucket ($189,155), GitLab ($154,500), and Jenkins ($125,436) show that experience with DevOps and CI/CD pipelines can significantly boost salaries.
-- AI & ML Tools Are High-Paying

-- DataRobot ($155,486) and Scikit-learn ($125,781) confirm that experience with AI/ML automation tools can lead to lucrative job offers.
-- Jupyter ($152,777) highlights the demand for interactive computing environments used in data science.
-- Programming & Data Manipulation Skills Pay Well

-- Pandas ($151,821), NumPy ($143,513), and Scala ($124,903) indicate that deep expertise in data manipulation and statistical computing is valuable.
-- Specialized Databases & Search Technologies Add Value

-- Couchbase ($160,515), Elasticsearch ($145,000), and PostgreSQL ($123,879) suggest that companies pay well for knowledge of high-performance databases and search engines.
-- Collaboration & Workflow Tools Are Relevant

-- Atlassian ($131,162), Twilio ($127,000), and Notion ($125,000) indicate that companies appreciate familiarity with project management and communication tools.