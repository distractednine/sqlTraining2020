create function [dbo].TrimLastComma(@str varchar(max))
    returns varchar(max)
as 
    begin
        return 
        case
            when len(@str) < 2 then @str
            when @str like '%,' then left(@str, len(@str)-1)
            else @str
        end
    end

go;