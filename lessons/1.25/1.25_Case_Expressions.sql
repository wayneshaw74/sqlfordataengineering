-- Bucket Salaries
-- <25 = 'Low'
-- 25-50 = 'Medium'
-- < 50 = 'High'

select 
    job_title_short,
    salary_hour_avg,
    CASE
        when salary_hour_avg < 25 then 'Low'
        when salary_hour_avg < 50 then 'Medium'
        else 'High'
    end as salary_category
from job_postings_fact
where salary_hour_avg is not null
limit 10;

--Handling Missing Data (Nulls)
-- Filter Null Salary Values

select 
    job_title_short,
    salary_hour_avg,
    CASE
        when salary_hour_avg is null then 'Missing'
        when salary_hour_avg < 25 then 'Low'
        when salary_hour_avg < 50 then 'Medium'
        else 'High'
    end as salary_category
from job_postings_fact

limit 10;

-- Categorizing Categorical Values
-- Classify the `job_title` column values as:
    -- 'Data Analyst'
    -- 'Data Engineer'
    -- 'Data Scientist'

select  
    job_title,
    CASE    
        when job_title like '%Data%' and job_title like '%Analyst%' THEN 'Data Analyst'
        when job_title like '%Data%' and job_title like '%Engineer%' THEN 'Data Engineer'
        when job_title like '%Data%' and job_title like '%Scientist%' THEN 'Data Scientist'
        else 'Other'
    end as job_title_category,
    job_title_short
from job_postings_fact
order by random()
limit 20;

--Not Thru