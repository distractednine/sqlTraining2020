if OBJECT_ID('[dbo].[up_getCompanionsAndEnemiesNumber]') is not null
begin
    drop procedure [dbo].[up_getCompanionsAndEnemiesNumber]
end

go;

create procedure [dbo].[up_getCompanionsAndEnemiesNumber](@seriesNumber int, 
    @companionsNumber int output, @enemiesNumber int output)
as 
begin

    set @companionsNumber = 
        (select distinct count(ec.CompanionId)
        from [DoctorWho].[dbo].[tblEpisode] as e
        join [DoctorWho].[dbo].[tblEpisodeCompanion] as ec
            on e.EpisodeId = ec.EpisodeId
        where e.SeriesNumber = @seriesNumber)

    set @enemiesNumber = 
        (select distinct count(ee.EnemyId)
        from [DoctorWho].[dbo].[tblEpisode] as e
        join [DoctorWho].[dbo].[tblEpisodeEnemy] as ee
            on e.EpisodeId = ee.EpisodeId
        where e.SeriesNumber = @seriesNumber)

end

go;

declare @series_number int = 3
declare @companions_number int
declare @enemies_number int

exec [dbo].[up_getCompanionsAndEnemiesNumber] @series_number, @companions_number output, @enemies_number output

select @companions_number as 'companions number', @enemies_number as 'enemies number'
