SELECT TOP (1000) [CountryId]
      ,[CountryName]
      ,[ContinentId]
  FROM [HistoricalEvents].[dbo].[tblCountry]


  DECLARE @TableVariableName TABLE(
    Column1 varchar(max),
    ColumnN varchar(max)
    )

    insert into @TableVariableName (Column1, ColumnN)
    SELECT 
        CountryName, 
        (select ContinentName from tblContinent as cont where cont.ContinentId  = cnt.ContinentId)
        from [HistoricalEvents].[dbo].[tblCountry] as cnt

select * from @TableVariableName