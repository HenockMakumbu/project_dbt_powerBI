with source_data as (
select
room_type,
count(*) as n_type
from {{source("airbnb_paris","listings_airbnb_paris")}}
group by room_type
),

inter_data as (
    select * from source_data cross join (select sum(n_type) as total from source_data)tab
),

final as (
    select room_type, n_type, round((n_type/total) * 100,2) as percent_type from inter_data
)

select * from final