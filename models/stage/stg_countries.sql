{{
    config(
        materialized='table',
        tags=['stg'],
        database='dbt_op',
        schema='stg'
    )
}}

select 
COUNTRY_ID,
COUNTRY_NAME,
REGION_ID,
LOAD_TIME
from {{ source('hr','src_countries')}}