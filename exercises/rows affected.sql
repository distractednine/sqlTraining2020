set NOCOUNT on;

SELECT TOP (1000) *  FROM [HistoricalEvents].[dbo].[tblEvent]

declare @rowsAffected int = @@rowcount 

PRINT 'rows affected ' + cast (@rowsAffected + 9999 as VARCHAR(max))