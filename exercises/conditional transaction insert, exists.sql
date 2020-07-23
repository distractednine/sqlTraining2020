-- for test
--delete from tblEvent where EventName = 'rayana was born'

begin TRANSACTION

-- set IDENTITY_INSERT tblCountry on;

declare @myEventName varchar(max) = 'rayana was born';
declare @myCountryName varchar(max) = 'Ukraine';
declare @myContinent varchar(max) = 'Europe';

if not exists (
    SELECT CountryId 
    FROM [HistoricalEvents].[dbo].[tblCountry]
    WHERE CountryName = @myCountryName)
begin
    insert into tblCountry (CountryId, CountryName, ContinentId)
    values (
        (select max(CountryId) + 1 from tblCountry), 
        @myCountryName, 
        (select ContinentId from tblContinent where ContinentName = @myContinent))
end

if not exists (
    SELECT EventId 
    FROM [HistoricalEvents].[dbo].[tblEvent]
    WHERE [EventName] = 'rayana was born')
begin
    insert into tblEvent (EventName, EventDate, [Description], CountryId)
    values (
        @myEventName,
        cast('1992-09-01' as date),
        'he was born. world is agreed', 
        (select CountryId from tblCountry where CountryName = @myCountryName))

    commit TRANSACTION
    PRINT 'inserted entry in db'
end
ELSE
BEGIN
    ROLLBACK TRANSACTION
    PRINT 'such entry is already in db. transaction rollback'
end



