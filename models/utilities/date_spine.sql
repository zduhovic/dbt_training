WITH date_spine AS (
    {{ clickhouse_date_spine('day', "'2020-01-01'", "'2020-12-31'") }}
)
SELECT * FROM date_spine