with source_data as (
select
minimum_nights, avg(price), number_of_reviews
from {{source("airbnb_paris","listings_airbnb_paris")}}
),


final as (
    select * from source_data
)

select * from final