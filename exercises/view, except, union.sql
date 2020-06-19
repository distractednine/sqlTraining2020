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
        select EpisodeId
        from tblEpisodeCompanion
        group by EpisodeId
        having COUNT(EpisodeId) = 1

go;

create view [dbo].[vw_singleEpisodeEnemy] AS
        select EpisodeId
        from tblEpisodeEnemy
        group by EpisodeId
        having COUNT(EpisodeId) = 1

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

select e.EpisodeId, e.Title
from [dbo].[tblEpisode] as e
join
    (SELECT EpisodeId 
    from [dbo].[vw_multipleEpisodeEnemyOrCompanion]) as mee
on e.EpisodeId = mee.EpisodeId
order by EpisodeId desc
