use [just-eat_no]

if OBJECT_ID('tempdb..#orderWithJdIds') is not null
begin
    drop TABLE tempdb..#orderWithJdIds
end

-- get IDs for orders with (JustDelivery > 0) created today
select top (100) ID
into #orderWithJdIds
from [just-eat_no].[dbo].[Order] 
where 
    JustDelivery > 0 and 
    year(EffectuationTime) = 2020 and
    month(EffectuationTime) = 6 and
    day(EffectuationTime) = 18

-- check the predicate that is used for setting JustDelivery column in LOV-int
select ISNULL(mc.extdelivery, 0) as extdelivery
from [dbo].[Menucard] as mc
join [dbo].[Order] as o 
    on (mc.ID = o.MenuCardID
    and o.ID = any(select ID from #orderWithJdIds))

-- select the actual data for these orders 
select ID, Menucardid, JustDelivery, EffectuationTime
from [dbo].[Order] as o 
where o.ID = any(select ID from #orderWithJdIds)