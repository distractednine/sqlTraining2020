SELECT TOP (1000) [EventId]
      ,[EventName]
      ,[EventDate]
      ,[Description]
      ,[CountryId]
      ,[CategoryID]
  FROM [HistoricalEvents].[dbo].[tblEvent]

GO

if (OBJECT_ID('uk_events_delete') is not null)
BEGIN
    drop trigger uk_events_delete
END

go

create table #deletedEventsUk (eventId int);
create table #deletedEventsOther (eventId int);

go;

CREATE TRIGGER uk_events_delete
ON [HistoricalEvents].[dbo].[tblEvent]
INSTEAD OF DELETE
AS
BEGIN
    delete from [HistoricalEvents].[dbo].[tblEvent] 
    where EventId = any(
        SELECT d.EventId 
        FROM deleted as d
        where d.[Description] = 'test')

    declare @ukId int;
    select @ukId = CountryId 
        from tblCountry 
        where CountryName like '%UK%'

    insert into #deletedEventsUk (eventId)
    SELECT d.EventId 
    FROM deleted as d
    where d.CountryId = @ukId and d.[Description] <> 'test'

    insert into #deletedEventsOther (eventId)
    SELECT d.EventId 
    FROM deleted as d
    where d.CountryId <> @ukId and d.[Description] <> 'test'
END

go;


insert into [HistoricalEvents].[dbo].[tblEvent] 
    ([EventName],[EventDate],[Description])
values ('e11', GETDATE(), 'test')

select top (1) * 
from [HistoricalEvents].[dbo].[tblEvent]
where CountryId = any(
        select CountryId 
        from tblCountry 
        where CountryName like '%UK%' and [Description] <> 'test')

select top (1) * 
from [HistoricalEvents].[dbo].[tblEvent]
where CountryId = any(
        select CountryId 
        from tblCountry 
        where CountryName <> 'UK' and [Description] <> 'test')

select top (10) * 
from [HistoricalEvents].[dbo].[tblEvent]
where [Description] = 'test'


-- try deleting from events table
delete from [HistoricalEvents].[dbo].[tblEvent] where EventId = 1 -- uk
delete from [HistoricalEvents].[dbo].[tblEvent] where EventId = 3 -- not uk
delete from [HistoricalEvents].[dbo].[tblEvent] where [Description] = 'test' -- test - should be deleted

-- check that ids of deleted items are present in temp tables
select * from #deletedEventsUk
select * from #deletedEventsOther


select * from [HistoricalEvents].[dbo].[tblEvent] where EventId = 1 -- uk
select * from [HistoricalEvents].[dbo].[tblEvent] where EventId = 3 -- not uk
select top (10) * from [HistoricalEvents].[dbo].[tblEvent] where [Description] = 'test' -- test - should be deleted