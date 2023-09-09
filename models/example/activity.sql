with source_data as(select availability_365, count(availability_365)  
from {{source("airbnb_paris","listings_airbnb_paris")}}  
group by availability_365
order by availability_365),

final as (
select * from source_data cross join (select  round(avg(price)) as avg_price_by_night 
from {{source("airbnb_paris","listings_airbnb_paris")}} )tab
cross join 
(select round(avg(minimum_nights)) as avg_minimum_nights 
from {{source("airbnb_paris","listings_airbnb_paris")}} )tab1
cross join 
(select round(avg(minimum_nights)*avg(price)) as avg_income 
from {{source("airbnb_paris","listings_airbnb_paris")}} )tab2
)

select * from final