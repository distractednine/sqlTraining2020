IF OBJECT_ID ('[dbo].[getAuthorId]') IS NOT NULL  
BEGIN
    DROP function [dbo].[getAuthorId];
END
IF OBJECT_ID ('[dbo].[getEpisodesByAuthor]') IS NOT NULL  
BEGIN
    DROP function [dbo].[getEpisodesByAuthor];
END
IF OBJECT_ID ('[dbo].[getEpisodesNotByAuthor]') IS NOT NULL  
BEGIN
    DROP function [dbo].[getEpisodesNotByAuthor];
END
IF OBJECT_ID ('[dbo].[getIdsOfEpisodeWithoutExclusiveEnemies]') IS NOT NULL  
BEGIN
    DROP function [dbo].[getIdsOfEpisodeWithoutExclusiveEnemies];
END

go

create function [dbo].[getAuthorId](@authorName varchar(max))
returns varchar(max)
as 
begin
    return 
        (select DoctorId 
        from tblDoctor 
        where lower(DoctorName) like '%' + @authorName)
end

go

create function [dbo].[getEpisodesByAuthor](@authorName varchar(max))
returns table
as 
    return 
        select e.EpisodeId, e.Title, e.DoctorId, ee.EnemyId, ee.EpisodeEnemyId
        from tblEpisode as e
        left join tblEpisodeEnemy as ee
            on e.EpisodeId = ee.EpisodeId
        where DoctorId = [dbo].getAuthorId(@authorName)

go

create function [dbo].[getEpisodesNotByAuthor](@authorName varchar(max))
returns table
as 
    return 
        select e.EpisodeId, e.Title, e.DoctorId, ee.EnemyId, ee.EpisodeEnemyId
        from tblEpisode as e
        join tblEpisodeEnemy as ee
            on e.EpisodeId = ee.EpisodeId
        where DoctorId <> [dbo].getAuthorId(@authorName)
        
go

create function [dbo].[getIdsOfEpisodeWithoutExclusiveEnemies](@authorName varchar(max))
returns table
as 
    return
        select distinct EpisodeId 
        from tblEpisodeEnemy
        where EnemyId in (
            select distinct EnemyId 
            from [dbo].[getEpisodesNotByAuthor](@authorName))

go

declare @authorName varchar(max) = 'Tennant'

select distinct EpisodeId, Title, DoctorId --, EnemyId, EpisodeEnemyId
from [dbo].[getEpisodesByAuthor](@authorName)
where 
    EpisodeId not in (
        select EpisodeId 
        from [dbo].getIdsOfEpisodeWithoutExclusiveEnemies(@authorName)) 
order by Title


-- select [dbo].[getAuthorId]('Tennant')
-- select  EnemyId from [dbo].[getEpisodesByAuthor]('Tennant')
-- select EnemyId from [dbo].[getEpisodesNotByAuthor]('Tennant') order by EnemyId