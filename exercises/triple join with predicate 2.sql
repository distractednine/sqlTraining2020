SELECT TOP (1000) evt.[EventId]
      ,evt.[EventName]
      ,evt.[EventDate]
      ,evt.[Description]
      ,evt.[CountryId]
      ,evt.[CategoryID]
      ,cont.ContinentName
      ,cnt.CountryName
  FROM [dbo].[tblEvent] as evt
  join [dbo].[tblCountry] as cnt
    on evt.CountryId = cnt.CountryId
  join [dbo].[tblContinent] as cont
    on cnt.ContinentId = cont.ContinentId
  where 
    cont.ContinentName = 'South America' or
    cnt.CountryName = 'Japan'
