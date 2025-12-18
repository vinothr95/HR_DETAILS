{{
    config(materialized='incremental',
    unique_key= 'employee_id',
    incremental_strategy='delete+insert',
    database='dbt_op',
    schema='fct')
}}

select 
    emp.employee_id,
    dep.department_id,
    loc.LOCATION_ID,
    con.country_id,
    reg.REGION_ID,
    emp.job_id,
    sal.hra,
    sal.ALLOWANCES,
    sal.pf,
    sal.LOAD_TIME
from {{ ref('stg_salary')}} as sal 
left join {{ref('dim_employees')}} as emp 
on sal.employee_id=emp.employee_id
left join {{ref('dim_departments')}} as dep 
on emp.department_id=dep.department_id
left join {{ref('dim_locations')}} as loc 
on dep.LOCATION_ID=loc.LOCATION_ID 
left join {{ref('dim_countries')}} as con 
on loc.country_id=con.country_id
left join {{ref('dim_regions')}} as reg 
on con.REGION_ID=reg.REGION_ID
left join {{ref('dim_jobs')}} as job
on emp.job_id=job.job_id

{% if is_incremental() %}

where sal.LOAD_TIME> ( select coalesce (max(LOAD_TIME),'1900-01-01') from {{ this }} )

{% endif %}
