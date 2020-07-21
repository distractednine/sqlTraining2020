SELECT TOP (1000) [EventId]
      ,[EventName]
      ,[EventDate]
      ,[Description]
      ,[CountryId]
      ,[CategoryID]
  FROM [HistoricalEvents].[dbo].[tblEvent]

go;

create function [dbo].TrimLastComma(@str varchar(max))
    returns varchar(max)
as 
    begin
        return 
        case
            when len(@str) < 2 then @str
            when @str like '%,' then left(@str, len(@str)-1)
            else @str
        end
    end

go;

select EventName, [Description], CountryId, CategoryID
from [HistoricalEvents].[dbo].[tblEvent]
where 
    CountryId not in (
        select distinct CountryId
            from (
                select distinct top (30) [Description], [CountryId]
                from [HistoricalEvents].[dbo].[tblEvent]
                order by [Description] asc) as a)
and 
    CategoryID in (
        select distinct CategoryID
            from (
                select distinct top (15) [Description], [CategoryID]
                from [HistoricalEvents].[dbo].[tblEvent]
                where CategoryID is not null
                order by [Description] desc) as b)
    


declare @countries varchar(max) = ''

select @countries =  b.cnt  + ', ' + @countries from
        (select distinct cast(a.CountryId as varchar(max)) as cnt

            from (
                select distinct top (30) [Description], [CountryId]
                from [HistoricalEvents].[dbo].[tblEvent]
                order by [Description] asc) as a) as b
         
select dbo.TrimLastComma(@countries) as countries


declare @categories varchar(max) = ''

select @categories =  b.ctg  + ', ' + @categories from
        (select distinct cast(a.CategoryID as varchar(max)) as ctg

            from (
                select distinct top (15) [Description], [CategoryID]
                from [HistoricalEvents].[dbo].[tblEvent]
                where CategoryID is not null
                order by [Description] desc) as a ) as b

select dbo.TrimLastComma(@categories) as categories



select EventName, [Description], CountryId, CategoryID
from [HistoricalEvents].[dbo].[tblEvent]
where 
    CountryId not in (7, 6, 3, 2, 19, 18, 17) 
and
     CategoryID in (9, 8, 6, 5, 4, 3, 20, 16, 14, 12, 1)