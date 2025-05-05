with classify_pref AS(
    select customer_id,           
           delivery_id,
           order_date,
           case when customer_pref_delivery_date =  order_date then 'immediate'
                else 'scheduled' 
                end as order_statue,
            dense_rank() over(partition by customer_id order by order_date asc ) as customer_order   
    from delivery        
),
orders as (
    select order_statue
    from classify_pref
    where customer_order =1 and order_statue='immediate'
)
select round((select count(*) from orders )*100.0/count(distinct(customer_id))*1.0,2) as immediate_percentage
from delivery;
