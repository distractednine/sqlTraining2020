if object_id('[dbo].[up_getEventsForCountry]') is not null
begin
    drop procedure [dbo].[up_getEventsForCountry]
end

go;

create procedure [dbo].[up_getEventsForCountry](@countryName varchar(max), 
    @eventsNumber int output)
as 
begin

    set @eventsNumber = 
        (select count(e.EventId)
        from [HistoricalEvents].[dbo].[tblEvent] as e
        join [HistoricalEvents].[dbo].[tblCountry] as c
            on e.CountryId = c.CountryId
        where c.CountryName = @countryName)

end

go;

declare @events_number int

exec [dbo].[up_getEventsForCountry] 'UK', @events_number output

select @events_number as 'events number'