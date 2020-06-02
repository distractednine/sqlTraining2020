SELECT TOP (1000) [EventId]
      ,[EventName]
      ,[EventDate]
      ,[Description]
      ,[CountryId]
      ,[CategoryID]
  FROM [HistoricalEvents].[dbo].[tblEvent]
  



DECLARE event_cursor CURSOR  
    FOR 
    SELECT [EventName], [EventDate] 
    FROM [HistoricalEvents].[dbo].[tblEvent]

OPEN event_cursor  

DECLARE @count int = 1;
DECLARE @message varchar(max) = '';
DECLARE @eventName varchar(max);
DECLARE @eventDate datetime;

WHILE @count < 999 and @@FETCH_STATUS = 0
BEGIN

    FETCH NEXT FROM event_cursor into @eventName, @eventDate; 

    set @message = 'this event: ' + @eventName + ' at date:' + CAST(@eventDate as varchar(max)) + ' , count:' + CAST(@count as varchar(max))
    PRINT @message;
    set @count = @count + 1
END

CLOSE event_cursor  

