SELECT TOP (1000) [EnemyId]
      ,[EnemyName]
      ,[Description]
  FROM [DoctorWho].[dbo].[tblEnemy]

go

IF OBJECT_ID ('[dbo].[getSeasonCompanions]') IS NOT NULL  
BEGIN
    DROP function [dbo].[getSeasonCompanions];
END

IF OBJECT_ID ('[dbo].[getSeasonCompanionsString]') IS NOT NULL  
BEGIN
    DROP function [dbo].[getSeasonCompanionsString];
END

go 

create function [dbo].[getSeasonCompanions] (@seriesNumber int)
returns table
as 
    return
        select distinct co.CompanionName
        from tblEpisodeCompanion as ec
        join tblEpisode as ep
            on ec.EpisodeId = ep.EpisodeId
            and ep.SeriesNumber = @seriesNumber
        join tblCompanion as co
            on ec.CompanionId = co.CompanionId

go

create function [dbo].[getSeasonCompanionsString] (@seriesNumber int)
returns varchar(max)
as 
    begin
        declare @companions varchar(max) = '';

        select @companions =  co.CompanionName + ', ' + @companions
        from [dbo].[getSeasonCompanions](@seriesNumber) as co

        return left(@companions, len(@companions) - 1)
    end

go

-- declare variables

DECLARE series_cursor CURSOR  
    FOR 
    SELECT distinct [SeriesNumber]
    FROM [DoctorWho].[dbo].[tblEpisode]

DECLARE @currentSeriesNumber int;
DECLARE @companionsList varchar(max);

declare @seriesCompanions table (seriesNumber int, companionsList varchar(max));

-- open cursor

OPEN series_cursor  

WHILE @@FETCH_STATUS = 0
BEGIN
    FETCH NEXT FROM series_cursor into @currentSeriesNumber; 

    if (@@FETCH_STATUS = 0)
    begin
        select @companionsList = [dbo].[getSeasonCompanionsString] (@currentSeriesNumber);

        insert into @seriesCompanions (seriesNumber, companionsList)
        values (@currentSeriesNumber, @companionsList)

        print 'processed series No ' + cast(@currentSeriesNumber as varchar(max)) 
    end
END

CLOSE series_cursor

print 'full list of companions by series was obtained.' 

select * from @seriesCompanions