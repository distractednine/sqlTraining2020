SELECT TOP (1000) [DoctorId]
      ,[DoctorNumber]
      ,[DoctorName]
      ,[BirthDate]
      ,[FirstEpisodeDate]
      ,[LastEpisodeDate]
  FROM [DoctorWho].[dbo].[tblDoctor]

set NOCOUNT off
begin TRANSACTION
  INSERT INTO tblDoctor(DoctorName,DoctorNumber) VALUES ('Shaun the Sheep',13)
IF 2 + 2 = 5
begin
  Rollback TRANSACTION
end
ELSE
begin
  commit TRANSACTION
end

-- delete FROM [DoctorWho].[dbo].[tblDoctor] where DoctorId = 13