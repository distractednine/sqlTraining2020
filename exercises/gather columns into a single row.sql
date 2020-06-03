-- gather columns into a single row 1

create table #user (username varchar(25))

insert into #user (username) values ('Paul')
insert into #user (username) values ('John')
insert into #user (username) values ('Mary')

declare @tmp varchar(250)
SET @tmp = ''
select @tmp = @tmp + username + ', ' from #user

select SUBSTRING(@tmp, 0, LEN(@tmp))

-- gather columns into a single row 2

DECLARE @TABLE TABLE
(  
ID INT,  
USERS VARCHAR(10),  
ACTIVITY VARCHAR(10),  
PAGEURL VARCHAR(10)  
)

INSERT INTO @TABLE  
VALUES  (1, 'Me', 'act1', 'ab'),
        (2, 'Me', 'act1', 'cd'),
        (3, 'You', 'act2', 'xy'),
        (4, 'You', 'act2', 'st')


SELECT T1.USERS, T1.ACTIVITY,   
        STUFF(  
        (  
        SELECT ',' + T2.PAGEURL  
        FROM @TABLE T2  
        WHERE T1.USERS = T2.USERS  
        FOR XML PATH ('')  
        ),1,1,'')  
FROM @TABLE T1  
GROUP BY T1.USERS, T1.ACTIVITY