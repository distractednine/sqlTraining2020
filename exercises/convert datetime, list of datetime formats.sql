declare @currentDate datetime = GETDATE();

declare @formatsNumber int = 200;
declare @currentIndex int = 0;

while (@currentIndex < @formatsNumber)
begin
    begin try   
        print 'Date format number: ' + cast(@currentIndex as varchar(max)) + '. Formatted date: ' + convert(varchar(23), @currentDate, @currentIndex)
    end try
    begin catch  
    end catch

    set @currentIndex = @currentIndex + 1;
end
