with source_data as(select
l.host_id,host_name, 
 count(case when lower(room_type) LIKE '%entire%' then room_type end) as entire_apt,
  count(case when lower(room_type) LIKE '%hotel%' then room_type end) as hotel_room,
  count(case when lower(room_type) LIKE '%private%' then room_type end) as shared_room,
  count(case when lower(room_type) LIKE '%shared%' then room_type end) as private_room,
  count(l.host_id) as n_listings
from {{source("airbnb_paris","listings_airbnb_paris")}} l
join 
{{source("airbnb_paris","hosts_airbnb_paris")}} h on l.host_id = h.host_id
group by l.host_id, host_name
order by n_listings desc)

select * from source_data