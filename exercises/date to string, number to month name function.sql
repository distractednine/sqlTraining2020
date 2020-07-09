SELECT TOP (1000) [ContinentId]
      ,[ContinentName]
FROM [HistoricalEvents].[dbo].[tblContinent]

go;

if (OBJECT_ID('[dbo].[uf_MonthNumberToName]') is not null)
BEGIN
    drop FUNCTION [dbo].[uf_MonthNumberToName]
END

if (OBJECT_ID('[dbo].[uf_beautifyDate]') is not null)
BEGIN
    drop FUNCTION [dbo].[uf_beautifyDate]
END

go;

create function [dbo].[uf_MonthNumberToName](@monthNumber int)
returns varchar(max)
AS
BEGIN
    if(@monthNumber < 0 or @monthNumber > 12)
    BEGIN;
        return 'error occurred, looser!'
    END

    RETURN datename(mm, cast('2017-' + cast(@monthNumber as varchar(2)) + '-01' as datetime))
END

go;

create function [dbo].[uf_beautifyDate](@date datetime)
returns varchar(max)
AS
BEGIN
    RETURN datename(dw, @date) + ' ' + 
    cast(datepart(day, @date) as varchar(100)) + ' ' + 
    datename(month, @date) + ' ' + 
    cast(datepart(year, @date) as varchar(100))
END

go;

select [dbo].[uf_MonthNumberToName](5) as month, [dbo].[uf_MonthNumberToName](-5) as error

select [dbo].[uf_beautifyDate](cast('2017-05-01' as datetime)) as 'beautified date'