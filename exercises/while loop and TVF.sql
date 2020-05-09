SELECT TOP (1000) [EventId]
      ,[EventName]
      ,[EventDate]
      ,[Description]
      ,[CountryId]
  FROM [HistoricalEvents].[dbo].[tblEvent]

go

IF OBJECT_ID ('dbo.getTopEventsByYear', 'U') IS NOT NULL  
BEGIN
    DROP FUNCTION dbo.getTopEventsByYear;  
END

go

create function getTopEventsByYear(
    @year int
)
returns table
    as return
        with topEventsByYear as (
            select top 1 
                @year as year, 
                ev.eventsCount as eventsCount, 
                con.CountryName as country 
            from 
                ((SELECT [CountryId] as cid, count([EventId]) as eventsCount
                FROM [HistoricalEvents].[dbo].[tblEvent]
                where year([EventDate]) = @year
                group by [CountryId]) as ev
                    join [HistoricalEvents].[dbo].[tblCountry] as con 
                    on ev.cid = con.CountryId)
            order by ev.eventsCount desc)

            SELECT * from topEventsByYear
go

IF OBJECT_ID ('#events_top_by_year', 'U') IS NOT NULL  
BEGIN
    DROP TABLE #events_top_by_year;  
END

create table #events_top_by_year(
    year int,
    eventsCount int,
    country varchar(max)
)

go

declare @maxYear int;
declare @currentYear int;
SELECT @currentYear = min(year([EventDate])) FROM [HistoricalEvents].[dbo].[tblEvent]
SELECT @maxYear = max(year([EventDate])) FROM [HistoricalEvents].[dbo].[tblEvent]

  WHILE @currentYear <= @maxYear  
  BEGIN  
    insert into #events_top_by_year 
    select year, eventsCount, country  
    from getTopEventsByYear (@currentYear)

    set @currentYear = @currentYear + 1
  END
go

select * from #events_top_by_year
