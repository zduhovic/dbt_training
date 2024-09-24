with

orders as (

    select * from {{ ref('stg_tech_store__orders') }}

),

transactions as (

    select * from {{ ref('stg_payment_app__transactions') }}

),

products as (

    select * from {{ ref('stg_tech_store__products') }}

),

customers as (

    select * from {{ ref('stg_tech_store__customers') }}

),

sale_dates as (

    select * from {{ ref('sale_dates') }}

),

final as (

    select
        orders.order_id order_id,
        transactions.transaction_id transaction_id,
        customers.customer_id as customer_id,
        customers.customer_name customer_name,
        products.product_name product_name,
        products.category category,
        products.price price,
        products.currency currency,
        orders.quantity quantity,
        IF(isNull(sale_dates.SALE_DATE), false, true) AS is_sale_order,
        transactions.cost_per_unit_in_usd cost_per_unit_in_usd,
        transactions.amount_in_usd amount_in_usd,
        transactions.tax_in_usd tax_in_usd,
        transactions.total_charged_in_usd total_charged_in_usd,
        orders.created_at created_at,
        orders.created_at_dt,
        orders.created_at_est

    from orders

    left join transactions
        on orders.order_id = transactions.order_id

    left join products
        on orders.product_id = products.product_id

    left join customers
        on orders.customer_id = customers.customer_id

    left join sale_dates
        on orders.created_at_dt = sale_dates.SALE_DATE

)

select * from final