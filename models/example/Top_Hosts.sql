select
l.host_id, room_type,host_name, 
count(l.host_id) as n_listings
from listings_airbnb_paris l
join 
hosts_airbnb_paris h on l.host_id = h.host_id
group by l.host_id, room_type,host_name
order by n_listings desc