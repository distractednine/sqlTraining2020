SELECT TOP (1000) [EnemyId]
      ,[EnemyName]
      ,[Description]
  FROM [DoctorWho].[dbo].[tblEnemy]

go; 

if OBJECT_ID('[dbo].[up_getItemsByChar]') is not null
begin
    drop procedure [dbo].[up_getItemsByChar]
end

go;

create procedure [dbo].[up_getItemsByChar](@char VARCHAR(max))
as
    BEGIN
        if (LEN(@char) <> 1)
        BEGIN;
            THROW 51000, 'The passed value must be exactly 1 char length', 1;  
        END;

        declare @itemsWithChar table (name VARCHAR(max), type VARCHAR(max));

        with getItemsWithChar as
        (
            select 
                AuthorName as name, 
                'Author' as type 
                from [dbo].tblAuthor
                WHERE AuthorName LIKE '%' + @char + '%'

            UNION

            select 
                CompanionName as name, 
                'Companion' as type 
                from [dbo].tblCompanion
                WHERE CompanionName LIKE '%' + @char + '%'
                
            UNION

            select 
                DoctorName as name, 
                'Doctor' as type 
                from [dbo].tblDoctor
                WHERE DoctorName LIKE '%' + @char + '%'

            UNION

            select 
                EnemyName as name, 
                'Enemy' as type 
                from [dbo].tblEnemy
                WHERE EnemyName LIKE '%' + @char + '%'
        )

        insert into @itemsWithChar
        SELECT name, type
        FROM getItemsWithChar;

        select * from @itemsWithChar order by type;
    END

go; 

exec [dbo].[up_getItemsByChar] 's'