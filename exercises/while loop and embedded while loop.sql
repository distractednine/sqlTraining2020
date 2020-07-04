declare @starttime DATETIME
declare @endtime DATETIME

DECLARE @current_index int = 1;
DECLARE @max_index int = 1000;
DECLARE @prev_index decimal;
DECLARE @inner_index decimal;
DECLARE @remainder decimal;
DECLARE @is_prime bit;

DECLARE @primeValues TABLE (numer int, sqrt real)

set @starttime = CURRENT_TIMESTAMP

WHILE @current_index < @max_index
BEGIN
    set @prev_index = @current_index - 1

    set @inner_index = 2;
    set @is_prime = 1;

    WHILE @inner_index < @prev_index
    BEGIN
        set @remainder = @current_index % @inner_index;

        -- print 'cur - ' + cast(@current_index as varchar(max)) + ', @inner_index - ' + cast(@inner_index as varchar(max)) + ', rem - '+ cast(@remainder as varchar(max))

        set @inner_index = @inner_index + 1;

        if (@remainder = 0)
        BEGIN
            set @is_prime = 0;
            BREAK
        END
    END

    if (@is_prime = 1)
    BEGIN
        insert into @primeValues (numer, sqrt)
        values (@current_index, sqrt(@current_index))
    END

    set @current_index = @current_index + 1;
END

set @endtime = CURRENT_TIMESTAMP

print 'found prime numbers for fist 1000 numbers in ' + cast(datediff(ms, @starttime, @endtime) as varchar(max)) +  ' ms'

select * from @primeValues;