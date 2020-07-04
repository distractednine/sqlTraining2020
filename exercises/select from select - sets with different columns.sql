SELECT TOP (10000) [ID]
      ,[OrderID]
      ,[RuleInfo]
      ,[points]
      ,[Added]
      ,[MarkInGuard]
      ,[AllowAutoStatus]
      ,[riskmanagementId]
FROM [just-eat_IT].[dbo].[RiskScore]
where  year(Added) = 2020

select * from
    (select count (*) as count_DK
    FROM [just-eat_DK].[dbo].[RiskScore]
    where 
        year(Added) = 2020 and
        AllowAutoStatus <> 0) as a1,

    (select count (*) as count_ES
    FROM [just-eat_ES].[dbo].[RiskScore]
    where 
        year(Added) = 2020 and
        AllowAutoStatus <> 0) as a2,

    (select count (*) as count_IE
    FROM [just-eat_IE].[dbo].[RiskScore]
    where 
        year(Added) = 2020 and
        AllowAutoStatus <> 0) as a3,

    (select count (*) as count_IT
    FROM [just-eat_IT].[dbo].[RiskScore]
    where 
        year(Added) = 2020 and
        AllowAutoStatus <> 0) as a4,

    (select count (*) as count_no
    FROM [just-eat_no].[dbo].[RiskScore]
    where 
        year(Added) = 2020 and
        AllowAutoStatus <> 0) as a5