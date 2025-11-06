/* COMO ES TRANSFORMACION SENCILLA PODEMOS HACER UNA VISTA */
{{
  config(
    materialized='view',
    alias='orders_silver'
  )
}}

with source_data as (
    select 
        *
    from
    {{ source('stg_server_dbo', 'orders') }}
),

cte as (
    SELECT
        
    FROM source_data
)
