USE HistoricalEvents;

select * from [dbo].[tblEvent]
where [EventName] like '%Concorde%'
    and [CountryId] = any( select [CountryId] from [HistoricalEvents].[dbo].[tblCountry] where [CountryName] = 'France');
