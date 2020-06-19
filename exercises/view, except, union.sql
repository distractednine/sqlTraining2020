go;

if (OBJECT_ID('[dbo].[vw_singleEpisodeCompanion]') is not null)
begin
    drop view [dbo].[vw_singleEpisodeCompanion];
end

if (OBJECT_ID('[dbo].[vw_singleEpisodeEnemy]') is not null)
begin
    drop view [dbo].[vw_singleEpisodeEnemy];
end

if (OBJECT_ID('[dbo].[vw_singleEpisodeEnemyOrCompanion]') is not null)
begin
    drop view [dbo].[vw_singleEpisodeEnemyOrCompanion];
end

if (OBJECT_ID('[dbo].[vw_multipleEpisodeEnemyOrCompanion]') is not null)
begin
    drop view [dbo].[vw_multipleEpisodeEnemyOrCompanion];
end

go;

create view [dbo].[vw_singleEpisodeCompanion] AS
    select e2.EpisodeId, e2.CompanionId 
    from
        (select CompanionId
        from tblEpisodeCompanion
        group by CompanionId
        having COUNT(CompanionId) = 1) as e1
    join tblEpisodeCompanion as e2
        on e1.CompanionId = e2.CompanionId

go;

create view [dbo].[vw_singleEpisodeEnemy] AS
    select e2.EpisodeId, e2.EnemyId  
    from
        (select EnemyId
        from tblEpisodeEnemy
        group by EnemyId
        having COUNT(EnemyId) = 1) as e1
    join tblEpisodeEnemy as e2
        on e1.EnemyId = e2.EnemyId

go;

create view [dbo].[vw_singleEpisodeEnemyOrCompanion] AS
    select distinct e.EpisodeId
    from
        (select EpisodeId 
        from [dbo].[vw_singleEpisodeCompanion]
        UNION
        select EpisodeId 
        from [dbo].[vw_singleEpisodeEnemy]) as e

go;

create view [dbo].[vw_multipleEpisodeEnemyOrCompanion] AS
    select e1.EpisodeId 
    from [dbo].[tblEpisode] as e1
    except
    select e2.EpisodeId
    from [dbo].[vw_singleEpisodeEnemyOrCompanion] as e2
go;

select COUNT(*) as 'allEpisodeCount'
from [dbo].[tblEpisode] 

select COUNT(*) as 'singleEpisodeEnemyOrCompanionCount'
from [dbo].[vw_singleEpisodeEnemyOrCompanion] 

select COUNT(*) as 'multipleEpisodeEnemyOrCompanion'
from [dbo].[vw_multipleEpisodeEnemyOrCompanion] 

select e.*
from [dbo].[tblEpisode] as e
join
    (SELECT EpisodeId 
    from [dbo].[vw_multipleEpisodeEnemyOrCompanion]) as mee
on e.EpisodeId = mee.EpisodeId