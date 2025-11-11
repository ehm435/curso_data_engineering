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
        md5(country) as country_id,
        _fivetran_deleted as deleted,
        {{ to_madrid_ntz('_fivetran_synced') }} AS synced_utc
    from
    {{ source('sql_server_dbo', 'addresses') }}
),

cte as (
    SELECT
        state_id,
        state,
        country_id,
        deleted,
        synced_utc
    FROM source_data
)

SELECT * FROM cte