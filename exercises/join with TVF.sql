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

go;

if OBJECT_ID('[dbo].[uf_getEpisodesByAuthorName]') is not null
begin
    drop FUNCTION [dbo].[uf_getEpisodesByAuthorName]
end

go;

create FUNCTION [dbo].[uf_getEpisodesByAuthorName] (@authorName varchar(max))
returns TABLE
as
    return 
        select ep.[EpisodeId], ep.[Title]
        from [DoctorWho].[dbo].[tblEpisode] as ep 
        inner join [DoctorWho].[dbo].[tblAuthor] as auth
            on (ep.AuthorId = auth.AuthorId and 
                lower(auth.AuthorName) like '%' + @authorName + '%')

go;


select distinct comp.[CompanionName] 
from [dbo].[tblCompanion] as comp
join [dbo].[tblEpisodeCompanion] as epc
    on comp.[CompanionId] = epc.[CompanionId]
join [dbo].[uf_getEpisodesByAuthorName] ('mp') as abn
    on epc.[EpisodeId] = abn.[EpisodeId]


