SELECT TOP (1000) [CultureName]
      ,[CompanyID]
      ,[Key]
      ,[Text]
      ,[Comment]
  FROM [dbo].[LocalizedStrings]
  where [Key] like '%[[]%'
  or [Key] like '%]%'
  or [Key] like '%[%]%'
  or [Key] like '%[_]%'
  or [Key] like '%^%'

  

	insert into [dbo].[LocalizedStrings] ([CultureName], [CompanyID], [Key], [Text]) 
	values ('en', '00000000-0000-0000-0000-000000000000', 'test[', 'test11')

	insert into [dbo].[LocalizedStrings] ([CultureName], [CompanyID], [Key], [Text]) 
	values ('en', '00000000-0000-0000-0000-000000000000', 'test]', 'test11')
	
	insert into [dbo].[LocalizedStrings] ([CultureName], [CompanyID], [Key], [Text]) 
	values ('en', '00000000-0000-0000-0000-000000000000', 'test%', 'test11')

	insert into [dbo].[LocalizedStrings] ([CultureName], [CompanyID], [Key], [Text]) 
	values ('en', '00000000-0000-0000-0000-000000000000', 'test_', 'test11')

	insert into [dbo].[LocalizedStrings] ([CultureName], [CompanyID], [Key], [Text]) 
	values ('en', '00000000-0000-0000-0000-000000000000', 'test^', 'test11')
	


	delete from [dbo].[LocalizedStrings]
	where [CultureName] = 'en' 
	and [CompanyID] = '00000000-0000-0000-0000-000000000000' 
	and ([Key] like '[[]'
	  or [Key] like '[]]'
	  or [Key] like '[%]'
	  or [Key] like '[_]'
	  or [Key] like '%^%')




	  SELECT TOP (1000) [CultureName]
      ,[CompanyID]
      ,[Key]
      ,[Text]
      ,[Comment]
  FROM [dbo].[LocalizedStrings]
  where [Key] like '%[_]%'