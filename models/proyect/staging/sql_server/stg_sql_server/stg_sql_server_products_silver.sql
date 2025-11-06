/*
{{
  config(
    materialized='view',
    alias='products_silver'
  )
}}

with source_data as (
    select 
        *,
        _fivetran_deleted as deleted,
        CONVERT_TIMEZONE('Europe/Madrid', _fivetran_synced)::TIMESTAMP_NTZ as synced_utc
    from
    {{ source('sql_server_dbo', 'products') }}
),

cte as (
    SELECT
        product_id,
        price as price_dollar,
        name,
        inventory,
        deleted,
        synced_utc
    FROM source_data
)


/*
Revisar stock y precios
*/
*/