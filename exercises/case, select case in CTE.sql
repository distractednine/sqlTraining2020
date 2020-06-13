SELECT TOP (1000) [EventId]
      ,[EventName]
      ,[EventDate]
      ,[Description]
      ,[CountryId]
      ,[CategoryID]
  FROM [HistoricalEvents].[dbo].[tblEvent]

go;

select * from
    (SELECT era = case
        when year(e.EventDate) < 1900
            then 'before 20th century'
        when year(e.EventDate) > 1900 and year(e.EventDate) < 2000
            then '20th century'
        when year(e.EventDate) >= 2000
            then '21th century'
        end, [EventName], EventDate
    FROM [HistoricalEvents].[dbo].[tblEvent] as e) as a
    where a.era is NULL

go;

with getEventsByEra as (
    SELECT era = case
        when year(e.EventDate) < 1900
            then 'before 20th century'
        when year(e.EventDate) > 1900 and year(e.EventDate) < 2000
            then '20th century'
        when year(e.EventDate) >= 2000
            then '21th century'
        end
    FROM [HistoricalEvents].[dbo].[tblEvent] as e
)

SELECT era, COUNT(1) as eventsCount
from getEventsByEra
group by era
