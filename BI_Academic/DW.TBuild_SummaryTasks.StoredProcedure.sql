USE [BI_Academic]
GO
/****** Object:  StoredProcedure [DW].[TBuild_SummaryTasks]    Script Date: 07/11/2014 15:17:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE proc [DW].[TBuild_SummaryTasks]
as

truncate table DW.MeetingTasks

select Event_Ref, 
		case when first <> 0 then first else 
			case when second <> 0 then second else 
				case when third <> 0 then third else 'Meeting' end end end 'PickSession'
into #PickMe
from (
select	S.Event_Ref, 
		MAX(case when NoSessions = 1 then session_ref else	0 end) 'first',
		MAX(case when name like 'Meeting%' then Session_Ref else 0 end) 'Second',
		MAX(case when firstSession is not null then S.Session_Ref else 0 end) 'Third'
from RSMCRM.RSM_LIVE.dbo.session S inner join
(select event_ref, count(*) 'NoSessions'
from RSMCRM.RSM_LIVE.dbo.session
where allow_bookings = 'Y'
group by event_ref)NS on NS.event_Ref = S.Event_Ref left outer join
(select event_Ref, min(create_timestamp) 'FirstSession'
from RSMCRM.RSM_LIVE.dbo.session
where allow_bookings = 'Y'
group by event_ref)FS on FS.event_Ref = S.Event_Ref
					and FS.FirstSession = S.create_timestamp
where allow_bookings = 'Y'
		and case when NoSessions = 1 then session_ref else	
				case when name like 'Meeting%' then Session_Ref else
					case when firstSession is not null then S.Session_Ref else 0 end end end <> 0
group by S.Event_Ref)bob


--OUTPUT FOR EXCEL
insert into DW.MeetingTasks
select isnull(SessionName, 'Meeting') 'Session Name', E.Code 'Event Code', E.[Name] 'Event Name', E.Start_Date 'Event Date',
isnull(BudgetNoDelegates, 0) 'Budget Delegate Nos', isnull(NoDelegates,0) 'Delegate Nos', 
case when isnull(BOB.A, '') = '' then 'N/A' else isnull(BOB.ATime, '') end +char('13')+	char('10')+	
case when isnull(AExpected, '01 Jan 1900') <> '01 Jan 1900' then  
	cast(day(AExpected)as varchar)+'/'+cast(month(AExpected)as varchar)+'/'+cast(year(AExpected)as varchar) else '' end  +char('13')+	char('10')+	
case when isnull(AReview, '01 Jan 1900') <> '01 Jan 1900' then  
	cast(day(AReview)as varchar)+'/'+cast(month(AReview)as varchar)+'/'+cast(year(AReview)as varchar) else '' end 'Programme Received', 
case when isnull(BOB.B, '') = '' then 'N/A' else isnull(BOB.BTime, '') end +char('13')+	char('10')+	
case when isnull(BExpected, '01 Jan 1900') <> '01 Jan 1900' then  
	cast(day(BExpected)as varchar)+'/'+cast(month(BExpected)as varchar)+'/'+cast(year(BExpected)as varchar) else '' end  +char('13')+	char('10')+	
case when isnull(BReview, '01 Jan 1900') <> '01 Jan 1900' then  
	cast(day(BReview)as varchar)+'/'+cast(month(BReview)as varchar)+'/'+cast(year(BReview)as varchar) else '' end  'Budget Approved',
case when isnull(BOB.B1, '') = '' then 'N/A' else isnull(BOB.B1time, '') end +char('13')+	char('10')+	
case when isnull(B1Expected, '01 Jan 1900') <> '01 Jan 1900' then  
	cast(day(B1Expected)as varchar)+'/'+cast(month(B1Expected)as varchar)+'/'+cast(year(B1Expected)as varchar) else '' end  +char('13')+	char('10')+	
case when isnull(B1Review, '01 Jan 1900') <> '01 Jan 1900' then  
	cast(day(B1Review)as varchar)+'/'+cast(month(B1Review)as varchar)+'/'+cast(year(B1Review)as varchar) else '' end  'Joint Contract Signed',
case when isnull(BOB.C, '') = '' then 'N/A' else isnull(BOB.Ctime, '') end +char('13')+	char('10')+	
case when isnull(CExpected, '01 Jan 1900') <> '01 Jan 1900' then  
	cast(day(CExpected)as varchar)+'/'+cast(month(CExpected)as varchar)+'/'+cast(year(CExpected)as varchar) else '' end  +char('13')+	char('10')+	
case when isnull(CReview, '01 Jan 1900') <> '01 Jan 1900' then  
	cast(day(CReview)as varchar)+'/'+cast(month(CReview)as varchar)+'/'+cast(year(CReview)as varchar) else '' end  'CPD Applied For',
case when isnull(BOB.D,'') = '' then 'N/A' else isnull(BOB.DTime, '')end +char('13')+	char('10')+	
case when isnull(DExpected, '01 Jan 1900') <> '01 Jan 1900' then  
	cast(day(DExpected)as varchar)+'/'+cast(month(DExpected)as varchar)+'/'+cast(year(DExpected)as varchar) else '' end  +char('13')+	char('10')+	
case when isnull(DReview, '01 Jan 1900') <> '01 Jan 1900' then  
	cast(day(DReview)as varchar)+'/'+cast(month(DReview)as varchar)+'/'+cast(year(DReview)as varchar) else '' end  'Publicity Started',
case when isnull(BOB.E,'') = '' then 'N/A' else isnull(BOB.ETime, '')end +char('13')+	char('10')+	
case when isnull(EExpected, '01 Jan 1900') <> '01 Jan 1900' then  
	cast(day(EExpected)as varchar)+'/'+cast(month(EExpected)as varchar)+'/'+cast(year(EExpected)as varchar) else '' end  +char('13')+	char('10')+	
case when isnull(EReview, '01 Jan 1900') <> '01 Jan 1900' then  
	cast(day(EReview)as varchar)+'/'+cast(month(EReview)as varchar)+'/'+cast(year(EReview)as varchar) else '' end  'Publicity/ Low Nos',
case when isnull(BOB.E1, '') = '' then 'N/A' else isnull(BOB.E1Time, '') end +char('13')+	char('10')+	
case when isnull(E1Expected, '01 Jan 1900') <> '01 Jan 1900' then  
	cast(day(E1Expected)as varchar)+'/'+cast(month(E1Expected)as varchar)+'/'+cast(year(E1Expected)as varchar) else '' end  +char('13')+	char('10')+	
case when isnull(E1Review, '01 Jan 1900') <> '01 Jan 1900' then  
	cast(day(E1Review)as varchar)+'/'+cast(month(E1Review)as varchar)+'/'+cast(year(E1Review)as varchar) else '' end  'Low Nos/Remedial action',
case when isnull(BOB.F, '') = '' then 'N/A' else isnull(BOB.FTime, '') end +char('13')+	char('10')+	
case when isnull(FExpected, '01 Jan 1900') <> '01 Jan 1900' then  
	cast(day(FExpected)as varchar)+'/'+cast(month(FExpected)as varchar)+'/'+cast(year(FExpected)as varchar) else '' end  +char('13')+	char('10')+	
case when isnull(FReview, '01 Jan 1900') <> '01 Jan 1900' then  
	cast(day(FReview)as varchar)+'/'+cast(month(FReview)as varchar)+'/'+cast(year(FReview)as varchar) else '' end  'Speaker Letters',
case when isnull(BOB.G, '') = '' then 'N/A' else isnull(BOB.GTime, '') end +char('13')+	char('10')+	
case when isnull(GExpected, '01 Jan 1900') <> '01 Jan 1900' then  
	cast(day(GExpected)as varchar)+'/'+cast(month(GExpected)as varchar)+'/'+cast(year(GExpected)as varchar) else '' end  +char('13')+	char('10')+	
case when isnull(GReview, '01 Jan 1900') <> '01 Jan 1900' then  
	cast(day(GReview)as varchar)+'/'+cast(month(GReview)as varchar)+'/'+cast(year(GReview)as varchar) else '' end  'Send C&C Form (incl web lectures)',
case when isnull(BOB.H, '') = '' then 'N/A' else isnull(BOB.Htime, '') end +char('13')+	char('10')+	
case when isnull(HExpected, '01 Jan 1900') <> '01 Jan 1900' then  
	cast(day(HExpected)as varchar)+'/'+cast(month(HExpected)as varchar)+'/'+cast(year(HExpected)as varchar) else '' end  +char('13')+	char('10')+	
case when isnull(HReview, '01 Jan 1900') <> '01 Jan 1900' then  
	cast(day(HReview)as varchar)+'/'+cast(month(HReview)as varchar)+'/'+cast(year(HReview)as varchar) else '' end  'Final nos and Check BEO',
case when isnull(BOB.I, '') = '' then 'N/A' else isnull(BOB.ITime, '') end +char('13')+	char('10')+	
case when isnull(IExpected, '01 Jan 1900') <> '01 Jan 1900' then  
	cast(day(IExpected)as varchar)+'/'+cast(month(IExpected)as varchar)+'/'+cast(year(IExpected)as varchar) else '' end  +char('13')+	char('10')+	
case when isnull(IReview, '01 Jan 1900') <> '01 Jan 1900' then  
	cast(day(IReview)as varchar)+'/'+cast(month(IReview)as varchar)+'/'+cast(year(IReview)as varchar) else '' end  'Evaluation Summary',
case when isnull(BOB.I1, '') = '' then 'N/A' else isnull(BOB.I1Time, '') end +char('13')+	char('10')+	
case when isnull(I1Expected, '01 Jan 1900') <> '01 Jan 1900' then  
	cast(day(I1Expected)as varchar)+'/'+cast(month(I1Expected)as varchar)+'/'+cast(year(I1Expected)as varchar) else '' end  +char('13')+	char('10')+	
case when isnull(I1Review, '01 Jan 1900') <> '01 Jan 1900' then  
	cast(day(I1Review)as varchar)+'/'+cast(month(I1Review)as varchar)+'/'+cast(year(I1Review)as varchar) else '' end  'MO Form',
case when isnull(BOB.J, '') = '' then 'N/A' else isnull(BOB.JTime, '') end +char('13')+	char('10')+	
case when isnull(JExpected, '01 Jan 1900') <> '01 Jan 1900' then  
	cast(day(JExpected)as varchar)+'/'+cast(month(JExpected)as varchar)+'/'+cast(year(JExpected)as varchar) else '' end  +char('13')+	char('10')+	
case when isnull(JReview, '01 Jan 1900') <> '01 Jan 1900' then  
	cast(day(JReview)as varchar)+'/'+cast(month(JReview)as varchar)+'/'+cast(year(JReview)as varchar) else '' end  'Finance Rec/ Event Closed',
isnull(EventSponsorship,0) 'Sponsorship Total', isnull(CPDPoints, '') 'CPD Points',
isnull(EventCoordinator,'') 'EventCoordinator', E.Comment 'EventComment', lu2.lookup_full_desc 'EventStatus'
from RSMCRM.RSM_LIVE.dbo.Event E with(nolock) left outer join  
BI_REFERENCE.LU.TDates TD on TD.TDate = E.Start_Date left outer join
RSMCRM.RSM_LIVE.dbo.lookup lu with(nolock)  on lu.lookup_ref = E.Category left outer join
RSMCRM.RSM_LIVE.dbo.lookup lu2 with(nolock) on lu2.lookup_ref = E.status left outer join
	(select S.event_ref, SUM(minimum_delegates) 'BudgetNoDelegates', sum(delegate_count) 'NoDelegates', isnull(NAME, 'Meeting') 'SessionName' 
	from RSMCRM.RSM_LIVE.dbo.session S with(nolock) inner join
	#PickMe PM on PM.PickSession = S.Session_Ref 
	group by S.event_ref, isnull(NAME, 'Meeting') )BD
	on BD.Event_Ref = E.Event_Ref left outer join
(select E.Code 'EventCode', 
	max(case when Attribute_Code = 'EVEC' then A.Detail else '' end) 'EventCoordinator'
	from RSMCRM.RSM_LIVE.dbo.[Event] E with(nolock) inner join
	RSMCRM.RSM_LIVE.dbo.Attribute A with(nolock) on A.event_ref = E.Event_Ref left outer join
	RSMCRM.RSM_LIVE.dbo.lookup AT with(nolock) on AT.lookup_code = A.Attribute_Code
	where attribute_code = 'EVEC'
	group by E.Code)Fred on Fred.EventCode = E.Code left outer join
(select MAX(case when lu.lookup_ref = 3417 then isnull(completed, '') else '' end) 'A',
		MAX(case when lu.lookup_ref = 3418 then isnull(completed, '') else '' end) 'B',
		MAX(case when lu.lookup_ref = 3419 then isnull(completed, '') else '' end) 'B1',
		MAX(case when lu.lookup_ref = 3637 then isnull(completed, '') else '' end) 'C',
		MAX(case when lu.lookup_ref = 3421 then isnull(completed, '') else '' end) 'D',
		MAX(case when lu.lookup_ref = 3422 then isnull(completed, '') else '' end) 'E',
		MAX(case when lu.lookup_ref = 3423 then isnull(completed, '') else '' end) 'E1',	
		MAX(case when lu.lookup_ref = 3424 then isnull(completed, '') else '' end) 'F',
		MAX(case when lu.lookup_ref = 3426 then isnull(completed, '') else '' end) 'G',
		MAX(case when lu.lookup_ref = 3427 then isnull(completed, '') else '' end) 'H',
		MAX(case when lu.lookup_ref = 3428 then isnull(completed, '') else '' end) 'I',
		MAX(case when lu.lookup_ref = 3660 then isnull(completed, '') else '' end) 'I1',
		MAX(case when lu.lookup_ref = 3429 then isnull(completed, '') else '' end) 'J',

		MAX(case when lu.lookup_ref = 3417 then 
			case when isnull(completed, '') = 'N' then 'N' else
			case when isnull(Review_Date,'01 Jan 1900')<=isnull(Expected_Date, '01 Jan 1900') then 'Y' else 'N' end end end) 'ATime',
		MAX(case when lu.lookup_ref = 3418 then 
			case when isnull(completed, '') = 'N' then 'N' else
			case when isnull(Review_Date,'01 Jan 1900')<=isnull(Expected_Date, '01 Jan 1900') then 'Y' else 'N' end end end) 'BTime',
		MAX(case when lu.lookup_ref = 3419 then 
			case when isnull(completed, '') = 'N' then 'N' else
			case when isnull(Review_Date,'01 Jan 1900')<=isnull(Expected_Date, '01 Jan 1900') then 'Y' else 'N' end end end) 'B1time',
		MAX(case when lu.lookup_ref = 3637 then 
			case when isnull(completed, '') = 'N' then 'N' else
			case when isnull(Review_Date,'01 Jan 1900')<=isnull(Expected_Date, '01 Jan 1900') then 'Y' else 'N' end end end) 'Ctime',
		MAX(case when lu.lookup_ref = 3421 then 
			case when isnull(completed, '') = 'N' then 'N' else
			case when isnull(Review_Date,'01 Jan 1900')<=isnull(Expected_Date, '01 Jan 1900') then 'Y' else 'N' end end end) 'DTime',
		MAX(case when lu.lookup_ref = 3422 then 
			case when isnull(completed, '') = 'N' then 'N' else
			case when isnull(Review_Date,'01 Jan 1900')<=isnull(Expected_Date, '01 Jan 1900') then 'Y' else 'N' end end end) 'ETime',
		MAX(case when lu.lookup_ref = 3423 then
			case when isnull(completed, '') = 'N' then 'N' else
			case when isnull(Review_Date,'01 Jan 1900')<=isnull(Expected_Date, '01 Jan 1900') then 'Y' else 'N' end end end) 'E1Time',
		MAX(case when lu.lookup_ref = 3424 then 
			case when isnull(completed, '') = 'N' then 'N' else
			case when isnull(Review_Date,'01 Jan 1900')<=isnull(Expected_Date, '01 Jan 1900') then 'Y' else 'N' end end end) 'FTime',
		MAX(case when lu.lookup_ref = 3426 then
			case when isnull(completed, '') = 'N' then 'N' else
			case when isnull(Review_Date,'01 Jan 1900')<=isnull(Expected_Date, '01 Jan 1900') then 'Y' else 'N' end end end) 'GTime',
		MAX(case when lu.lookup_ref = 3427 then
			case when isnull(completed, '') = 'N' then 'N' else
			case when isnull(Review_Date,'01 Jan 1900')<=isnull(Expected_Date, '01 Jan 1900') then 'Y' else 'N' end end end) 'HTime',
		MAX(case when lu.lookup_ref = 3428 then 
			case when isnull(completed, '') = 'N' then 'N' else
			case when isnull(Review_Date,'01 Jan 1900')<=isnull(Expected_Date, '01 Jan 1900') then 'Y' else 'N' end end end) 'ITime',
		MAX(case when lu.lookup_ref = 3660 then 
			case when isnull(completed, '') = 'N' then 'N' else
			case when isnull(Review_Date,'01 Jan 1900')<=isnull(Expected_Date, '01 Jan 1900') then 'Y' else 'N' end end end) 'I1Time',
		MAX(case when lu.lookup_ref = 3429 then 
			case when isnull(completed, '') = 'N' then 'N' else
			case when isnull(Review_Date,'01 Jan 1900')<=isnull(Expected_Date, '01 Jan 1900') then 'Y' else 'N' end end end) 'JTime',
		

		MAX(case when lu.lookup_ref = 3417 then isnull(Expected_Date, '01 Jan 1900') else '01 Jan 1900' end) 'AExpected',
		MAX(case when lu.lookup_ref = 3418 then isnull(Expected_Date, '01 Jan 1900') else '01 Jan 1900' end) 'BExpected',
		MAX(case when lu.lookup_ref = 3419 then isnull(Expected_Date, '01 Jan 1900') else '01 Jan 1900' end)'B1Expected',
		MAX(case when lu.lookup_ref = 3637 then isnull(Expected_Date, '01 Jan 1900') else '01 Jan 1900' end) 'CExpected',
		MAX(case when lu.lookup_ref = 3421 then isnull(Expected_Date, '01 Jan 1900') else '01 Jan 1900' end) 'DExpected',
		MAX(case when lu.lookup_ref = 3422 then isnull(Expected_Date, '01 Jan 1900') else '01 Jan 1900' end) 'EExpected',
		MAX(case when lu.lookup_ref = 3423 then isnull(Expected_Date, '01 Jan 1900') else '01 Jan 1900' end) 'E1Expected',
		MAX(case when lu.lookup_ref = 3424 then isnull(Expected_Date, '01 Jan 1900') else '01 Jan 1900' end) 'FExpected',
		MAX(case when lu.lookup_ref = 3426 then isnull(Expected_Date, '01 Jan 1900') else '01 Jan 1900' end) 'GExpected',
		MAX(case when lu.lookup_ref = 3427 then isnull(Expected_Date, '01 Jan 1900') else '01 Jan 1900' end) 'HExpected',
		MAX(case when lu.lookup_ref = 3428 then isnull(Expected_Date, '01 Jan 1900') else '01 Jan 1900' end) 'IExpected',
		MAX(case when lu.lookup_ref = 3660 then isnull(Expected_Date, '01 Jan 1900') else '01 Jan 1900' end) 'I1Expected',
		MAX(case when lu.lookup_ref = 3429 then isnull(Expected_Date, '01 Jan 1900') else '01 Jan 1900' end) 'JExpected',

		MAX(case when lu.lookup_ref = 3417 then isnull(Review_Date,'01 Jan 1900') else '01 Jan 1900' end) 'AReview',
		MAX(case when lu.lookup_ref = 3418 then isnull(Review_Date,'01 Jan 1900') else '01 Jan 1900' end) 'BReview',
		MAX(case when lu.lookup_ref = 3419 then isnull(Review_Date,'01 Jan 1900') else '01 Jan 1900' end) 'B1Review',
		MAX(case when lu.lookup_ref = 3637 then isnull(Review_Date,'01 Jan 1900') else '01 Jan 1900' end) 'CReview',
		MAX(case when lu.lookup_ref = 3421 then isnull(Review_Date,'01 Jan 1900') else '01 Jan 1900' end) 'DReview',
		MAX(case when lu.lookup_ref = 3422 then isnull(Review_Date,'01 Jan 1900') else '01 Jan 1900' end) 'EReview',
		MAX(case when lu.lookup_ref = 3423 then isnull(Review_Date,'01 Jan 1900') else '01 Jan 1900' end) 'E1Review',	
		MAX(case when lu.lookup_ref = 3424 then isnull(Review_Date,'01 Jan 1900') else '01 Jan 1900' end) 'FReview',
		MAX(case when lu.lookup_ref = 3426 then isnull(Review_Date,'01 Jan 1900') else '01 Jan 1900' end) 'GReview',
		MAX(case when lu.lookup_ref = 3427 then isnull(Review_Date,'01 Jan 1900') else '01 Jan 1900' end) 'HReview',
		MAX(case when lu.lookup_ref = 3428 then isnull(Review_Date,'01 Jan 1900') else '01 Jan 1900' end) 'IReview',
		MAX(case when lu.lookup_ref = 3660 then isnull(Review_Date,'01 Jan 1900') else '01 Jan 1900' end) 'I1Review',
		MAX(case when lu.lookup_ref = 3429 then isnull(Review_Date,'01 Jan 1900') else '01 Jan 1900' end) 'JReview',
	Event_Ref  
from RSMCRM.RSM_LIVE.dbo.task T with(nolock) inner join
RSMCRM.RSM_LIVE.dbo.lookup lu with(nolock) on lu.lookup_ref = T.type 
GROUP BY Event_Ref)BOB on BOB.Event_Ref = E.Event_Ref left outer join
(select s.event_ref, sum(dbo.Reports_SponsorshipValue(delegate_ref)) 'EventSponsorship'
from RSMCRM.RSM_LIVE.dbo.delegate_session ds with(nolock) inner join
RSMCRM.RSM_LIVE.dbo.session s with(nolock) on s.session_ref = ds.session_ref
where name = 'Sponsorship'
group by s.event_ref)SBob on SBob.event_ref = E.Event_Ref left outer join
(select event_Ref, lookup_full_desc + case when isnull(A.Detail,'') = '' then '' else ' ('+isnull(A.Detail,'')+')' end  'CPDPoints'
from RSMCRM.RSM_LIVE.dbo.Attribute A with(nolock) inner join
RSMCRM.RSM_LIVE.dbo.Lookup lu with(nolock) on lu.lookup_ref = A.attr_code_ref
where lookup_code like '%CPD')CPBob on CPBob.event_ref = E.Event_Ref
WHERE E.Category not in (3333, 1602, 1603, 1604, 1605, 1606, 1607, 1608, 1609, 1610, 2379, 2380, 3465)


--insert into RMLog.Reports_Processing SELECT @@SPID, SYSTEM_USER , USER,'A118', getdate()

GO
