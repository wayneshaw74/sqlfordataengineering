select char_length('SQL');

select lower('sql');

select upper('sql');

select left('sql', 2);

select right('sql', 2);

select substring('sql', 2, 1);

select concat('sql', '-', 'functions');

select 'sql' || '-' || 'functions';

select trim(' sql ');

select replace('SQL', 'Q', '_');

select regexp_replace('data.nerd@gmail.com', '^.*(@)', '\1');

-- Final Example -- Cleanup this using text functions

with title_lower as (
    select  
        job_title,
        lower(trim(job_title)) as job_title_clean
    from job_postings_fact
)

select  
    job_title,
    case
        when job_title_clean like '%Data%'
        and job_title_clean like '%Analyst%' then 'Data Analyst'
        when job_title_clean like '%Data%'
        and job_title_clean like '%Scientist%' then 'Data Scientist'
        when job_title_clean like '%Data%'
        and job_title_clean like '%Engineer%' then 'Data Engineer'
        else 'Other'
    end as job_title_category
from title_lower
order by random()
limit 30;

select nullif(10, 20);

select  
    nullif(salary_year_avg, 0),
    nullif(salary_hour_avg, 0)
from 
    job_postings_fact
where salary_hour_avg is not null or salary_year_avg is not null
limit 10;

select 
    salary_year_avg,
    salary_hour_avg,
    coalesce(salary_year_avg, salary_hour_avg * 2080)
from job_postings_fact
where salary_hour_avg is not null or salary_year_avg is not null
limit 10;

-- Final Example - Simplify with Coalesce


select 
    job_title_short,
    salary_year_avg,
    salary_hour_avg, 
    coalesce(salary_year_avg, salary_hour_avg * 2080) as standardized_salary,
    case    
        when coalesce(salary_year_avg, salary_hour_avg * 2080) is null then 'missing'
        when coalesce(salary_year_avg, salary_hour_avg * 2080) < 75000 then 'low'
        when coalesce(salary_year_avg, salary_hour_avg * 2080) < 150000 then 'mid'
        else 'high'
    end as salary_bucket
from job_postings_fact
order by standardized_salary desc;