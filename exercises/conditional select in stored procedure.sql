IF OBJECT_ID ('[dbo].[getEventData]') IS NOT NULL  
BEGIN
    DROP procedure [dbo].[getEventData];
END

go;

create procedure [dbo].[getEventData](@dataType varchar(max))
AS
BEGIN
    if (@dataType = 'event')
        BEGIN
            select top (10) * from [HistoricalEvents].[dbo].tblEvent
            return
        END
    if (@dataType = 'continent')
        BEGIN
            select top (10) * from [HistoricalEvents].[dbo].tblContinent
            return
        END
    if (@dataType = 'country')
        BEGIN
            select top (10) * from [HistoricalEvents].[dbo].tblCountry
            return
        END
    ELSE
        BEGIN;
            THROW 50000, 'invalid data passed', 1;
        END
END

go;

EXEC [dbo].[getEventData] 'event'
EXEC [dbo].[getEventData] 'continent'
EXEC [dbo].[getEventData] 'country'
EXEC [dbo].[getEventData] '6'