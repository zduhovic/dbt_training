with

employees as (

    select * from {{ source('tech_store', 'employee') }}

),

final as (

    select
        id as employee_id,
        fname as first_name,
        lname as last_name,
        concat(first_name, ' ', last_name) as full_name,
        hiredate as hired_at,
        ifNull(toString(enddate), '{{ var("default_date") }}') as terminated_at,
        if(terminated_at is null, true, false) as is_active 
    from employees

)

select * from final