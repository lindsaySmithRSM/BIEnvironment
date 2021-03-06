USE [BI_Academic]
GO
/****** Object:  StoredProcedure [DW].[SSRS_Audit_DepartmentSummaryAll]    Script Date: 07/11/2014 15:17:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [DW].[SSRS_Audit_DepartmentSummaryAll]

@YearCode as varchar(1)
as


select Department, YearCode, DepartmentCode, NoPlannedMeetings, MeetingsRun,
		MeetingsAbandoned, 
		case when NoPlannedMeetings = 0 then 0 else MeetingsRun/ NoPlannedMeetings end 'Perc_Run',
		case when NoPlannedMeetings = 0 then 0 else MeetingsAbandoned/ NoPlannedMeetings end 'Perc_Cancelled',
		NoDelegates,
		case when MeetingsRun = 0 then 0 else NoDelegates/ MeetingsRun end 'AvgDelegatesperMeeting',
		NoJointMeetings,
		CPDAccredited, CPDPoints, PublicInterest	
from(
select Department, YearCode, left(Department, 4) 'DepartmentCode',
		sum(case when EventCodeLink like '%99' then 0 else 1 end) 'NoPlannedMeetings', 
		sum(case when eventstatus in ('Cancelled', 'Postponed', 'Abandoned') then 0 else
				case when eventdate >= getdate() then 0 else
					case when EventCodeLink like '%99' then 0 else 1 end end end) 'MeetingsRun',
		sum(case when eventstatus in ('Abandoned') then 1 else 0 end) 'MeetingsAbandoned',
		--cast(sum(case when eventstatus in ('Cancelled', 'Postponed', 'Abandoned') then 0 else
		--		case when eventdate >= getdate() then 0 else
		--			case when EventCodeLink like '%99' then 0 else 1 end end end) as float)/
		--	cast(sum(case when EventCodeLink like '%99' then 0 else 1 end) as float) 'Perc_Run',
		--sum(case when eventstatus in ('Cancelled') then 1 else 0 end) 'Cancelled',
		--cast(sum(case when eventstatus in ('Cancelled') then 1 else 0 end) as float)/
		--	cast(sum(case when EventCodeLink like '%99' then 0 else 1 end) as float) 'Perc_Cancelled',
		sum(DelegateCount) 'NoDelegates',
		--case when cast(sum(case when eventstatus in ('Cancelled', 'Postponed', 'Abandoned') then 0 else
		--		case when eventdate >= getdate() then 0 else
		--			case when EventCodeLink like '%99' then 0 else 1 end end end) as float)=0 then 0 else 
		--cast(sum(DelegateCount) as float)/
		--	cast(sum(case when eventstatus in ('Cancelled', 'Postponed', 'Abandoned') then 0 else
		--		case when eventdate >= getdate() then 0 else
		--			case when EventCodeLink like '%99' then 0 else 1 end end end) as float) end 'AvgDelegatesperMeeting',
		sum(case when JointSession = 'Y' then 1 else 0 end) 'NoJointMeetings',
		sum(case when isnumeric(cpdpoints) = 1 then 1 else 0 end) 'CPDAccredited',
		sum(case when isnumeric(cpdpoints) = 1 then cast(cpdpoints as float) else 0.0 end) 'CPDPoints',
		sum(case when publicinterest = 'Y' then 1 else 0 end) 'PublicInterest'
from DW.Audit_EventItems
where YearCode = @YearCode
	and left(Department, 2) in ('03','05','06','25','27','28','29') and EventStatus <> 'Abandoned'
group by  Department, YearCode
)Bob
GO
