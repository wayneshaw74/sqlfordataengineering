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
-- conditional Aggregation
--  Calculate Median Salaries for Different Buckets
    -- < $100k
    -- >=$100k

select 
    job_title_short,
    count(*) as total_postingd,
    Median(
        case 
            when salary_year_avg < 100_000 then salary_year_avg
        end
    ) as median_low_salary,
    Median(
        case 
            when salary_year_avg >= 100_000 then salary_year_avg
        end
    ) as median_high_salary
from job_postings_fact
where salary_year_avg is not null
group by    
    job_title_short;

-- Final Example: Conditional Calculations
-- Compute a standardized_salary using yearly salary and adjusted hourly salary (e.g. 2000 hours/year)
-- Categorize salaries into tiers of:
    -- < 75k 'Low'
    -- 75k - 150k 'Medium'
    -- >= 150k 'High

with salaries as (
    select  
        job_title_short,
        salary_hour_avg,
        salary_year_avg,
        case
            when salary_year_avg is not null then salary_year_avg
            when salary_hour_avg is not null then salary_hour_avg*2080
        end as standardized_salary
    from 
        job_postings_fact
)

select
    *,
    case
        when standardized_salary is null then 'Missing'
        when standardized_salary < 75000 then 'low'
        when standardized_salary < 150000 then 'medium'
        else 'high'
    end as salary_bucket
from salaries
order by
    standardized_salary desc
limit 10;