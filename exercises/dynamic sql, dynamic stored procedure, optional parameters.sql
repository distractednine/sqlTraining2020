SELECT TOP (1000) [EventId]
      ,[EventName]
      ,[EventDate]
      ,[Description]
      ,[CountryId]
      ,[CategoryID]
  FROM [HistoricalEvents].[dbo].[tblEvent]

go;

if (OBJECT_ID('[dbo].[sendDynamicQuery]') is not NULL)
begin
    drop procedure [dbo].[sendDynamicQuery]
end

go;

create procedure [dbo].[sendDynamicQuery](
    @columns varchar(max) = '[EventName],[EventDate]',
    @tableName varchar(max) = '[HistoricalEvents].[dbo].[tblEvent]',
    @numberRows int = 5,
    @orderColumn varchar(max) = '[Description]',
    @isAscOrder bit = 1)
as
begin
    declare @query varchar(max);
    declare @order varchar(max) = case @isAscOrder when 1 then 'asc' else 'desc' end;

    set @query = 'select top(' + cast(@numberRows as varchar(max)) + ') ' + @columns + ' from ' + @tableName + ' order by ' + @orderColumn + ' ' + @order
    
    exec(@query)
end

go;

exec [dbo].[sendDynamicQuery] 
exec [dbo].[sendDynamicQuery] '*'
exec [dbo].[sendDynamicQuery] 'EventId,CountryId'
exec [dbo].[sendDynamicQuery] 'CountryName,CountryId', '[HistoricalEvents].[dbo].[tblCountry]', 9, CountryName, 0

-- with optional parameter set:
exec [dbo].[sendDynamicQuery]  '*', @numberRows = 4 