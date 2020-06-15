SELECT TOP (1000) [AuthorId]
      ,[AuthorName]
  FROM [DoctorWho].[dbo].[tblAuthor]

SELECT top(1)     
        STUFF(  
        (  
        SELECT ',' + CAST(T2.AuthorId  as varchar(max)) 
        FROM [DoctorWho].[dbo].[tblAuthor] T2  
        FOR XML PATH ('')  
        ),1,1,'')  
FROM [DoctorWho].[dbo].[tblAuthor] T1  
GROUP BY T1.AuthorId

go;

if OBJECT_ID('[dbo].[uf_getEpisodesByAuthorName]') is not null
begin
    drop FUNCTION [dbo].[uf_getEpisodesByAuthorName]
end

if OBJECT_ID('split') is not null
begin
    drop FUNCTION split
end

go;

create function [dbo].[getAuthorIds]()
    returns table
as
    return 
        SELECT top (1)     
                STUFF(  
                (  
                SELECT ',' + CAST(T2.AuthorId  as varchar(max)) 
                FROM [DoctorWho].[dbo].[tblAuthor] T2  
                FOR XML PATH ('')  
                ),1,1,'') as ids
        FROM [DoctorWho].[dbo].[tblAuthor] T1  
        GROUP BY T1.AuthorId
go;

CREATE FUNCTION split
(
        @string nvarchar(4000),
        @delimiter char(1)
)
RETURNS
@splitted TABLE
(
    Value nvarchar(4000)
)
AS
BEGIN
    DECLARE @a SMALLINT
    DECLARE @b SMALLINT
    SET @a = charindex(@delimiter, @string)
    INSERT @splitted VALUES (substring(@string, 1, @a-1))
    WHILE @a <> 0
    BEGIN
            SET @b = charindex(@delimiter, @string, @a+1)
            IF @b <> 0
                    INSERT @splitted VALUES (substring(@string, @a+1, @b-@a-1))
            ELSE
                    INSERT @splitted VALUES (substring(@string, @a+1, len(@string)-@a))
            SET @a = @b
    END
    RETURN
END

go;

IF OBJECT_ID(N'tempdb..#authorNames') IS NOT NULL
BEGIN
    DROP TABLE #authorNames
END

go;

declare @ids varchar(max);

select @ids = ids from [dbo].[getAuthorIds]()

select @ids as 'author ids string'

select auth.AuthorName as authorName
into #authorNames
from split(@ids, ',') as spl
join [DoctorWho].[dbo].[tblAuthor] as auth
    on spl.[Value] = auth.AuthorId

SELECT top (1)     
        STUFF(  
            (  
            SELECT ',' + CAST(T2.authorName  as varchar(max)) 
            FROM #authorNames T2  
            FOR XML PATH ('')  
            ), 1, 1, '') as 'author names string'
        FROM #authorNames T1  
        GROUP BY T1.authorName