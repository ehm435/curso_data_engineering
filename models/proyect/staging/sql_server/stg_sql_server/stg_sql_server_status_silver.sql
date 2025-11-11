{{
  config(
    materialized='view',
    alias='status_order'
  )
}}

with source_data as (
    select status,
    _fivetran_deleted as deleted,
    {{ to_madrid_ntz('_fivetran_synced') }} AS synced_utc
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
