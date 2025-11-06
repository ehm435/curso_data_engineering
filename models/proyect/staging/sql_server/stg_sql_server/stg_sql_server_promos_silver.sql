/* COMO ES TRANSFORMACION SENCILLA PODEMOS HACER UNA VISTA */
{{
  config(
    materialized='view',
    alias='promos_silver'
  )
}}

with source_data as (
    select 
        *,
        discount as discount_dollar,
        LOWER(TRIM(promo_id, ' ')) as description,
        _fivetran_deleted as deleted,
        CONVERT_TIMEZONE('Europe/Madrid', _fivetran_synced)::TIMESTAMP_NTZ as synced_utc
    from
    {{ source('sql_server_dbo', 'promos') }}
),

cte as (
    SELECT
        md5(description) as promo_id,
        description,
        discount_dollar,
        status,
        deleted,
        synced_utc
    FROM source_data
),

no_promo_row as (
    SELECT 
        md5('no_promo') as promo_id,
        'no_promo' as description,
        0 as discount_dollar,
        'inactive' as status,
        null as deleted,
        CONVERT_TIMEZONE('Europe/Madrid', CURRENT_TIMESTAMP())::TIMESTAMP_NTZ as synced_utc
)

SELECT * FROM cte
UNION ALL
SELECT * FROM no_promo_row
