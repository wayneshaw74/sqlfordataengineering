select 
    table_name,
    column_name,
    data_type
from information_schema.columns
where table_name = 'job_postings_fact';


describe 
select  
    job_title_short,
    salary_year_avg
from 
    job_postings_fact;

select cast('123' as integer);

select
    cast(job_id as varchar) || '-' || cast(company_id as varchar), --"more" unique identifer
    cast(job_work_from_home as int) as job_work_from_home, -- from boolean to numeric value
    cast(job_posted_date as date) as job_posted_date, --from timestamp to date only
    cast(salary_year_avg as decimal(10,0)) as salary_year_avg -- from double to no decimal places
from    job_postings_fact
where 
    salary_year_avg is not null
limit 10;

select
    job_id::varchar || '-' || company_id::varchar as unique_id, --"more" unique identifer
    job_work_from_home::int as job_work_from_home, -- from boolean to numeric value
    job_posted_date::date as job_posted_date, --from timestamp to date only
    salary_year_avg::decimal(10,0) as salary_year_avg -- from double to no decimal places
from    job_postings_fact
where 
    salary_year_avg is not null
limit 10;

select (3 + 5.5) ::float;