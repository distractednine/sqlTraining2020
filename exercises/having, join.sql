SELECT TOP (1000) [EventId]
      ,[EventName]
      ,[EventDate]
      ,[Description]
      ,[CountryId]
      ,[CategoryID]
  FROM [HistoricalEvents].[dbo].[tblEvent]

-- without countries count predicate
select cont.ContinentId, count(cnt.CountryId) as contriesCount
from [dbo].[tblContinent] as cont
join [dbo].tblCountry as cnt
    on cont.ContinentId = cnt.ContinentId
group by cont.ContinentId
order by cont.ContinentId

-- without events count predicate
select cont.ContinentId, cnt.CountryId, count(evt.EventId) as eventsCount
from [dbo].[tblContinent] as cont
join [dbo].tblCountry as cnt
    on cont.ContinentId = cnt.ContinentId
join [dbo].tblEvent as evt
    on cnt.CountryId = evt.CountryId
group by cont.ContinentId, cnt.CountryId
order by cont.ContinentId

go;

-- with countries count predicate
with a as (
    select cont.ContinentId as ContinentId, count(cnt.CountryId) as contriesCount
    from [dbo].[tblContinent] as cont
    join [dbo].tblCountry as cnt
        on cont.ContinentId = cnt.ContinentId
    group by cont.ContinentId
    having count(cnt.CountryId) > 3
),

-- with events count predicate
b as (
    select cont.ContinentId as ContinentId, cnt.CountryId as CountryId, count(evt.EventId) as eventsCount
    from [dbo].[tblContinent] as cont
    join [dbo].tblCountry as cnt
        on cont.ContinentId = cnt.ContinentId
    join [dbo].tblEvent as evt
        on cnt.CountryId = evt.CountryId
    group by cont.ContinentId, cnt.CountryId
    having count(evt.EventId) < 10
)

select a.ContinentId, b.CountryId, a.contriesCount,  b.eventsCount
from a 
join b 
    on a.ContinentId = b.ContinentId
order by a.ContinentId, b.CountryId


-- 2 do - rename CTEs, write checking query