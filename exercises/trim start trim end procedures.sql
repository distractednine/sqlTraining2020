SELECT *
FROM [HistoricalEvents].[dbo].[tblEvent]

go;

if OBJECT_ID('[dbo].[up_trimStart]') is not NULL
begin
  drop procedure [dbo].[up_trimStart];
end

go;

create procedure [dbo].[up_trimStart](@prefixString varchar(max))
as
begin
  declare @prefixLen int = LEN(@prefixString)

  update [HistoricalEvents].[dbo].[tblEvent]
  set [Description] = SUBSTRING([Description], @prefixLen + 1, LEN([Description]) - @prefixLen)
  where [Description] like @prefixString + '%'

  PRINT 'affected rows: ' + cast(@@RowCount as varchar(max))
end

go;

if OBJECT_ID('[dbo].[up_trimEnd]') is not NULL
begin
  drop procedure [dbo].[up_trimEnd];
end

go;

create procedure [dbo].[up_trimEnd](@suffixString varchar(max))
as
begin
  declare @suffixLen int = LEN(@suffixString)

  update [HistoricalEvents].[dbo].[tblEvent]
  set [Description] = SUBSTRING([Description], 1, LEN([Description]) - @suffixLen)
  where [Description] like '%' + @suffixString

  PRINT 'affected rows: ' + cast(@@RowCount as varchar(max))
end

go;

declare @prefix varchar(max) = 'this event';
declare @suffix varchar(max) = ' and that. and tha';

exec [dbo].[up_trimStart] @prefix;
exec [dbo].[up_trimEnd] @suffix;



