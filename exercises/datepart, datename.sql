SELECT TOP (1000) [EventId]
      ,[EventName]
      ,[EventDate]
      ,[Description]
      ,[CountryId]
      ,[CategoryID],
      DATEPART(DAY, EventDate) as DATEPART,
      DATENAME(WEEKDAY, EventDate) as DATENAME
  FROM [HistoricalEvents].[dbo].[tblEvent]
  where 
    DATEPART(DAY, EventDate) = 13
    and DATENAME(WEEKDAY, EventDate) = 'Saturday'