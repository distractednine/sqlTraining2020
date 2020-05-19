SELECT TOP (1000) [EpisodeEnemyId]
      ,[EpisodeId]
      ,[EnemyId]
  FROM [DoctorWho].[dbo].[tblEpisodeEnemy]

go;

    select ep.Title 
    from [dbo].[tblEpisode] as ep 
    inner join [dbo].[tblEpisodeEnemy] as ee
        on ep.EpisodeId = ee.EpisodeEnemyId
    inner join [dbo].[tblEnemy] as en 
        on (ee.EnemyId = en.EnemyId AND en.EnemyName LIKE '%Dalek%');
    
go;

