USE [BI_Academic]
GO
/****** Object:  StoredProcedure [DW].[TBuild_CouncilMeetingTasks]    Script Date: 07/11/2014 15:17:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--drop table #PickMe


CREATE proc [DW].[TBuild_CouncilMeetingTasks]
as

truncate table  DW.CouncilMeetingTasks

insert into  DW.CouncilMeetingTasks
--OUTPUT FOR EXCEL
select isnull(SessionName, 'Meeting') 'Session Name', E.Code 'Event Code', E.[Name] 'Event Name', E.Start_Date 'Event Date',
isnull(NoDelegates,0) 'Delegate Nos', 
case when isnull(BOB.A, '') = '' then 'N/A' else isnull(BOB.ATime, '') end +char('13')+	char('10')+	
case when isnull(AExpected, '01 Jan 1900') <> '01 Jan 1900' then  
	cast(day(AExpected)as varchar)+'/'+cast(month(AExpected)as varchar)+'/'+cast(year(AExpected)as varchar) else '' end  +char('13')+	char('10')+	
case when isnull(AReview, '01 Jan 1900') <> '01 Jan 1900' then  
	cast(day(AReview)as varchar)+'/'+cast(month(AReview)as varchar)+'/'+cast(year(AReview)as varchar) else '' end 'Agenda/ Papers preparation and approval', 
case when isnull(BOB.B, '') = '' then 'N/A' else isnull(BOB.BTime, '') end +char('13')+	char('10')+	
case when isnull(BExpected, '01 Jan 1900') <> '01 Jan 1900' then  
	cast(day(BExpected)as varchar)+'/'+cast(month(BExpected)as varchar)+'/'+cast(year(BExpected)as varchar) else '' end  +char('13')+	char('10')+	
case when isnull(BReview, '01 Jan 1900') <> '01 Jan 1900' then  
	cast(day(BReview)as varchar)+'/'+cast(month(BReview)as varchar)+'/'+cast(year(BReview)as varchar) else '' end  'Agenda/ Papers to council',
case when isnull(BOB.B1, '') = '' then 'N/A' else isnull(BOB.B1time, '') end +char('13')+	char('10')+	
case when isnull(B1Expected, '01 Jan 1900') <> '01 Jan 1900' then  
	cast(day(B1Expected)as varchar)+'/'+cast(month(B1Expected)as varchar)+'/'+cast(year(B1Expected)as varchar) else '' end  +char('13')+	char('10')+	
case when isnull(B1Review, '01 Jan 1900') <> '01 Jan 1900' then  
	cast(day(B1Review)as varchar)+'/'+cast(month(B1Review)as varchar)+'/'+cast(year(B1Review)as varchar) else '' end  'Action notes to council',


isnull(EventCoordinator,'') 'EventCoordinator', E.Comment 'EventComment', lu2.lookup_full_desc 'EventStatus'

from RSMCRM.RSM_LIVE.dbo.Event E with(nolock) left outer join  
[BI_Reference].LU.TDates TD on TD.TDate = E.Start_Date left outer join
RSMCRM.RSM_LIVE.dbo.lookup lu with(nolock)  on lu.lookup_ref = E.Category left outer join
RSMCRM.RSM_LIVE.dbo.lookup lu2 with(nolock) on lu2.lookup_ref = E.status left outer join
	(select S.event_ref, sum(delegate_count) 'NoDelegates', isnull(NAME, 'Meeting') 'SessionName' 
	from RSMCRM.RSM_LIVE.dbo.session S with(nolock)
	group by S.event_ref, isnull(NAME, 'Meeting') )BD
	on BD.Event_Ref = E.Event_Ref left outer join
(select E.Code 'EventCode', 
	max(case when Attribute_Code = 'EVEC' then A.Detail else '' end) 'EventCoordinator'
	from RSMCRM.RSM_LIVE.dbo.[Event] E with(nolock) inner join
	RSMCRM.RSM_LIVE.dbo.Attribute A with(nolock) on A.event_ref = E.Event_Ref left outer join
	RSMCRM.RSM_LIVE.dbo.lookup AT with(nolock) on AT.lookup_code = A.Attribute_Code
	where E.code like 'C6%'
	group by E.Code)Fred on Fred.EventCode = E.Code left outer join
(select MAX(case when lu.lookup_ref = 3640 then isnull(completed, '') else '' end) 'A',
		MAX(case when lu.lookup_ref = 3641 then isnull(completed, '') else '' end) 'B',
		MAX(case when lu.lookup_ref = 3642 then isnull(completed, '') else '' end) 'B1',

		MAX(case when lu.lookup_ref = 3640 then 
			case when isnull(completed, '') = 'N' then 'N' else
			case when isnull(Review_Date,'01 Jan 1900')<=isnull(Expected_Date, '01 Jan 1900') then 'Y' else 'N' end end end) 'ATime',
		MAX(case when lu.lookup_ref = 3641 then 
			case when isnull(completed, '') = 'N' then 'N' else
			case when isnull(Review_Date,'01 Jan 1900')<=isnull(Expected_Date, '01 Jan 1900') then 'Y' else 'N' end end end) 'BTime',
		MAX(case when lu.lookup_ref = 3642 then 
			case when isnull(completed, '') = 'N' then 'N' else
			case when isnull(Review_Date,'01 Jan 1900')<=isnull(Expected_Date, '01 Jan 1900') then 'Y' else 'N' end end end) 'B1time',

		MAX(case when lu.lookup_ref = 3640 then isnull(Expected_Date, '01 Jan 1900') else '01 Jan 1900' end) 'AExpected',
		MAX(case when lu.lookup_ref = 3641 then isnull(Expected_Date, '01 Jan 1900') else '01 Jan 1900' end) 'BExpected',
		MAX(case when lu.lookup_ref = 3642 then isnull(Expected_Date, '01 Jan 1900') else '01 Jan 1900' end)'B1Expected',

		MAX(case when lu.lookup_ref = 3640 then isnull(Review_Date,'01 Jan 1900') else '01 Jan 1900' end) 'AReview',
		MAX(case when lu.lookup_ref = 3641 then isnull(Review_Date,'01 Jan 1900') else '01 Jan 1900' end) 'BReview',
		MAX(case when lu.lookup_ref = 3642 then isnull(Review_Date,'01 Jan 1900') else '01 Jan 1900' end) 'B1Review',
	Event_Ref  
from RSMCRM.RSM_LIVE.dbo.task T with(nolock) inner join
RSMCRM.RSM_LIVE.dbo.lookup lu with(nolock) on lu.lookup_ref = T.type 
GROUP BY Event_Ref)BOB on BOB.Event_Ref = E.Event_Ref
WHERE E.Category in (3639)


GO
