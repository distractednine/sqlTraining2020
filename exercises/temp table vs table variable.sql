drop table #directorsTempTable


go;

-- temp table

select DirectorID, DATEDIFF(year, DirectorDOB, GETDATE()) as directorAge, DirectorName 
INTO #directorsTempTable
FROM [dbo].[tblDirector]

select * from #directorsTempTable

-----------------

-- table variable

declare @directorsTableVariable table (directorId int, directorAge int, directorName varchar(max));

insert INTO @directorsTableVariable
select directorId, DATEDIFF(year, DirectorDOB, GETDATE()) as directorAge, directorName 
FROM [dbo].[tblDirector]


select * from @directorsTableVariable

