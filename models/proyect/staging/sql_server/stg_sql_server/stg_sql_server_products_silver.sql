{{
  config(
    materialized='view',
    alias='products'
  )
}}

with source_data as (
    select 
        product_id,
        name,
        _fivetran_deleted as deleted,
        {{ to_madrid_ntz('_fivetran_synced') }} AS synced_utc
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