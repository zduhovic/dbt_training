{% macro clickhouse_date_spine(datepart, start_date, end_date) -%}

WITH numbers AS (
    SELECT number
    FROM system.numbers
)
SELECT
    toDate(parseDateTimeBestEffort({{ start_date }})) + number AS date
FROM numbers
WHERE
    toDate(parseDateTimeBestEffort({{ start_date }})) + number <= toDate(parseDateTimeBestEffort({{ end_date }}))
LIMIT 366

{% endmacro %}
