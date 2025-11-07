{{
  config(
    materialized='view',
    alias='status_order'
  )
}}

with source_data as (
    select status
    from
    {{ source('sql_server_dbo', 'orders') }}
),

services as (
    SELECT DISTINCT 
        md5(status) as status_id,
        status
    FROM source_data
)

SELECT * FROM services
