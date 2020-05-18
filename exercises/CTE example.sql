WITH   CommentCTE
AS     (SELECT TOP (10000) [admComment]
        FROM [dbo].[Order] 
        where [admComment] IS NOT NULL AND LEN([admComment]) > 0)

SELECT DISTINCT admComment,
        LEN(admComment) as 'comment len'
FROM  CommentCTE
   order by 'comment len' DESC