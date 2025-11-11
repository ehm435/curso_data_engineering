{{
  config(
    materialized='view',
    alias='zipcode'
  )
}}

with source_data as (
    select DISTINCT
        md5(zipcode) as zipcode_id,
        zipcode,
        md5(state) as state_id,
        _fivetran_deleted as deleted,
        {{ to_madrid_ntz('_fivetran_synced') }} AS synced_utc
    from
    {{ source('sql_server_dbo', 'addresses') }}
),

cte as (
    SELECT
        zipcode_id,
        zipcode,
        state_id,
        deleted,
        synced_utc
    FROM source_data
)

SELECT * FROM cte