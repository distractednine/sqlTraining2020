SELECT TOP (1000) [EventId]
      ,[EventName]
      ,[EventDate]
      ,[Description]
      ,[CountryId]
      ,[CategoryID]
  FROM [HistoricalEvents].[dbo].[tblEvent]

go;

IF OBJECT_ID ('[dbo].[getEventsA]') IS NOT NULL  
BEGIN
    DROP function [dbo].[getEventsA];
END

IF OBJECT_ID ('[dbo].[getEventsB]') IS NOT NULL  
BEGIN
    DROP function [dbo].[getEventsB];
END

IF OBJECT_ID ('[dbo].[getEventsC]') IS NOT NULL  
BEGIN
    DROP function [dbo].[getEventsC];
END

go;

create function [dbo].[getEventsA]()
RETURNS TABLE
as
    return
        select EventId, [CountryId]
        from [HistoricalEvents].[dbo].[tblEvent]
        where 
            lower(EventName) not like 'o%' and lower(EventName) not like '%o' and lower(EventName) not like '%o%' and
            lower(EventName) not like 'w%' and lower(EventName) not like '%w' and lower(EventName) not like '%w%' and
            lower(EventName) not like 'l%' and lower(EventName) not like '%l' and lower(EventName) not like '%l%'

go;

create function [dbo].[getEventsB]()
RETURNS TABLE
as
    return
        select e.EventId, e.CountryId, e.CategoryID
        from (
            select distinct CountryId
            from [dbo].[getEventsA]()) as ea
        JOIN [HistoricalEvents].[dbo].[tblEvent] e
            on ea.CountryId = e.CountryId

go;

create function [dbo].[getEventsC]()
RETURNS TABLE
as
    return
        select e.EventId, e.CountryId, e.CategoryID
        from (
            select distinct CategoryID
            from [dbo].[getEventsB]()
            where CategoryID is not null) as eb
        JOIN [HistoricalEvents].[dbo].[tblEvent] e
            on eb.CategoryID = e.CategoryID

go;

print 'A: events without word `owl`'

select EventId, CountryId
from [dbo].[getEventsA]()
order by CountryId

print 'B: events with the same country as events A'

select EventId, CountryId
from [dbo].[getEventsB]()
order by CountryId

print 'C: events with the same category as events B'

select EventId, CountryId, CategoryID
from [dbo].[getEventsC]()
order by CategoryID, CountryId
