SELECT TOP (1000) [EpisodeId]
      ,[SeriesNumber]
      ,[EpisodeNumber]
      ,[EpisodeType]
      ,[Title]
      ,[EpisodeDate]
      ,[AuthorId]
      ,[DoctorId]
      ,[Notes],
      [NumberOfEnemies]
  FROM [DoctorWho].[dbo].[tblEpisode]

go;

alter TABLE [DoctorWho].[dbo].[tblEpisode]
add NumberOfEnemies int not null default 0;

go;

IF OBJECT_ID ('[dbo].[up_update_tblEpisode_setNumberOfEnemies]') IS NOT NULL  
BEGIN
    DROP procedure [dbo].[up_update_tblEpisode_setNumberOfEnemies];  
END

go;

create procedure [dbo].[up_update_tblEpisode_setNumberOfEnemies](@allowedNumberOfRows int)
AS
BEGIN
    declare @affectedRowsCount int;

    BEGIN TRANSACTION
        update [DoctorWho].[dbo].[tblEpisode] 
        set [NumberOfEnemies] = 
            (select count(*) 
            from [dbo].[tblEpisodeEnemy] as epen 
            where epen.EpisodeId = e.EpisodeId)
        from [DoctorWho].[dbo].[tblEpisode] as e
        
        set @affectedRowsCount = @@ROWCOUNT

        PRINT 'affected ' + cast(@affectedRowsCount as varchar(max)) + ' rows';

        if(@allowedNumberOfRows >= @affectedRowsCount)
        BEGIN
            commit TRANSACTION
            PRINT 'Commited changes'
        END
        ELSE
        BEGIN
            ROLLBACK TRANSACTION
            PRINT 'Rolled changes back'
        END
END

go;

EXEC [dbo].[up_update_tblEpisode_setNumberOfEnemies] 215;

select * from [DoctorWho].[dbo].[tblEpisode]

