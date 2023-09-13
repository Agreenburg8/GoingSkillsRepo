-- Calculate the average daily spend per customer
with 
    CustomerLifetime as (
        select customer_id,
            datediff(day, signup_date, current_date()) as customer_lifetime
        from customers
),

    TotalSpend as (
        select customer_id,
            sum(amount) as total_spend
        from invoices
        group by customer_id
)

    Final as (
        select c.customer_id,
            t.total_spend / cl.customer_lifetime as average_daily_spend
        from CustomerLifetime cl
        inner join TotalSpend t on cl.customer_id = t.customer_id
    )

select * from Final;