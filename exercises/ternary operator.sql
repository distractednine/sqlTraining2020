declare @isAscOrder int = 1
declare @order varchar(max) = case @isAscOrder when 1 then 'asc' else 'desc' end
select @order as 'order'