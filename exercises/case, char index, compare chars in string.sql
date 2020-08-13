declare @vowels varchar(max) = 'aeiou';

with getEventNamePatterns as (
  select 
    EventName,
    (case  
      when left(EventName, 1) = right(EventName, 1)
        then 'starts and ends with the same letter'
      when charindex(left(EventName, 1), @vowels) > 1 and charindex(right(EventName, 1), @vowels) > 1
        then 'starts and ends with a vowel'
      when charindex(left(EventName, 1), @vowels) > 1 and (charindex(left(EventName, 1), @vowels) = charindex(right(EventName, 1), @vowels))
        then 'starts and ends with the same vowel'
      else 'nothing'
    end) as EventNamePattern
  from [HistoricalEvents].[dbo].[tblEvent]
)

select EventNamePattern, count(EventName) as 'count'
from getEventNamePatterns 
group by EventNamePattern

select 
   EventName,
   left(EventName, 1) as firstLetter,
   right(EventName, 1) as lastLetter,
   case when charindex(left(EventName, 1), @vowels) > 0 then 'yes' else 'no' end as 'isFirstLetterVowel',
   case when charindex(right(EventName, 1), @vowels) > 0 then 'yes' else 'no' end as 'isLastLetterVowel'
from [HistoricalEvents].[dbo].[tblEvent]