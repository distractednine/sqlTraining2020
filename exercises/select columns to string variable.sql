

DECLARE @eventNames varchar(max) = '';

select @eventNames = 
    e.[EventName] + ', ' + @eventNames
from 
    (select top (3) [EventName] 
    FROM [HistoricalEvents].[dbo].[tblEvent]
    where year(EventDate) = 1992
    order by EventDate desc) as e

select @eventNames as names