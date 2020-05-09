declare @myBirthday varchar(max);
set @myBirthday = '09/01/1992';


SELECT TOP (1000) e.[EventId]
      ,e.[EventName]
      ,e.[EventDate]
      ,e.[Description]
      ,c.CountryName
      ,abs(datediff(month, @myBirthday, [EventDate])) as 'DATEDIFF in months'
  FROM 
    [HistoricalEvents].[dbo].[tblEvent] as e
    join 
    [HistoricalEvents].[dbo].[tblCountry] as c 
    on e.[CountryId] = c.[CountryId]
  where 
    datediff(month, @myBirthday, [EventDate]) < 5 
    and
    datediff(month, @myBirthday, [EventDate]) > -5
  order by 3 desc