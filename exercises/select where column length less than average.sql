
  declare @averageLen int;

  SELECT @averageLen =  
    avg(len([EventName])) 
    from [HistoricalEvents].[dbo].[tblEvent]

  SELECT [EventName], LEN([EventName]) as lgth
  from [HistoricalEvents].[dbo].[tblEvent]
  where LEN([EventName]) < @averageLen
  ORDER by lgth desc

