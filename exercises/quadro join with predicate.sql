SELECT TOP (1000) [AuthorId]
      ,[AuthorName]
  FROM [DoctorWho].[dbo].[tblAuthor]

go;

DECLARE @@bestepisodes table (episodeId int, title varchar(max), seasonNumber int, episodeNumber int, companionName varchar(max), author varchar(max))

insert into @@bestepisodes (episodeId , title, seasonNumber, episodeNumber, companionName, author)
select ep.EpisodeId as episodeId, 
        ep.Title as title,
        ep.SeriesNumber as seasonNumber,
        ep.EpisodeNumber as episodeNumber, 
        comp.CompanionName as companionName,
        auth.AuthorName as author
from [dbo].[tblCompanion] as comp
join [dbo].[tblEpisodeCompanion] as epComp 
    on (comp.CompanionId = epComp.CompanionId
    and comp.CompanionName = 'Amy Pond')
JOIN [dbo].[tblEpisode] as ep
    on epComp.EpisodeId = ep.EpisodeId
JOIN [dbo].[tblAuthor] as auth
    on (ep.AuthorId = auth.AuthorId
    and auth.AuthorName = 'Steven Moffat')
    
select * from @@bestepisodes
    



  