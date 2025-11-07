{{
  config(
    materialized='view',
    alias='products_silver'
  )
}}

with source_data as (
    select 
        product_id,
        name,
        _fivetran_deleted as deleted,
        CONVERT_TIMEZONE('Europe/Madrid', _fivetran_synced)::TIMESTAMP_NTZ as synced_utc
    from
    {{ source('sql_server_dbo', 'products') }}
),

cte as (
    SELECT
        product_id,
        name,
        deleted,
        synced_utc
    FROM source_data
)

SELECT * FROM cte