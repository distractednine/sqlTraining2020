with getTopCountries as (
    select top (3) CountryId, count(EventId) as eventsCount
    from [dbo].[tblEvent]
    group by CountryId
    order by eventsCount desc
),

getTopCategories as (
    select top (3) CategoryID, count(EventId) as eventsCount
    from [dbo].[tblEvent]
    group by CategoryID
    order by eventsCount desc
)

-- cross join - countryEvents anbd categoryEvents do not correspond to each other
select c.CountryId, d.CountryName, c.CategoryID, countryEvents, categoryEvents
from (
    select 
        a.CountryId, 
        b.CategoryID, 
        a.eventsCount as 'countryEvents', 
        b.eventsCount as 'categoryEvents'
    from getTopCountries as a
    cross join getTopCategories as b
) as c
join tblCountry as d
on c.CountryId = d.CountryId


-- group by - eventsCount correspond to both CountryId and CategoryID
select CountryId, CategoryID, count(EventId) as 'eventsCount'
from tblEvent as e
where e.CountryId in (
    select CountryId from (select top (3) CountryId, count(EventId) as eventsCount
        from [dbo].[tblEvent]
        group by CountryId
        order by eventsCount desc) as a)
group by CountryId, CategoryID
order by CountryId 

