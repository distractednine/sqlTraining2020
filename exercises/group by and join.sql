

SELECT comp.CompanionName, compAggr.numberOfEpisodes from
    (SELECT ec.CompanionId as CompanionId, count(*) as numberOfEpisodes
    from [dbo].[tblEpisodeCompanion] as ec
    group by ec.CompanionId) as compAggr
    JOIN [dbo].[tblCompanion] as comp
        on compAggr.CompanionId = comp.CompanionId
    ORDER by compAggr.numberOfEpisodes desc


SELECT en.EnemyName, enAggr.numberOfEpisodes from
    (SELECT ec.EnemyId as EnemyId, count(*) as numberOfEpisodes
    from [dbo].[tblEpisodeEnemy] as ec
    group by ec.EnemyId) as enAggr
    JOIN [dbo].[tblEnemy] as en
        on enAggr.EnemyId = en.EnemyId
    ORDER by enAggr.numberOfEpisodes desc
