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

-- pivot by year
select * from 
(
    SELECT EpisodeId, SeriesNumber, year(EpisodeDate) as year
    FROM [DoctorWho].[dbo].[tblEpisode]
) as eps
pivot (
    count(eps.EpisodeId)
    for year in ([2005], [2006], [2007], [2008], [2009], [2010], [2011], [2012], [2013], [2014])
    ) as pivot_table


-- pivot by SeriesNumber
select * from 
(
    SELECT EpisodeId, SeriesNumber, year(EpisodeDate) as year
    FROM [DoctorWho].[dbo].[tblEpisode]
) as eps
pivot (
    count(eps.EpisodeId)
    for SeriesNumber in ([1], [2], [3], [4], [5], [6], [7], [8], [9])
    ) as pivot_table