SELECT TOP (1000) [EventId]
      ,[EventName]
      ,[EventDate]
      ,[Description]
      ,[CountryId]
      ,[CategoryID]
  FROM [HistoricalEvents].[dbo].[tblEvent]
  where SUBSTRING(EventName, 1, 1) = '£'



  drop table #EventsByLetter
    
  select letters.firstLetter, letters.numberOfEntries 
  INTO #EventsByLetter 
  FROM 
  (SELECT 
    SUBSTRING(e.EventName, 1, 1) as firstLetter,
    COUNT(*) as numberOfEntries
  from [HistoricalEvents].[dbo].[tblEvent] as e
  group by SUBSTRING(e.EventName, 1, 1) 
  ) as letters

  select * from #EventsByLetter 

  -- cannot insert as initially table #EventsByLetter has varchar(1) type for firstLetter column
  insert into #EventsByLetter (firstLetter, numberOfEntries) values ('xz', 17)

  alter table #EventsByLetter
  alter column firstLetter varchar(2)

insert into #EventsByLetter (firstLetter, numberOfEntries) values ('xz', 17)

  select * from #EventsByLetter 
