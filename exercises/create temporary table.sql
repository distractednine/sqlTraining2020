SELECT TOP (1000) [EventId]
      ,[EventName]
      ,[EventDate]
      ,[Description]
      ,[CountryId]
  FROM [HistoricalEvents].[dbo].[tblEvent]

GO


 SELECT 
    EventName AS NewColumnAlias1, EventDate AS NewColumnAliasN 
 INTO #my_temp_table
 FROM [HistoricalEvents].[dbo].[tblEvent]

 SELECT * from #my_temp_table 
 
 
 
 -- or
     create table #events_top_by_year(
        year int,
        eventsCount int,
        country varchar(max)
    )