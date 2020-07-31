declare @punkEraStart datetime2 = cast('1975-01-01' as datetime2);
declare @punkEraEnd datetime2 = cast('1979-12-31' as datetime2);

with getEvents as (
    select 
        [EventId],
        [EventName],
        case 
            when EventDate < @punkEraStart then 'pre-punk era'
            when EventDate > @punkEraStart and  EventDate < @punkEraEnd  then 'punk era'
            when EventDate > @punkEraEnd  then 'post-punk era'
        end as era,
        case 
            when EventDate < @punkEraStart then 1
            when EventDate > @punkEraStart and EventDate < @punkEraEnd  then 2
            when EventDate > @punkEraEnd  then 3
        end as eraIdx
    from [HistoricalEvents].[dbo].[tblEvent]
)

-- select * from getEvents

select 
    a.era, 
    count(a.EventId) as 'eventsCount'
from getEvents as a
group by a.era, a.eraIdx
order by a.eraIdx