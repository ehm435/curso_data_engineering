{{
  config(
    materialized='view',
    alias='states'
  )
}}

with source_data as (
    select DISTINCT
        md5(state) as state_id,
        state,
        md5(country) as country_id
    from
    {{ source('sql_server_dbo', 'addresses') }}
),

cte as (
    SELECT
        state_id,
        state,
        country_id
    FROM source_data
)

SELECT * FROM cte