{{
    config(materialized= 'incremental',
    unique_key='region_id',
    tags= ['dim']
    )
}}

select 
REGION_ID,
REGION_NAME,
LOAD_TIME
from {{ref ('stg_regions')}}

{% if is_incremental() %}

{{inc()}}

{% endif %}