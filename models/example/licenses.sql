with source_data as (
select type_license as license, count(type_license) as n_license from( 
select license, 
case 
	when  lower(license) like '%lease%' or lower(license) like '%exempt%' then 'exempt'
	when  license isnull then 'unlicensed'
	else 'licensed'
end
 as type_license from {{source("airbnb_paris","listings_airbnb_paris")}})tab

group by type_license
),

inter_data as (
	select * from(select * from source_data
	union
    select 'pendidng', (SELECT COUNT(*) FROM listings_airbnb_paris) - (SELECT sum(n_license) FROM source_data))tab
    cross join
    (select sum(n_license) as total from source_data)tab1
),

final as (
    select license, n_license, round((n_license/total) * 100,2) as percent_license from inter_data
)

select * from final