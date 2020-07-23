SELECT *
FROM sys.triggers  
WHERE type = 'TR';

SELECT  name, parent_id, create_date, modify_date, is_instead_of_trigger  
FROM sys.triggers  
WHERE type = 'TR';

if exists (
    SELECT * 
    FROM sys.triggers
    WHERE name = 'uk_events_delete')
begin
    drop TRIGGER uk_events_delete
end
