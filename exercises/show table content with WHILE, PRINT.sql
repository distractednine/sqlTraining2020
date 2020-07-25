  declare @eventsNumber int = 0;
  declare @currentIndex int = 0;
  declare @eventName varchar(max);
  declare @eventDate datetime2;
  set @eventsNumber = (select max(EventId) from tblEvent)

  while (@currentIndex <= @eventsNumber)
  begin
    set @eventName = (select EventName from tblEvent where EventId = @currentIndex)
    set @eventDate = (select EventDate from tblEvent where EventId = @currentIndex)

    if(@eventName is not null)
    begin
      print 'EventId: ' + cast(@currentIndex as varchar(max)) + ', EventName: ' + @eventName + ', EventDate: ' + convert(varchar(50), @eventDate, 126)
    end
    else
    begin
        print 'no event with id ' + cast(@currentIndex as varchar(10)) + ' was found'
    end

    set @currentIndex = @currentIndex + 1;
  end

  