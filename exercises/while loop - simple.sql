declare @minYear int;
declare @maxYear int;

select @minYear = 
min(year(EventDate)) from [HistoricalEvents].[dbo].[tblEvent]
select @maxYear =
max(year(EventDate)) from [HistoricalEvents].[dbo].[tblEvent]

declare @currentYear int = @minYear;
declare @eventsNumber int;

while @currentYear <= @maxYear
begin
    select @eventsNumber = 
        count(EventId) 
        from [HistoricalEvents].[dbo].[tblEvent]
        where year(EventDate) = @currentYear;

    if (@eventsNumber > 0)
    BEGIN
        PRINT cast(@eventsNumber as VARCHAR(10)) + ' event(s) occurred in year ' +  cast(@currentYear as VARCHAR(10)) + ';'
    END

    set @currentYear = @currentYear + 1;
end