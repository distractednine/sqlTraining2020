SELECT TOP (1000) [CastID]
      ,[CastFilmID]
      ,[CastActorID]
      ,[CastCharacterName]
  FROM [Movies].[dbo].[tblCast]


-- insert a film without actors
declare @testFilmName varchar(max) = 'test film without actors';

if not exists (SELECT FilmID FROM [Movies].[dbo].[tblFilm] WHERE FilmName = @testFilmName)
BEGIN
    insert into [Movies].[dbo].[tblFilm] (FilmID, FilmName, FilmReleaseDate)
    values (
        (select (max(FilmId) + 1) from [Movies].[dbo].[tblFilm]), 
        @testFilmName, 
        getdate())

    select * 
    from [Movies].[dbo].[tblFilm]
    where FilmName = @testFilmName

    -- DELETE from [Movies].[dbo].[tblFilm]
    -- where FilmName = @testFilmName
END

-- insert an actor without roles in films
declare @testActorName varchar(max) = 'test actor withoutRoles';

if not exists (SELECT ActorID FROM [Movies].[dbo].[tblActor] WHERE ActorName = @testActorName)
BEGIN
    insert into [Movies].[dbo].[tblActor] ([ActorID],[ActorName],[ActorDOB],[ActorGender])
    values (
        (select (max(ActorID) + 1) from [Movies].[dbo].[tblActor]), 
        @testActorName, 
        getdate(),
        'male')

    select * 
    from [Movies].[dbo].[tblActor]
    where ActorName = @testActorName

    -- DELETE from [Movies].[dbo].[tblActor]
    -- where ActorName = @testActorName
END

-- if left join is not used here - the query won't find any results!
select count(flm.FilmName) as 'films without actors count 1'
from [dbo].[tblFilm] as flm
left join [dbo].[tblCast] as cst
    on cst.CastFilmID = flm.FilmID 
left join [dbo].[tblActor] as act
    on act.ActorID = cst.CastActorID 
where act.ActorID is null

select count(flm.FilmName) as 'films without actors count 2'
from [dbo].[tblFilm] as flm
left join [dbo].[tblCast] as cst
    on cst.CastFilmID = flm.FilmID
where not exists (select ActorID from [dbo].[tblActor] where ActorID = cst.CastActorID)

select count(act.ActorID) as 'actors not in cast count 1'
from  [dbo].[tblActor] as act
left join [dbo].[tblCast] as cst
    on act.ActorID = cst.CastActorID 
where cst.CastActorID is null

select count(*) as 'actors not in cast count 2'
from [dbo].[tblActor] as act
where not exists (select CastActorID from [dbo].[tblCast] where CastActorID = act.ActorID)

select count(*) as 'actors not in cast count 3'
from [dbo].[tblActor] as act
where act.ActorID <> all (select CastActorID from [dbo].[tblCast])
