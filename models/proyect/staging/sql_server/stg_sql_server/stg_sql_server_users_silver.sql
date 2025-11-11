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
        {{ to_madrid_ntz('created_at') }} AS created_at_utc,
        {{ to_madrid_ntz('updated_at') }} AS updated_at_utc,
        address_id,
        _fivetran_deleted as deleted,
        {{ to_madrid_ntz('_fivetran_synced') }} AS synced_utc
    FROM source_data
)

SELECT * FROM cte