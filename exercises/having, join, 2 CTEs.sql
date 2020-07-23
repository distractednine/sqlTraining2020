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
with continentsWithMoreThan3Countries as (
    select cont.ContinentId as ContinentId, count(cnt.CountryId) as contriesCount
    from [dbo].[tblContinent] as cont
    join [dbo].tblCountry as cnt
        on cont.ContinentId = cnt.ContinentId
    group by cont.ContinentId
    having count(cnt.CountryId) > 3
),

-- with events count predicate
continentsWithLessThan10Events as (
    select cont.ContinentId as ContinentId, cnt.CountryId as CountryId, count(evt.EventId) as eventsCount
    from [dbo].[tblContinent] as cont
    join [dbo].tblCountry as cnt
        on cont.ContinentId = cnt.ContinentId
    join [dbo].tblEvent as evt
        on cnt.CountryId = evt.CountryId
    group by cont.ContinentId, cnt.CountryId
    having count(evt.EventId) < 10
)

select cc.ContinentId, ce.CountryId, cc.contriesCount, ce.eventsCount
from continentsWithMoreThan3Countries as cc
join continentsWithLessThan10Events as ce
    on cc.ContinentId = ce.ContinentId
order by cc.ContinentId, ce.CountryId


-- checking query
select CountryId, count(EventId) as eventsCount
from [dbo].tblEvent
where CountryId in (4,8,12,2,6,15,16)
group by CountryId