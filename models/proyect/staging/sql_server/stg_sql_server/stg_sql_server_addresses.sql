{{
  config(
    materialized='view',
    alias='addresses'
  )
}}

with source_data as (
    select 
        address_id,
        address,
        md5(zipcode) as zipcode_id
    from
    {{ source('sql_server_dbo', 'addresses') }}
),

cte as (
    SELECT
        address_id,
        address,
        zipcode_id
    FROM source_data
)

SELECT * FROM cte