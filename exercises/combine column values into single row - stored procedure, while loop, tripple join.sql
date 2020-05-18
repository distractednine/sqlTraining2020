SELECT TOP (1000) [EventId]
      ,[EventName]
      ,[EventDate]
      ,[Description]
      ,[CountryId]
      ,[CategoryID]
  FROM [HistoricalEvents].[dbo].[tblEvent]

go;

if object_id ('dbo.uf_eventCountsByContinents') is not null
BEGIN
    drop FUNCTION [dbo].[uf_eventCountsByContinents]
END

go;

if object_id ('dbo.up_showCountriesString') is not null
BEGIN
    drop procedure [dbo].[up_showCountriesString]
END

go;

create function [dbo].[uf_eventCountsByContinents](@targetEventsCount int)
    RETURNS table as
    return
        select coalesce(cont.ContinentName, 'Not applicable') as ContinentName, ebc.eventsCount from 
            (select count(e.EventId) as eventsCount, c.ContinentId
                from [HistoricalEvents].[dbo].[tblEvent] as e 
                    inner join [HistoricalEvents].[dbo].[tblCountry] as c
                    on e.CountryId = c.CountryId
            group by c.ContinentId
            having count(e.EventId) > @targetEventsCount
            ) as ebc 
            left join [HistoricalEvents].[dbo].[tblContinent] as cont
            on ebc.ContinentId = cont.ContinentId
go;

create procedure [dbo].[up_showCountriesString]
    AS
    BEGIN
        declare @targetEventsCount int = 50;
        declare @eventCountsByContinentsResults table (continentName varchar(max), eventsCount int)

        insert into @eventCountsByContinentsResults
        SELECT ContinentName as continentName, eventsCount 
        from [dbo].[uf_eventCountsByContinents](@targetEventsCount) 

        declare @entriesCount int;
        declare @entryIndex int = 1;
        declare @concatenatedOutput varchar(max) = '';
        declare @temp varchar(max);

        select @entriesCount = count(*) from @eventCountsByContinentsResults

        while @entryIndex <= @entriesCount
            BEGIN
                SELECT @temp = a.ContinentName from
                    (select ROW_NUMBER() over (order by eventsCount) as rowNum, continentName         
                    from @eventCountsByContinentsResults)
                    as a
                    where a.rowNum = @entryIndex

                print @temp

                set @concatenatedOutput = @concatenatedOutput + ' ' + @temp
                set @entryIndex = @entryIndex + 1
            END

        select @concatenatedOutput as 'Concatenated Output'
    END

go;

EXEC [dbo].[up_showCountriesString];

go;
