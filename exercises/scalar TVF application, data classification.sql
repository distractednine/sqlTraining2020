SELECT TOP (1000) [EventId]
      ,[EventName]
      ,[EventDate]
      ,[Description]
      ,[CountryId]
      ,[CategoryID]
  FROM [HistoricalEvents].[dbo].[tblEvent]

  declare @alphFirst varchar(max), @alphLast varchar(max), @newest varchar(max), @latest varchar(max)

  set @alphFirst = (
      select top (1) [Description] + ' - ' + cast  (EventDate as varchar(max))
      from [HistoricalEvents].[dbo].[tblEvent] 
      order by [Description] asc)

  set @alphLast = (
      select top (1) [Description] + ' - ' + cast  (EventDate as varchar(max))
      from [HistoricalEvents].[dbo].[tblEvent] 
      order by [Description] desc)

  set @newest = (
      select top (1) [Description] + ' - ' + cast  (EventDate as varchar(max))
      from [HistoricalEvents].[dbo].[tblEvent] 
      order by [EventDate] desc)

  set @latest = (
      select top (1) [Description] + ' - ' + cast  (EventDate as varchar(max))
      from [HistoricalEvents].[dbo].[tblEvent] 
      order by [EventDate] asc)

    select @alphFirst as alphFirst, @alphLast as alphLast, @newest as newest, @latest as latest

    go;

IF OBJECT_ID ('[dbo].categorize_event') IS NOT NULL  
BEGIN
    DROP function [dbo].categorize_event;
END

go

create function [dbo].categorize_event(@eventDescription varchar(max))
    returns varchar(100)
as
    BEGIN
        if(@eventDescription = (select top (1) [Description]
            from [HistoricalEvents].[dbo].[tblEvent] 
            order by [Description] asc))
        BEGIN
            RETURN 'alFirst'
        end
        if(@eventDescription = (select top (1) [Description]
            from [HistoricalEvents].[dbo].[tblEvent] 
            order by [Description] desc))
        BEGIN
            RETURN 'alLast'
        end
        if(@eventDescription = (select top (1) [Description]
            from [HistoricalEvents].[dbo].[tblEvent] 
            order by [EventDate] desc))
        BEGIN
            RETURN 'newest'
        end
        if(@eventDescription = (select top (1) [Description]
            from [HistoricalEvents].[dbo].[tblEvent] 
            order by [EventDate] asc))
        BEGIN
            RETURN 'latest'
        end
        return 'not winner'
    END

go

select *
from (
    select 
        [Description] + ' - ' + cast  (EventDate as varchar(max)) as 'event data', 
        [dbo].categorize_event([Description]) as 'categorized event'
    from [HistoricalEvents].[dbo].[tblEvent] ) as a 
order by 'categorized event'