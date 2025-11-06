/* COMO ES TRANSFORMACION SENCILLA PODEMOS HACER UNA VISTA */
{{
  config(
    materialized='view',
    alias='shipping_service'
  )
}}

with source_data as (
    select 
        DISTINCT shipping_service as shipping,
        DISTINCT shipping_service as description
    from
    {{ source('stg_server_dbo', 'orders') }}
),

cte as (
    SELECT
        md5(shipping) as shipping,
        description
    FROM source_data
),

no_row as (
    SELECT 
        'not selected' as shipping,
        'not selected' as description
)

SELECT * FROM cte
UNION ALL
SELECT * FROM no_row