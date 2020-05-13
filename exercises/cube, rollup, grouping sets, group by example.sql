SELECT TOP (1000) [EventId]
      ,[EventName]
      ,[EventDate]
      ,[Description]
      ,[CountryId]
      ,[CategoryID]
  FROM [HistoricalEvents].[dbo].[tblEvent];

  go;

    update [HistoricalEvents].[dbo].[tblEvent] 
    set [Description] = 'this event' + [Description] + ' and that.'
    where EventId = any(
    select EventId 
    FROM 
        [HistoricalEvents].[dbo].[tblEvent] 
    where 
        [Description] like 'this%' AND
        [Description] like '%that.' and 
        len([Description]) < 210)
        go;

IF OBJECT_ID ('dbo.eventsContainingThisAndThat') IS NOT NULL  
BEGIN
    DROP view dbo.eventsContainingThisAndThat;
END

  go;

  create view dbo.eventsContainingThisAndThat as 
      select 
        case
            when [Description] like '%this%' then 1
            else 0 
        end as hasThis,
        case
            when [Description] like '%that%' then 1
            else 0 
        end as hasThat
        from [HistoricalEvents].[dbo].[tblEvent]
  go;

    select hasThis, 
        hasThat,
        COUNT(*) as countGroupBy
    from eventsContainingThisAndThat 
    group by hasThis, hasThat

    select hasThis, 
        hasThat,
        COUNT(*) as countRollup
    from eventsContainingThisAndThat 
    group by ROLLUP(hasThis, hasThat)


    select hasThis, 
        hasThat,
        COUNT(*) as countCube
    from eventsContainingThisAndThat 
    group by cube(hasThis, hasThat)

    select hasThis, 
        hasThat,
        COUNT(*) as countGroupingSets
    from eventsContainingThisAndThat 
    group by GROUPING SETS((hasThis, hasThat))

go