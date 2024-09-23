with

transactions as (

    select * from {{ source('payment_app', 'transactions') }}

),

final as (

    select
        id as transaction_id,
        payload,
        JSONExtractString(payload, 'cost_per')::numeric(18,2) as cost_per_unit_in_usd,
        JSONExtractString(payload, 'order_id')::integer as order_id,
        JSONExtractString(payload, 'product_id')::integer as product_id,
        JSONExtractString(payload, 'quantity')::integer as quantity, 
        JSONExtractString(payload, 'tax')::numeric(18,2) as tax_in_usd,
        JSONExtractString(payload, 'total_charged')::numeric(18,2) as total_charged_in_usd,
        JSONExtractString(payload, 'amount')::numeric(18,2) as amount_in_usd,
        date as created_at

    from transactions

)

select * from final