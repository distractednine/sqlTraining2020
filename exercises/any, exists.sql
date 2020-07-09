SELECT TOP (1000) [CastID]
      ,[CastFilmID]
      ,[CastActorID]
      ,[CastCharacterName]
  FROM [Movies].[dbo].[tblCast]



select count(flm.FilmName) as 'films without actors count 1'
from [dbo].[tblFilm] as flm
join [dbo].[tblCast] as cst
    on cst.CastFilmID = flm.FilmID 
left join [dbo].[tblActor] as act
    on act.ActorID = cst.CastActorID 
where cst.CastActorID  is null

select count(flm.FilmName) as 'films without actors count 2'
from [dbo].[tblFilm] as flm
join [dbo].[tblCast] as cst
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
where act.ActorID <> any (select CastActorID from [dbo].[tblCast] where CastActorID = act.ActorID)
