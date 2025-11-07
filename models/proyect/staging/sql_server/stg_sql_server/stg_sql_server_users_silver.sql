{{
  config(
    materialized='view',
    alias='users'
  )
}}

with source_data as (
    select 
        *
    from
    {{ source('sql_server_dbo', 'users') }}
),

cte as (
    SELECT
        user_id,
        first_name,
        last_name,
        email,
        phone_number,
        CONVERT_TIMEZONE('Europe/Madrid', created_at)::TIMESTAMP_NTZ as created_at_utc,
        CONVERT_TIMEZONE('Europe/Madrid', updated_at)::TIMESTAMP_NTZ as updated_at_utc,
        address_id,
        _fivetran_deleted as deleted,
        CONVERT_TIMEZONE('Europe/Madrid', _fivetran_synced)::TIMESTAMP_NTZ as synced_utc
    FROM source_data
)

SELECT * FROM cte