
select decade, count(*) as eventsCount
from (
    SELECT 
        case 
            when year(EventDate) > 2020 and year(EventDate) < 2030 then '21 cent - 20th'
            when year(EventDate) > 2010 and year(EventDate) < 2020 then '21 cent - 10th'
            when year(EventDate) > 2000 and year(EventDate) < 2010 then '21 cent - 00th'
            when year(EventDate) > 1990 and year(EventDate) < 2000 then '20 cent - 90th'
            when year(EventDate) > 1980 and year(EventDate) < 1990 then '20 cent - 80th'
            when year(EventDate) > 1970 and year(EventDate) < 1980 then '20 cent - 70th'
            when year(EventDate) > 1960 and year(EventDate) < 1970 then '20 cent - 60th'
            when year(EventDate) > 1950 and year(EventDate) < 1960 then '20 cent - 50th'
            when year(EventDate) > 1940 and year(EventDate) < 1950 then '20 cent - 40th'
            when year(EventDate) < 1940 then 'before 20 cent - 40th'
            else 'unknown'
        end
        as decade
    FROM [HistoricalEvents].[dbo].[tblEvent]
) as decades
group by decade


-- to test correctness
select * from
(select count(* ) as '21 cent - 00th'
from [HistoricalEvents].[dbo].[tblEvent]
where year(EventDate) > 2000 and year(EventDate) < 2010) as a1,

(select count(* ) as '20 cent - 90th'
from [HistoricalEvents].[dbo].[tblEvent]
where year(EventDate) > 1990 and year(EventDate) < 2000) as a2,

(select count(* ) as '20 cent - 80th'
from [HistoricalEvents].[dbo].[tblEvent]
where year(EventDate) > 1980 and year(EventDate) < 1990) as a3,

(select count(* ) as '20 cent - 70th'
from [HistoricalEvents].[dbo].[tblEvent]
where year(EventDate) > 1970 and year(EventDate) < 1980) as a4,

(select count(* ) as '20 cent - 60th'
from [HistoricalEvents].[dbo].[tblEvent]
where year(EventDate) > 1960 and year(EventDate) < 1970) as a5,

(select count(* ) as '20 cent - 50th'
from [HistoricalEvents].[dbo].[tblEvent]
where year(EventDate) > 1950 and year(EventDate) < 1960) as a6,

(select count(* ) as '20 cent - 40th'
from [HistoricalEvents].[dbo].[tblEvent]
where year(EventDate) > 1940 and year(EventDate) < 1950) as a7,

(select count(* ) as 'before 20 cent - 40th'
from [HistoricalEvents].[dbo].[tblEvent]
where year(EventDate) < 1940) as a8