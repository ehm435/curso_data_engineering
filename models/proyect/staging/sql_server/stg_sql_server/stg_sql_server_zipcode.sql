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
        md5(state) as state_id,
        _fivetran_deleted as deleted,
        CONVERT_TIMEZONE('Europe/Madrid', _fivetran_synced)::TIMESTAMP_NTZ as synced_utc
    from
    {{ source('sql_server_dbo', 'addresses') }}
),

cte as (
    SELECT
        zipcode_id,
        zipcode,
        state_id,
        deleted,
        synced_utc
    FROM source_data
)

SELECT * FROM cte