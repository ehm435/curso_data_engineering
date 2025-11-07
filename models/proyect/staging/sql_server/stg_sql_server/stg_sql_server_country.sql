{{
  config(
    materialized='view',
    alias='country'
  )
}}

with source_data as (
    select DISTINCT
        md5(country) as country_id,
        country,
        _fivetran_deleted as deleted,
        CONVERT_TIMEZONE('Europe/Madrid', _fivetran_synced)::TIMESTAMP_NTZ as synced_utc
    from
    {{ source('sql_server_dbo', 'addresses') }}
),

cte as (
    SELECT
        country_id,
        country,
        deleted,
        synced_utc
    FROM source_data
)

SELECT * FROM cte