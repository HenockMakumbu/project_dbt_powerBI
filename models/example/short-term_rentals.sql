with source_data as (
select minimum_nights, num_nights, sum(num_nights) over (partition by group_nights ) as num_group_nights from(
select minimum_nights, 
count(*) as num_nights, 
case 
	when minimum_nights<30 then 'min_nights(<30)'
	else'min_nights(>=30)'
end
as group_nights
from {{source("airbnb_paris","listings_airbnb_paris")}}
group by minimum_nights 
order by minimum_nights

)tab
),

inter_data as (
	select  * from source_data
    cross join
    (select sum(num_nights) as total from source_data)tab1
),

final as (
    select minimum_nights, num_nights, round((num_group_nights/total) * 100,1) as percent_group_nights from inter_data
)

select * from final