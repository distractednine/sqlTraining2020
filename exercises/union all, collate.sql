DECLARE @itemsCount int = 3

select a.transact, a.colLength, tenant from
(SELECT TOP (@itemsCount) [transact] COLLATE database_default as transact, len([transact]) as colLength, 'DK' as tenant
    FROM [just-eat_DK].[dbo].[Order]
  where [transact] is not null
  order by colLength desc
  
  UNION ALL

  SELECT TOP (@itemsCount) [transact] COLLATE database_default as transact, len([transact]) as colLength, 'ES' as tenant
    FROM [just-eat_ES].[dbo].[Order]
  where [transact] is not null
  order by colLength desc

  UNION ALL

  SELECT TOP (@itemsCount) [transact] COLLATE database_default as transact, len([transact]) as colLength, 'IE' as tenant
    FROM [just-eat_IE].[dbo].[Order]
  where [transact] is not null
  order by colLength desc
  
    UNION ALL

  SELECT TOP (@itemsCount) [transact] COLLATE database_default as transact, len([transact]) as colLength, 'IT' as tenant
    FROM [just-eat_IT].[dbo].[Order]
  where [transact] is not null
  order by colLength desc
  
  UNION ALL

  SELECT TOP (@itemsCount) [transact] COLLATE database_default as transact, len([transact]) as colLength, 'no' as tenant
    FROM [just-eat_no].[dbo].[Order]
  where [transact] is not null
  order by colLength desc
  
  UNION ALL 

  SELECT TOP (@itemsCount) [transact] COLLATE database_default as transact, len([transact]) as colLength, 'uk' as tenant
    FROM [just-eat_uk].[dbo].[Order]
  where [transact] is not null
  order by colLength desc 
  
  ) as a 
  ORDER by a.tenant desc, a.colLength desc
