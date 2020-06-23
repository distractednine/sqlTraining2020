use [Movies]

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

if (@testColumnExists = 1)
begin 
    -- select constraint name
    SELECT CONSTRAINT_NAME
    FROM INFORMATION_SCHEMA.REFERENTIAL_CONSTRAINTS 
    WHERE UNIQUE_CONSTRAINT_NAME = 'PK_tblActor'

    alter table [dbo].[tblLanguage]
    drop CONSTRAINT fk_tblActor

    alter table [dbo].[tblLanguage]
    drop column some_column
end

delete from [dbo].[tblLanguage]
WHERE LanguageID > 99

SELECT TOP (1000) * 
FROM [dbo].[tblLanguage]

select top (100) *
from [dbo].tblActor

alter table [dbo].[tblLanguage]
add some_column int

insert into [dbo].[tblLanguage] (LanguageID, LanguageName)
values (112, 'test.')

ALTER TABLE [dbo].[tblLanguage]
ADD CONSTRAINT fk_tblActor
FOREIGN KEY (some_column) REFERENCES [dbo].tblActor(ActorId);

insert into [dbo].[tblLanguage] (LanguageID, LanguageName)
values (113, 'test.')

update [dbo].[tblLanguage]
set some_column = 1

alter table [dbo].[tblLanguage]
alter column some_column int not null

insert into [dbo].[tblLanguage] (LanguageID, LanguageName, some_column)
values (114, 'test.', 2)

