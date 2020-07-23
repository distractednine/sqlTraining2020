

with MoviesBySpielberg as (
      select * 
      from [Movies].[dbo].[tblFilm]
      where FilmDirectorID = 
        any(
            select DirectorID 
            from [Movies].[dbo].[tblDirector]
            where DirectorName like '%Spielberg')
)

select Filmname, ActorName
from MoviesBySpielberg as mvs
join tblCast as cst
    on mvs.FilmID = cst.CastFilmID
join tblActor as act
    on act.ActorID = cst.CastActorID