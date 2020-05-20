SELECT TOP (1000) [EventId]
      ,[EventName]
      ,[EventDate]
      ,DATEPART(day, EventDate) as 'day number'
      ,DATENAME(weekday, EventDate) as 'day name'
      ,[Description]
      ,[CountryId]
      ,[CategoryID]
  FROM [HistoricalEvents].[dbo].[tblEvent]
  
  go
  
  SELECT TOP (1000) 
      DATENAME(weekday, EventDate) as 'day name',
       count([EventId]) as 'number of events'
  FROM [HistoricalEvents].[dbo].[tblEvent]
  group by DATENAME(weekday, EventDate) 