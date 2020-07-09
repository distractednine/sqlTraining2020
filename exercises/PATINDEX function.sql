declare @eventsCount int;

select @eventsCount = count(*)
    FROM [HistoricalEvents].[dbo].[tblEvent]
    where year(EventDate) >= 1990 and year(EventDate) <= 1999

-- select all eventNames into a single string
DECLARE @eventNames varchar(max) = '';

select @eventNames = 
    e.[EventName] + ', ' + @eventNames
from 
    (select [EventName] 
    FROM [HistoricalEvents].[dbo].[tblEvent]
    where year(EventDate) >= 1990 and year(EventDate) <= 1999) as e

-- show results
select @eventNames as eventNames, @eventsCount as eventsCount;

-- show events that have EventName as a part of @eventNames string
select evnts.* 
from (
    select *, PATINDEX('%'+ [EventName] + '%', @eventNames) as patindex
    from [HistoricalEvents].[dbo].[tblEvent]) as evnts
where evnts.patindex > 0 
order by evnts.patindex