{% macro utc_to_est(column_name) -%}
toTimeZone({{ column_name }}, 'America/New_York')
{%- endmacro %}