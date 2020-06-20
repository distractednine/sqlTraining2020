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


with getEpisodeInfo as (
    select distinct 
        ep.EpisodeId, 
        ep.Title, 
        auth.AuthorName, doct.DoctorName, 
        isnull(en.EnemyName, '') as EnemyName,
        (len(ep.Title) + len(auth.AuthorName) + len(doct.DoctorName) + len(isnull(en.EnemyName, ''))) as score
    from [DoctorWho].[dbo].[tblEpisode] as ep
    left join tblAuthor as auth
        on ep.AuthorId = auth.AuthorId
    left join tblDoctor as doct
        on ep.DoctorId = doct.DoctorId
    left join tblEpisodeEnemy as epen
        on ep.EpisodeId = epen.EpisodeId
    left join tblEnemy as en
        on en.EnemyId = epen.EnemyId
)

select *
from getEpisodeInfo
where score < 40 and len(EnemyName) > 1
