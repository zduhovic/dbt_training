{% macro audit_log(run_activity) %}

{% set audit_table = 'dbt_audit' %}

{% set audit_query %}
{% if this.name %}

insert into {{ audit_table }} 
values ('{{ invocation_id }}', '{{ this.name }}', '{{ run_activity }}', now());

{% else %}

insert into {{ audit_table }} 
values ('{{ invocation_id }}', 'N/A', '{{ run_activity }}', now());

{% endif %}
{% endset %}

{% do run_query(audit_query) %}

{% endmacro %}


{% macro audit_prep() %}

{% set audit_table = 'dbt_audit' %}

{% set audit_prep_query %}

create table if not exists {{ audit_table }} 
(
    run_id String,
    run_object String,
    run_activity String,
    created_at DateTime
)
ENGINE = MergeTree
ORDER BY tuple()
SETTINGS index_granularity = 8192;

{% endset %}

{% do run_query(audit_prep_query) %}

{% endmacro %}