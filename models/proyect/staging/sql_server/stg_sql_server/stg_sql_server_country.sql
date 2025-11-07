{{
  config(
    materialized='view',
    alias='country'
  )
}}

with source_data as (
    select DISTINCT
        md5(country) as country_id,
        country
    from
    {{ source('sql_server_dbo', 'addresses') }}
),

cte as (
    SELECT
        country_id,
        country
    FROM source_data
)

SELECT * FROM cte