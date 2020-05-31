SELECT TOP (1000) [EpisodeId]
      ,[SeriesNumber]
      ,[EpisodeNumber]
      ,[EpisodeType]
      ,[Title]
      ,[EpisodeDate]
      ,[AuthorId]
      ,[DoctorId]
      ,[Notes]
      ,[NumberOfEnemies]
  FROM [DoctorWho].[dbo].[tblEpisode]


if OBJECT_ID('[dbo].[up_getEpisodesBySeason]') is not null
begin
    drop procedure [dbo].[up_getEpisodesBySeason]
end

go;

create PROCEDURE [dbo].[up_getEpisodesBySeason] (@seasonNumber int = null)
as
    begin
        DECLARE @maxSeasonNUmber int;
        DECLARE @sqlQuery varchar(max);

        select @maxSeasonNUmber =  max([SeriesNumber]) from [dbo].[tblEpisode]
        set @sqlQuery = 'select * from [dbo].[tblEpisode]';

        if @seasonNumber is not NULL 
        BEGIN
            if(@seasonNumber >= 1 and @seasonNumber <= @maxSeasonNUmber)
            BEGIN
                set @sqlQuery = @sqlQuery + ' where [SeriesNumber] = ' + CAST(@seasonNumber as varchar(max));
            END
            ELSE
            BEGIN;
                THROW 51000, 'Invalid season number was provided!', 1;
            END
        END

        EXEC (@sqlQuery);
    end

go;

exec [dbo].[up_getEpisodesBySeason] ;
