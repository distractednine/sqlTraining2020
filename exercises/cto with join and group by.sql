SELECT TOP (1000) [CountryId]
      ,[CountryName]
      ,[ContinentId]
  FROM [HistoricalEvents].[dbo].[tblCountry]

go

with getEventsByContinents as (
    SELECT 
        cont.ContinentName as continentName,
        count(ev.EventId) as eventsCount
    from [dbo].[tblContinent] as cont
    join [dbo].[tblCountry] as countr 
        on cont.ContinentId = countr.ContinentId
    join [dbo].[tblEvent] as ev
        on countr.CountryId = ev.CountryId
    group by cont.ContinentName
)

SELECT top(3) * from getEventsByContinents
order by eventsCount asc

go

with getEventCountsByContinenets as (
    SELECT 
        cont.ContinentName as continentName,
        countr.CountryName as countryName,
        (select count(*) 
        FROM [dbo].[tblEvent] as e 
        where e.CountryId = countr.CountryId) as eventsCount
    from [dbo].[tblContinent] as cont
    join [dbo].[tblCountry] as countr 
        on cont.ContinentId = countr.ContinentId
)

select continentName, countryName, eventsCount
from getEventCountsByContinenets
where lower(continentName) <> 'europe' and eventsCount > 5
order by continentName

go