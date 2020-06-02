SELECT TOP (1000) [EpisodeEnemyId]
      ,[EpisodeId]
      ,[EnemyId]
  FROM [DoctorWho].[dbo].[tblEpisodeEnemy]


IF OBJECT_ID ('dbo.up_moveEnemyByEpisode') IS NOT NULL  
BEGIN
    DROP procedure dbo.up_moveEnemyByEpisode;
END

go

create PROCEDURE dbo.up_moveEnemyByEpisode(@episodeId int, @enemyId int)
as
    BEGIN
        begin TRANSACTION
            begin TRY
                set NOCOUNT on;
                declare @updatedEnemies table (enemyId int)
                declare @updatedRowsCount int

                update dbo.tblEpisodeEnemy
                set EnemyId = @enemyId
                output deleted.EnemyId
                into @updatedEnemies
                WHERE EpisodeId = @episodeId
                and  (select EnemyId from dbo.tblEnemy where EnemyId = @enemyId) is not null
                
                select @updatedRowsCount = count(enemyId) from @updatedEnemies

                if @updatedRowsCount = 0
                    BEGIN;
                        THROW 60000 , 'could not update dbo.tblEpisodeEnemy!', 1;
                    end;
            end try
            BEGIN CATCH
                ROLLBACK TRANSACTION
                PRINT 'error occurred. transaction rollback';
                THROW;
                set NOCOUNT off;
            end CATCH
            PRINT 'set enemy ' + CAST(@enemyId AS VARCHAR) + ' for episode ' + CAST(@episodeId AS VARCHAR)
            COMMIT TRANSACTION
    END
go

 exec dbo.up_moveEnemyByEpisode 15, 133

 SELECT TOP (1000) *  FROM [DoctorWho].[dbo].[tblEpisodeEnemy]
