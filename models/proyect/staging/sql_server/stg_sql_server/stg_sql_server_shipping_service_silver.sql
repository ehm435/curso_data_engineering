{{
  config(
    materialized='view',
    alias='shipping_service'
  )
}}

with source_data as (
    select 
        _fivetran_deleted as deleted,
        {{ to_madrid_ntz('_fivetran_synced') }} AS synced_utc,
        CASE 
            WHEN shipping_service IS NULL THEN ''
            WHEN TRIM(shipping_service) = '' THEN ''
            ELSE shipping_service
        END as shipping_service_cleaned,
        shipping_service 
    from
    {{ source('sql_server_dbo', 'orders') }}
),

services as (
    SELECT DISTINCT 
        shipping_service_cleaned as shipping_raw,
        CASE 
            WHEN shipping_service_cleaned = '' THEN 'not_selected'
            ELSE shipping_service_cleaned
        END as shipping_service_display_name,
        deleted, 
        synced_utc
    FROM source_data
),

final_selection as (
    SELECT
        md5(shipping_raw) as shipping_id, 
        shipping_service_display_name as description,
        deleted,
        synced_utc
    FROM services
)

SELECT * FROM final_selection
