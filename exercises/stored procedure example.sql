SELECT TOP (1000) [EventId]
      ,[EventName]
      ,[EventDate]
      ,[Description]
      ,[CountryId]
  FROM [HistoricalEvents].[dbo].[tblEvent]
GO

create procedure GetHistoricalEvents(@tableName as varchar(max))
  as 
    begin
        declare @query varchar(max);
        set @query = 'select * from ' + @tableName;

        exec (@query)
    end
go

exec GetHistoricalEvents 'tblEvent'

drop procedure GetHistoricalEvents