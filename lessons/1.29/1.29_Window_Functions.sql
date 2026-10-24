-- Count Rows - Aggregation Only
select  
    count(*)
from    
    job_postings_fact;


-- Count Rows - Window Function

select  
    job_id,
    count(*) over ()
from    
    job_postings_fact;

-- PARTITION BY - Find hourly salary

select
    job_id,
    job_title_short,
    company_id,
    salary_hour_avg,
    avg(salary_hour_avg) over (
        partition by job_title_short, company_id
    )
from 
    job_postings_fact
where  
    salary_hour_avg is not null
order by 
    random()
limit 10;

--Order by - Rnaking Hourly salary

select
    job_id,
    job_title_short,
    salary_hour_avg,
    rank() over (
        order by salary_hour_avg DESC
    ) as rank_hourly_salary
from 
    job_postings_fact
where  
    salary_hour_avg is not null
order by 
    salary_hour_avg DESC
limit 10;

-- Partition By & Order by - Running Average Hourly Salary

select
    job_posted_date,
    job_title_short,
    salary_hour_avg,
    avg(salary_hour_avg) over (
        partition by job_title_short
        order by job_posted_date
    ) as running_avg_hourly_by_title
from 
    job_postings_fact
where  
    salary_hour_avg is not null and
    job_title_short = 'Data Engineer'
order by 
    job_title_short,
    job_posted_date
limit 10;

-- Partition By and Order By - Ranking by job_title_short

select
    job_id,
    job_title_short,
    salary_hour_avg,
    rank() over (
        partition by job_title_short
        order by salary_hour_avg DESC
    ) as rank_hourly_salary
from 
    job_postings_fact
where  
    salary_hour_avg is not null
order by 
    salary_hour_avg DESC,
    job_title_short
limit 10;

-- Ranking Functions - RANK() vs Dense_Rank

select
    job_id,
    job_title_short,
    salary_hour_avg,
    dense_rank() over (
        order by salary_hour_avg DESC
    ) as rank_hourly_salary
from 
    job_postings_fact
where  
    salary_hour_avg is not null
order by 
    salary_hour_avg DESC
limit 140;

-- Row_Number() - Providing a new job_id

select  
    *,
    row_number() over(
        order by job_posted_date
    )
from 
    job_postings_fact
order by    
    job_posted_date
limit 20;

-- lag() - TIme Based Comparison of Company Yearly Salary

select  
    job_id,
    company_id,
    job_title,
    job_title_short,
    job_posted_date,
    salary_year_avg,
    lead(salary_year_avg) over (
        partition by company_id
        order by job_posted_date
    ) as next_posting_salary,
    salary_year_avg - lead(salary_year_avg) over (
        partition by company_id
        order by job_posted_date
    ) as salary_change
from 
    job_postings_fact
where salary_year_avg is not null
order by company_id, job_posted_date
limit 60;