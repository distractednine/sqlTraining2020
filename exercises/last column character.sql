SELECT TOP (1000) [CountryId]
      ,[CountryName]
      ,[ContinentId]
  FROM [HistoricalEvents].[dbo].[tblCountry]

select CountryId, CountryName
into #oddCountriesTempTable
from [dbo].[tblCountry]
where CountryId % 2 = 1

--drop table #oddCountriesTempTable


select 
    oc.CountryId, 
    e.EventName, 
    right(e.EventName, 1) as 'last event name char', 
    oc.CountryName, 
    right(oc.CountryName, 1) as 'last country name char'
from #oddCountriesTempTable as oc
join tblEvent as e
    on oc.CountryId = e.CountryId
where e.EventName not like '%' + oc.CountryName + '%'
and right(e.EventName, 1) = right(oc.CountryName, 1) -- last chars in e.EventName must be equal