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

go;

if OBJECT_ID('[dbo].[up_getOrderedEpisodes]') is not null
begin
    drop procedure [dbo].[up_getOrderedEpisodes]
end

go;

create PROCEDURE [dbo].[up_getOrderedEpisodes] (@orderCol1 varchar(max), @orderCol2 varchar(max))
as
    begin
        DECLARE @sqlQuery varchar(max);
        set @sqlQuery = 'select * from [dbo].[tblEpisode] order by ' + @orderCol1 + ', ' + @orderCol2;
        EXEC (@sqlQuery);
    end

go;

exec [dbo].[up_getOrderedEpisodes] 'Title', 'Notes';
