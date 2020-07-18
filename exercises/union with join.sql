declare @yearAdded int = 2020

select 
       tenant,
       entriesCount, 
       riskmanagementId,
       [Description],
       Field,
       Condition,
       The_Value,
       AllowAutoStatus
 from
    (

    -- dk
    select 
        'dk' as tenant,
        rs.riskmanagementId as riskmanagementId,
        rs.entriesCount as entriesCount, 
        rm.Description COLLATE database_default as [Description],
        rm.Field COLLATE database_default as Field,
        rm.Condition COLLATE database_default  as Condition,
        rm.The_Value COLLATE database_default as The_Value,
        rm.AllowAutoStatus  as AllowAutoStatus
    from
    (select 
        riskmanagementId, 
        count (*) as entriesCount
    FROM [just-eat_dk].[dbo].[RiskScore] 
    where 
        year(Added) = @yearAdded and
        AllowAutoStatus = 0
    group by riskmanagementId) as rs
    join [just-eat_dk].[dbo].[RiskManagement] as rm
        on rm.Id = rs.riskmanagementId

    union 

    -- es
    select 
        'es' as tenant,
        rs.riskmanagementId as riskmanagementId,
        rs.entriesCount as entriesCount, 
        rm.Description COLLATE database_default as [Description],
        rm.Field COLLATE database_default as Field,
        rm.Condition COLLATE database_default  as Condition,
        rm.The_Value COLLATE database_default as The_Value,
        rm.AllowAutoStatus  as AllowAutoStatus
    from
    (select 
        riskmanagementId, 
        count (*) as entriesCount
    FROM [just-eat_es].[dbo].[RiskScore] 
    where 
        year(Added) = @yearAdded and
        AllowAutoStatus = 0
    group by riskmanagementId) as rs
    join [just-eat_es].[dbo].[RiskManagement] as rm
        on rm.Id = rs.riskmanagementId

    union 

    -- ie
    select 
        'ie' as tenant,
        rs.riskmanagementId as riskmanagementId,
        rs.entriesCount as entriesCount, 
        rm.Description COLLATE database_default as [Description],
        rm.Field COLLATE database_default as Field,
        rm.Condition COLLATE database_default  as Condition,
        rm.The_Value COLLATE database_default as The_Value,
        rm.AllowAutoStatus  as AllowAutoStatus
    from
    (select 
        riskmanagementId, 
        count (*) as entriesCount
    FROM [just-eat_ie].[dbo].[RiskScore] 
    where 
        year(Added) = @yearAdded and
        AllowAutoStatus = 0
    group by riskmanagementId) as rs
    join [just-eat_ie].[dbo].[RiskManagement] as rm
        on rm.Id = rs.riskmanagementId

    union 

    -- it
    select 
        'it' as tenant,
        rs.riskmanagementId as riskmanagementId,
        rs.entriesCount as entriesCount, 
        rm.Description COLLATE database_default as [Description],
        rm.Field COLLATE database_default as Field,
        rm.Condition COLLATE database_default as Condition,
        rm.The_Value COLLATE database_default as The_Value,
        rm.AllowAutoStatus  as AllowAutoStatus
    from
    (select 
        riskmanagementId, 
        count (*) as entriesCount
    FROM [just-eat_it].[dbo].[RiskScore] 
    where 
        year(Added) = @yearAdded and
        AllowAutoStatus = 0
    group by riskmanagementId) as rs
    join [just-eat_it].[dbo].[RiskManagement] as rm
        on rm.Id = rs.riskmanagementId

    union 

    -- no
    select 
        'no' as tenant,
        rs.riskmanagementId as riskmanagementId,
        rs.entriesCount as entriesCount, 
        rm.Description COLLATE database_default as [Description],
        rm.Field COLLATE database_default as Field,
        rm.Condition COLLATE database_default as Condition,
        rm.The_Value COLLATE database_default as The_Value,
        rm.AllowAutoStatus as AllowAutoStatus
    from
    (select 
        riskmanagementId, 
        count (*) as entriesCount
    FROM [just-eat_no].[dbo].[RiskScore] 
    where 
        year(Added) = @yearAdded and
        AllowAutoStatus = 0
    group by riskmanagementId) as rs
    join [just-eat_no].[dbo].[RiskManagement] as rm
        on rm.Id = rs.riskmanagementId

    ) as data
    
order by tenant, entriesCount desc