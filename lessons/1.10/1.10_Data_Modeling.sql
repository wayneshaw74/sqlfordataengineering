select
    job_id,
    job_title_short,
    salary_year_avg,
    company_id
from 
    job_postings_fact
limit 10;

select
    *
from
    company_dim
where
    name in ('Facebook', 'Meta')
limit 10;

select
    *
from information_schema.key_column_usage
where table_catalog = 'data_jobs';

--Specific to DUCKDB (OR SQLLITE FOR PRAGMA)

pragma show_tables;

describe job_postings_fact;