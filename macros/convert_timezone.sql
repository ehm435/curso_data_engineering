{% macro to_madrid_ntz(column_name) %}
    CONVERT_TIMEZONE('Europe/Madrid', {{ column_name }})::TIMESTAMP_NTZ
{% endmacro %}