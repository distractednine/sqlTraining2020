SELECT TOP (1000) [CompanionId]
      ,[CompanionName]
      ,[WhoPlayed]
  FROM [DoctorWho].[dbo].[tblCompanion]

go;

IF OBJECT_ID ('dbo.uf_GetEpisodeIdByCompanionName') IS NOT NULL  
BEGIN
    DROP function dbo.uf_GetEpisodeIdByCompanionName;
END

IF OBJECT_ID ('dbo.uf_GetEpisodeIdByEnemyName') IS NOT NULL  
BEGIN
    DROP function dbo.uf_GetEpisodeIdByEnemyName;
END

go

create function [dbo].[uf_GetEpisodeIdByCompanionName](@compName varchar(max))
    returns table
as
    RETURN
        select ep.[EpisodeId]
      ,ep.[SeriesNumber]
      ,ep.[EpisodeNumber]
      ,ep.[EpisodeType]
      ,ep.[Title]
      ,ep.[EpisodeDate]
      ,ep.[AuthorId]
      ,ep.[DoctorId]
      ,ep.[Notes]
      ,ep.[NumberOfEnemies],
      comp.CompanionName as Appearing
        from [dbo].[tblEpisode] as ep
        join [dbo].[tblEpisodeCompanion] as epCo
            on (ep.EpisodeId = epCo.EpisodeCompanionId)
        join [dbo].[tblCompanion] as comp 
            on (epco.CompanionId = comp.CompanionId and 
            comp.CompanionName like '%' + @compName + '%')

go;

create function [dbo].[uf_GetEpisodeIdByEnemyName](@enemyName varchar(max))
    returns table
as
    RETURN
        select ep.[EpisodeId]
      ,ep.[SeriesNumber]
      ,ep.[EpisodeNumber]
      ,ep.[EpisodeType]
      ,ep.[Title]
      ,ep.[EpisodeDate]
      ,ep.[AuthorId]
      ,ep.[DoctorId]
      ,ep.[Notes]
      ,ep.[NumberOfEnemies],
      en.EnemyName as Appearing
        from [dbo].[tblEpisode] as ep
        join [dbo].[tblEpisodeEnemy] as epEn
            on (ep.EpisodeId = epEn.EpisodeId)
        join [dbo].[tblEnemy] as en
            on (epEn.EnemyId = en.EnemyId and 
            en.EnemyName like '%' + @enemyName + '%')

go;

IF OBJECT_ID ('tempdb..#episodesTempTable') IS NOT NULL  
BEGIN
    drop table #episodesTempTable;
END

go;

select ep.[SeriesNumber]
      ,ep.[EpisodeNumber]
      ,ep.[EpisodeType]
      ,ep.[Title]
      ,ep.[EpisodeDate]
      ,ep.[AuthorId]
      ,ep.[DoctorId]
      ,ep.[Notes]
      ,ep.[NumberOfEnemies]
      ,ep.Appearing
INTO #episodesTempTable
from (
    select * from [dbo].[uf_GetEpisodeIdByCompanionName]('wilf')
    UNION
    select * from [dbo].[uf_GetEpisodeIdByEnemyName]('ood')) as ep;


-- select * from #episodesTempTable

SELECT T1.[SeriesNumber]
      ,T1.[EpisodeNumber]
      ,T1.[EpisodeType]
      ,T1.[Title]
      ,T1.[EpisodeDate]
      ,T1.[AuthorId]
      ,T1.[DoctorId]
      ,T1.[Notes]
      ,T1.[NumberOfEnemies], 
        STUFF(  
        (  
        SELECT ',' + T2.Appearing  
        FROM #episodesTempTable T2  
        WHERE T1.Title = T2.Title  
        FOR XML PATH ('')  
        ),1,1,'')  as Appearing
FROM #episodesTempTable as T1  
GROUP BY T1.[SeriesNumber]
      ,T1.[EpisodeNumber]
      ,T1.[EpisodeType]
      ,T1.[Title]
      ,T1.[EpisodeDate]
      ,T1.[AuthorId]
      ,T1.[DoctorId]
      ,T1.[Notes]
      ,T1.[NumberOfEnemies] 



