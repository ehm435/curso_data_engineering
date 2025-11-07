{{
  config(
    materialized='view',
    alias='status_order'
  )
}}

with source_data as (
    select status,
    _fivetran_deleted as deleted,
    CONVERT_TIMEZONE('Europe/Madrid', _fivetran_synced)::TIMESTAMP_NTZ as synced_utc
    from
    {{ source('sql_server_dbo', 'orders') }}
),

services as (
    SELECT DISTINCT 
        md5(status) as status_id,
        status,
        deleted,
        synced_utc
    FROM source_data
)

SELECT * FROM services
