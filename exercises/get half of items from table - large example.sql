declare @itemsCount int;
select @itemsCount = count (*) from [HistoricalEvents].[dbo].[tblCountry];
set @itemsCount = abs(@itemsCount / 2);
-- Print  (@itemsCount);

select * from 
(SELECT TOP (1000) [CountryId]
      ,[CountryName]
      ,[ContinentId]
      ,ROW_NUMBER() over (ORDER BY [CountryName] ASC) as rowNumber
  FROM [HistoricalEvents].[dbo].[tblCountry]) as c
  where c.rowNumber > @itemsCount;

  Go;


with ItemsCountCte as (
    select count([CountryId]) as count 
    from [HistoricalEvents].[dbo].[tblCountry])

select abs(count/2) from ItemsCountCte

GO

select * from 
(SELECT TOP (1000) [CountryId]
      ,[CountryName]
      ,[ContinentId]
      ,ROW_NUMBER() over (ORDER BY [CountryName] ASC) as rowNumber
  FROM [HistoricalEvents].[dbo].[tblCountry]) as c
  where c.rowNumber > any(select count([CountryId]) / 2 from [HistoricalEvents].[dbo].[tblCountry])

GO

create function getItemsCount()
    RETURNS int 
as
BEGIN
    declare @itemsCount int;
    select @itemsCount = count (*) from [HistoricalEvents].[dbo].[tblCountry];
    set @itemsCount = abs(@itemsCount / 2);
    RETURN @itemsCount
END

go

select * from 
(SELECT TOP (1000) [CountryId]
      ,[CountryName]
      ,[ContinentId]
      ,ROW_NUMBER() over (ORDER BY [CountryName] ASC) as rowNumber
  FROM [HistoricalEvents].[dbo].[tblCountry]) as c
  where c.rowNumber > [dbo].getItemsCount()

drop function [dbo].getItemsCount

GO