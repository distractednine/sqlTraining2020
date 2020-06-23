declare @testColumnExists bit;
select @testColumnExists = CASE
       WHEN EXISTS(
           SELECT 1 
           FROM INFORMATION_SCHEMA.COLUMNS 
           WHERE 
                TABLE_NAME  like 'tblLanguage' AND
                 COLUMN_NAME like 'some_column')
           THEN 1 
       ELSE 0 
   END

select @testColumnExists as 'testColumnExists'