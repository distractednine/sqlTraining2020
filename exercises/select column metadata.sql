SELECT * 
FROM INFORMATION_SCHEMA.COLUMNS
WHERE 
     TABLE_NAME  like 'tblEvent' AND 
     COLUMN_NAME like 'EventDate'
	 
	 SELECT t.name, c.name 
FROM sys.tables t 
JOIN sys.columns c ON t.object_id = c.object_id
JOIN sys.types y ON y.user_type_id = c.user_type_id
WHERE t.name like 'tblEvent'