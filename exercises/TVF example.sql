SELECT TOP (1000) [EventId]
      ,[EventName]
      ,[EventDate]
      ,[Description]
      ,[CountryId]
  FROM [HistoricalEvents].[dbo].[tblEvent]
Go

create function listEventsForYearAndCountry(
      @year int,
      @country varchar
  )
    returns table
        as
    return 
        select [EventId], [EventName],[EventDate],[Description],[CountryId] 
        from  [HistoricalEvents].[dbo].[tblEvent]
        where year([EventDate]) = @year
        and [CountryId] = any( select [CountryId] from [HistoricalEvents].[dbo].[tblCountry] where [CountryName] like '%' + @country + '%');
    Go

select * from listEventsForYearAndCountry (1950, 'UK')


drop function listEventsForYearAndCountry








-----------




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

SELECT * from getTopEventsByYear (1995)