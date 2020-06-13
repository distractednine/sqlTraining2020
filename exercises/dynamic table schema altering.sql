SELECT TOP (1000) [EventId]
      ,[EventName]
      ,[EventDate]
      ,[Description]
      ,[CountryId]
      ,[CategoryID]
  FROM [HistoricalEvents].[dbo].[tblEvent]
  order by EventDate


-- change table data type
DECLARE @columnDataType varchar(max);
SELECT @columnDataType = DATA_TYPE FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME  = 'tblEvent' AND COLUMN_NAME = 'EventDate'
SELECT @columnDataType

if (@columnDataType = 'datetime')
BEGIN
    ALTER table [HistoricalEvents].[dbo].[tblEvent]
    alter column [EventDate] DATETIME2

    PRINT ('changed column data type')
END


-- insert new row if it didn't exist before

DECLARE @newEventId int = 1000;
DECLARE @eventExists bit;
SELECT @eventExists = COUNT(1) from [HistoricalEvents].[dbo].[tblEvent] where EventId = @newEventId

if (@eventExists = 0)
BEGIN
    SET IDENTITY_INSERT [HistoricalEvents].[dbo].[tblEvent] ON; 

    insert into [HistoricalEvents].[dbo].[tblEvent] (EventId, EventName, EventDate, [Description], CountryId, CategoryID) 
    VALUES (@newEventId, N'Fckn William the Conqueror was born', CAST(N'1087-09-09' AS Date), 'he was born. we cannot change it', 17, null);

    SET IDENTITY_INSERT [HistoricalEvents].[dbo].[tblEvent] OFF; 

    PRINT ('inserted new row')
END
ELSE
BEGIN
    -- delete from [HistoricalEvents].[dbo].[tblEvent] where  EventId = 1000
    PRINT ('no new row inserted')
END
  
