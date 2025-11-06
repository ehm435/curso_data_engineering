/* COMO ES TRANSFORMACION SENCILLA PODEMOS HACER UNA VISTA */
{{
  config(
    materialized='view',
    alias='budget_silver'
  )
}}

with source_data as (
    select 
        *
    from
    {{ source('google_sheets', 'budget') }}
),

cte as (
    SELECT
        
    FROM source_data
)
