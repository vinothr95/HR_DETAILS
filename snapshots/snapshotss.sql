{% snapshot sales %}

{{
    target_schema = 'stg',
    unique_key='EMPLOYEE_ID',
    strategy='check',
    check_cols=['FIRST_NAME','LAST_NAME','JOB_TITLE'],
    invalidate_hard_deletes=true
}}

select * from {{ ref ('stg_salary')}}

{% end snapshot %}