select 
    lower(left(c.CountryName, 1)) as 'countryFirstLetter', 
    count(e.EventId) as 'eventsCount', 
    avg(cast(len(e.EventName) as float)) as 'average event name length'
FROM [HistoricalEvents].[dbo].[tblEvent] as e
join [dbo].[tblCountry] as c
    on e.CountryId = c.CountryId
group by lower(left(c.CountryName, 1))

-- checking query
select 
    c.CountryName, 
    count(e.EventId) as 'eventsCount', 
    avg(cast(len(e.EventName) as float)) as 'average event name length'
from tblCountry as c
join tblEvent as e
    on c.CountryId = e.CountryId
where lower(CountryName) like 'u%'
group by CountryName
