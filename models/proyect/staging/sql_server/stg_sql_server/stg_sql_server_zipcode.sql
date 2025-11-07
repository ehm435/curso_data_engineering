{{
  config(
    materialized='view',
    alias='zipcode'
  )
}}

with source_data as (
    select DISTINCT
        md5(zipcode) as zipcode_id,
        zipcode,
        md5(state) as state_id
    from
    {{ source('sql_server_dbo', 'addresses') }}
),

cte as (
    SELECT
        zipcode_id,
        zipcode,
        state_id
    FROM source_data
)

SELECT * FROM cte