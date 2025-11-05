/* COMO ES TRANSFORMACION SENCILLA PODEMOS HACER UNA VISTA */
{{ config(materialized='view') }}

with cte as (
    select *,
        discount as discount_dollar,
        promo_id as description,
        _fivetran_deleted as deleted,
        _fivetran_synced as last_synced_utc from
    {{ source('sql_server_dbo', 'promos') }}
),

/*
Crear clave surrogada con md5
PROMO_ID: cambiarlo a descripcion y limpiar
Fivetran synced: renombrar e indicar franja horaria
UNION ALL
*/
    SELECT
    md5(description) as promo_id,
    description,
    discount_dollar,
    status,
    deleted,
    last_synced_utc
    FROM cte
    UNION
    SELECT 
        md5('no_promo') as promo_id,
        'no_promo' as description,
        0 as discount_dollar,
        'inactive' as status,
        null as deleted,
        current_timestamp() as _fivetran_synced_UTC
