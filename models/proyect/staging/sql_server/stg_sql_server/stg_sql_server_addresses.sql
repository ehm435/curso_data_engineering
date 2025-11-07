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
        md5(zipcode) as zipcode_id,
        _fivetran_deleted as deleted,
        CONVERT_TIMEZONE('Europe/Madrid', _fivetran_synced)::TIMESTAMP_NTZ as synced_utc
    from
    {{ source('sql_server_dbo', 'addresses') }}
),

cte as (
    SELECT
        address_id,
        address,
        zipcode_id,
        deleted,
        synced_utc
    FROM source_data
)

SELECT * FROM cte