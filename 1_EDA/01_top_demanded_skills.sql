/*
Question:  What are the most in-deman skills for data engineers?
- Join Job postings to inner join table to query 2
- Identify the top 10 in-demand skills for data engineers
- Focus on remote job postings
- Why? Retrives the top 10 kills with the highest demand in the job market,
    providing insights iontp the most valuable skills for data engineers seeking remote work.
*/

select
    sd.skills, 
    count(jpf.*) as demand_count
from job_postings_fact as jpf
inner join skills_job_dim as sjd
on  
    jpf.job_id = sjd.job_id
inner join skills_dim as sd
on  
    sjd.skill_id = sd.skill_id
where 
    jpf.job_title_short = 'Data Engineer'
and
    jpf.job_work_from_home = True
group by
    sd.skills
order by    
    demand_count DESC
limit 10;                         

/*

┌────────────┬──────────────┐
│   skills   │ demand_count │
│  varchar   │    int64     │
├────────────┼──────────────┤
│ sql        │        29221 │
│ python     │        28776 │
│ aws        │        17823 │
│ azure      │        14143 │
│ spark      │        12799 │
│ airflow    │         9996 │
│ snowflake  │         8639 │
│ databricks │         8183 │
│ java       │         7267 │
│ gcp        │         6446 │
└────────────┴──────────────┘
  10 rows         2 columns

*/
