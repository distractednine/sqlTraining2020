SELECT TOP (1000) [FilmID]
      ,[FilmName]
      ,[FilmReleaseDate]
      ,[FilmDirectorID]
      ,[FilmLanguageID]
      ,[FilmCountryID]
      ,[FilmStudioID]
      ,[FilmSynopsis]
      ,[FilmRunTimeMinutes]
      ,[FilmCertificateID]
      ,[FilmBudgetDollars]
      ,[FilmBoxOfficeDollars]
      ,[FilmOscarNominations]
      ,[FilmOscarWins]
  FROM [Movies].[dbo].[tblFilm]


select DATEDIFF(year, act.[ActorDOB], GETDATE()) as age, GETDATE() as now, act.[ActorDOB] as dob, [ActorName] 
                from [dbo].[tblActor] as act
                order by age desc

select DATEDIFF(year, dir.[DirectorDOB], GETDATE()) as age, GETDATE() as now, dir.[DirectorDOB] as dob, [DirectorName] 
                from [dbo].[tblDirector] as dir
                order by age desc

if OBJECT_ID('[dbo].[uf_getMaxActorAgeInDb]') is not null
begin
    drop function [dbo].[uf_getMaxActorAgeInDb]
end

if OBJECT_ID('[dbo].[uf_getDirectorsOlderThanAnyActor]') is not null
begin
    drop function [dbo].[uf_getDirectorsOlderThanAge]
end

go;

create function [dbo].[uf_getMaxActorAgeInDb]()
    returns int
    as
        begin
            return 
                (select max(DATEDIFF(year, act.[ActorDOB], GETDATE()))
                from [dbo].[tblActor] as act);
        end
    
go;

create function [dbo].[uf_getDirectorsOlderThanAge](@maxage int)
    returns TABLE
    AS
        return
            select directorId, directorAge, directorName from
                (select 
                    DATEDIFF(year, dir.[DirectorDOB], GETDATE()) as directorAge, 
                    dir.DirectorID as directorId,
                    dir.DirectorName as directorName
            from [dbo].tblDirector as dir) as d
            where directorAge > @maxage

go;

-- moveis made by directors older than any actor in db

declare @maxActorAge int = [dbo].[uf_getMaxActorAgeInDb]();

declare @directorsOlderThanAge table (directorId int, directorAge int, directorName varchar(max));

insert INTO @directorsOlderThanAge
select directorId, directorAge, directorName 
FROM [dbo].[uf_getDirectorsOlderThanAge](@maxActorAge)

SELECT f.FilmName
from [dbo].[tblFilm] as f
join @directorsOlderThanAge as d 
    on f.FilmDirectorID = d.directorId


--- moves with top 3 youngest actors

with youngestActors as(
    select top (3) 
        act.ActorID as actorId, 
        act.ActorName as actorName
    from [dbo].[tblActor] as act 
    ORDER by act.ActorDOB desc)

select ya.actorName, f.FilmName
from youngestActors as ya
join [dbo].[tblCast] as cst
    on ya.actorId = cst.CastActorId
join [dbo].[tblFilm] as f
    on cst.CastFilmID = f.FilmID
