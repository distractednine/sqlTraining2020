



SELECT [CompanionId]
      ,[CompanionName]
      ,[WhoPlayed] 
from tblCompanion 
where [CompanionId] not in (
    select [CompanionId] 
    from   [DoctorWho].[dbo].[tblEpisodeCompanion]
    group by [CompanionId] )