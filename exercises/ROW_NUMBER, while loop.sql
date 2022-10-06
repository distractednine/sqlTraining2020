declare @dataToUpdate table (referralId uniqueidentifier, appointmentId varchar(36), rowNumber int);
declare @currentIndex int;
declare @itemsCount int;
declare @currentReferralId uniqueidentifier;
declare @currentAppointmentId uniqueidentifier;

-- fill @dataToUpdate temp table
INSERT INTO @dataToUpdate (referralId, appointmentId, rowNumber)
select 
	ReferralId,
	AppointmentId, 
	ROW_NUMBER() OVER (order by ReferralId) AS RowNumber 
	from
	(
		SELECT ReferralId, convert(nvarchar(36), min(AppointmentId)) as AppointmentId
		FROM [ReferralAppointmentLinks]                     
		GROUP BY ReferralId
	) as grouped

SET @currentIndex = 0;
SET @itemsCount = (SELECT COUNT(*) FROM @dataToUpdate)

-- iterate over rows one by one and update referrals
while @currentIndex <= @itemsCount
begin

	select @currentReferralId = [ReferralId] from @dataToUpdate where rowNumber = @currentIndex
	select @currentAppointmentId = [ReferralId] from @dataToUpdate where rowNumber = @currentIndex

	update dbo.Referrals
	set AppointmentId = @currentAppointmentId
	where ReferralId = @currentReferralId

    set @currentIndex = @currentIndex + 1;
end




-- analogue, but with join:
Update Referrals
Set Referrals.AppointmentId = Links.AppointmentIdValue
From Referrals Left join (
     Select ReferralId, min(AppointmentId) as AppointmentIdValue
     From ReferralAppointmentLinks
     Group by ReferralId) as Links 
on Referrals.ReferralId = Links.ReferralId