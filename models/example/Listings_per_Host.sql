with source_data as (
select listings_by_hosts, sum(listings_by_hosts) as n_listings from(
select
host_id,
count(*) as listings_by_hosts
from listings_airbnb_paris
group by host_id)tab
group by listings_by_hosts
order by listings_by_hosts
),

inter_data as (
    select *, 
case 
	when listings_by_hosts<= 1 then 'single_listing'
	else'multi_listings'
end
as group_listings
from  source_data
cross join (select sum(n_listings) as total from source_data)tab1

),

final as (

	select listings_by_hosts, n_listings, group_listings,sum(percent_group_listings) over(partition by group_listings) as percent_group_listings from(

    select listings_by_hosts, n_listings, group_listings, round((n_listings/total) * 100,1) as percent_group_listings from inter_data
)tab
order by percent_group_listings desc
)

select *,
case 
	when listings_by_hosts>=10 then  
	sum(
	case 
		when listings_by_hosts>=10 then n_listings
	end
	
	) 
	
	over() 
	else n_listings
end
as class_hist_10
from final


