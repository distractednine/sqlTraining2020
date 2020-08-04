IF OBJECT_ID ('[dbo].[uf_getEpisodeTypesFirstWordsStr]') IS NOT NULL  
BEGIN
    DROP function [dbo].[uf_getEpisodeTypesFirstWordsStr];
END
IF OBJECT_ID ('[dbo].[uf_getDoctorAndEpTypeFirstWord]') IS NOT NULL  
BEGIN
    DROP function [dbo].[uf_getDoctorAndEpTypeFirstWord];
END

go

create function [dbo].[uf_getEpisodeTypesFirstWordsStr]()
returns varchar(max)
as 
begin
    declare @episodeTypeFirstWords varchar(max) = '';

    with getEpisodeTypesFirstWords as (
        select distinct
        case 
            when charindex(' ', EpisodeType) = 0 then EpisodeType
            else left(EpisodeType, charindex(' ', EpisodeType) - 1)
        end as 'EpisodeTypeFW'
        from [dbo].[tblEpisode]
    )

    select @episodeTypeFirstWords = 
        ('[' + EpisodeTypeFW + '], ' + @episodeTypeFirstWords)
        from getEpisodeTypesFirstWords 
        order by EpisodeTypeFW desc

    set @episodeTypeFirstWords = left(@episodeTypeFirstWords, len(@episodeTypeFirstWords) - 1) -- remove the last comma

    return @episodeTypeFirstWords
end

go

create function [dbo].[uf_getDoctorAndEpTypeFirstWord]()
returns table
as 
return  
    select 
        e.DoctorId,
        d.DoctorName,
        left(e.EpisodeType, charindex(' ', e.EpisodeType) - 1) as 'EpTypeFirstWord'
    from tblEpisode as e 
    join tblDoctor as d
        on e.DoctorId = d.DoctorId

go


select [dbo].[uf_getEpisodeTypesFirstWordsStr]()
select * from [dbo].[uf_getDoctorAndEpTypeFirstWord]()

-- normal pivot query
select * from 
    (
        select DoctorName, DoctorId, EpTypeFirstWord 
        from [dbo].[uf_getDoctorAndEpTypeFirstWord]()
    ) as daetfw
pivot (
    count(DoctorId)
    for EpTypeFirstWord in ([50th], [Autumn], [Christmas], [Easter], [Normal])
) as pivot_table


-- dynamic pivot query
declare @pivotQuery varchar(max) = '
    select * from 
    (
        select DoctorName, DoctorId, EpTypeFirstWord 
        from [dbo].[uf_getDoctorAndEpTypeFirstWord]()
    ) as daetfw
    pivot (
        count(DoctorId)
        for EpTypeFirstWord in (' + [dbo].[uf_getEpisodeTypesFirstWordsStr]() + ')
    ) as pivot_table';

exec(@pivotQuery)