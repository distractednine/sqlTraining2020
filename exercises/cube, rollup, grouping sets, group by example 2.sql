SELECT TOP (1000) [EventId]
      ,[EventName]
      ,[EventDate]
      ,[Description]
      ,[CountryId]
      ,[CategoryID]
  FROM [HistoricalEvents].[dbo].[tblEvent]

go;

-- TVF
create function getGroupedEvents()
returns table
AS
    return 
        SELECT 
            DATEPART(year, EventDate) as eventYear,
            DATEPART(month, EventDate) as eventMonth
        from 
            [HistoricalEvents].[dbo].[tblEvent]
        where DATEPART(year, EventDate) > 2000

go;

-- CTS
with getGroupedEvents1 as 
    (SELECT 
        DATEPART(year, EventDate) as eventYear,
        DATEPART(month, EventDate) as eventMonth
    from 
        [HistoricalEvents].[dbo].[tblEvent]
    where DATEPART(year, EventDate) > 2000)


-- group by 
select e1.eventYear, e1.eventMonth, count(*) as eventsCount
from
    getGroupedEvents() as e1
group by e1.eventYear, e1.eventMonth 
order by e1.eventYear

-- group by cube
select e1.eventYear, e1.eventMonth, count(*) as eventsCount
from
    getGroupedEvents() as e1
group by cube(e1.eventYear, e1.eventMonth)
order by e1.eventYear

-- group by grouping sets
select e1.eventYear, e1.eventMonth, count(*) as eventsCount
from
    getGroupedEvents() as e1
group by grouping sets(e1.eventYear, e1.eventMonth), (e1.eventYear)
order by e1.eventYear

-- group by rollup
select e1.eventYear, e1.eventMonth, count(*) as eventsCount
from
    getGroupedEvents() as e1
group by rollup(e1.eventYear, e1.eventMonth)
order by e1.eventYear
