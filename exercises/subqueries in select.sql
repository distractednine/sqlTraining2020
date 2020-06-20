SELECT TOP (1000) [EventId]
      ,[EventName]
      ,[EventDate]
      ,[Description]
      ,[CountryId]
      ,[CategoryID]
  FROM [HistoricalEvents].[dbo].[tblEvent]


  SELECT 
    e.CountryId,  
    concat (
        e.EventName, 
        ' - ', 
        (select c.CountryName 
        from tblCountry as c 
        where c.CountryId = e.CountryId),
        ', ',
        (select cont.ContinentName 
        from tblContinent as cont 
        where cont.ContinentId = any(
            select countr.ContinentId 
            from tblCountry as countr
            where countr.CountryId = e.CountryId))
        ) as 'extended title'
  FROM [HistoricalEvents].[dbo].[tblEvent] as e