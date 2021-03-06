USE [BI_Academic]
GO
/****** Object:  StoredProcedure [DW].[MembersEventAttendance]    Script Date: 07/11/2014 15:17:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [DW].[MembersEventAttendance]
as
declare
			@EventStartDate as datetime,
			@EventEndDate as datetime

set	@EventStartDate ='01 Oct 2011'
set	@EventEndDate  =  getdate() --'30 Sep 2012'



select  distinct M.Member_Ref 'MemberRef', --e.code,
		case when M.Membership_no is null then 'Non-Member' else 
			case when isnull(M.Leave_Date, getdate()+1) <= getdate()  then 'Ex-Member' else 'Member' end end 'MemberStatus',
		case when month(E.Start_Date)>= 10  then year(E.Start_Date)+1 else year(E.Start_Date) end 'FinancialYear',
		isnull(ll.lookup_full_desc, 'Non-Delegate') 'DelegateType',
		sum(case when E.Code is null then 0 else 1 end) 'NoEvents',
		sum(case when E.Code is null then 0 else
				case when isnull(e.start_date, getdate()) between M.Join_Date and isnull(M.Leave_Date, getdate()+365) then 1 else 0 end end) 'NoEventsAsMember'
		--isnull(E.DeptNo, '') 'Department'
from RSMCRM.RSM_LIVE.dbo.DELEGATE d with(nolock) right outer join 
RSMCRM.RSM_LIVE.dbo.DELEGATE_SESSION ds with(nolock) on ds.DELEGATE_REF = d.DELEGATE_REF right outer join 
RSMCRM.RSM_LIVE.dbo.SESSION s with(nolock) on ds.SESSION_REF = s.SESSION_REF right outer join
RSMCRM.RSM_LIVE.dbo.EVENT e with(nolock)  on s.EVENT_REF = e.EVENT_REF right outer join
RSMCRM.RSM_LIVE.dbo.Member M with(nolock) on M.individual_ref = d.individual_ref left outer join 
RSMCRM.RSM_LIVE.dbo.lookup lu with(nolock) on d.Status = lu.Lookup_ref  left outer join 
RSMCRM.RSM_LIVE.dbo.lookup ll with(nolock) on  d.type = ll.Lookup_ref left outer join
RSMCRM.RSM_LIVE.dbo.lookup lll with (nolock) on lll.lookup_ref = M.member_status  inner join
RSMCRM.RSM_LIVE.dbo.Individual I on I.Individual_Ref = M.Individual_Ref left outer join
RSMCRM.RSM_LIVE.dbo.lookup EC with (nolock) on EC.lookup_ref = e.category left outer join
RSMCRM.RSM_LIVE.dbo.lookup ES with (nolock) on ES.lookup_ref = e.status inner join 
		(select Event_Ref, 
				case when first <> 0 then first else 
					case when second <> 0 then second else 
						case when third <> 0 then third else 'Meeting' end end end 'PickSession'
		from (
		select	S.Event_Ref, 
				MAX(case when NoSessions = 1 then session_ref else	0 end) 'first',
				MAX(case when name like 'Meeting%' then Session_Ref else 0 end) 'Second',
				MAX(case when firstSession is not null then S.Session_Ref else 0 end) 'Third'
		from RSMCRM.RSM_LIVE.dbo.session S inner join
		(select event_ref, count(*) 'NoSessions'
		from RSMCRM.RSM_LIVE.dbo.session
		--where allow_bookings = 'Y'
		group by event_ref)NS on NS.event_Ref = S.Event_Ref left outer join
		(select event_Ref, min(create_timestamp) 'FirstSession'
		from RSMCRM.RSM_LIVE.dbo.session
		--where allow_bookings = 'Y'
		group by event_ref)FS on FS.event_Ref = S.Event_Ref
							and FS.FirstSession = S.create_timestamp
		--where allow_bookings = 'Y'
				and case when NoSessions = 1 then session_ref else	
						case when name like 'Meeting%' then Session_Ref else
							case when firstSession is not null then S.Session_Ref else 0 end end end <> 0
		group by S.Event_Ref
		)sam
) PM on PM.PickSession = s.session_ref
where	--LINE EDITIED OUT DUE TO SPEC CHANGE ADDED NO EVENTS AS MEMBER FIELD TO COMPENSATE
		--isnull(e.start_date, getdate()) between M.Join_Date and isnull(M.Leave_Date, getdate()+365)
		--isnull(ll.lookup_full_desc, 'delegate') = 'delegate' and 
		isnull(lu.lookup_full_desc, 'booked') = 'Booked'
		and isnull(e.start_date, @EventStartDate+1) between @EventStartDate and @EventEndDate
		and isnull(EC.lookup_full_desc, '') not in ('Academic Council', 'Academic General codes', 'BASHH', 'Executive', 'IT', 'Library', 'Membership', 'RSM Press', 'Support Services','Template')
		and isnull(ES.lookup_full_desc, 'Active') in ('Active', 'Closed')
group by M.Member_Ref,
		case when M.Membership_no is null then 'Non-Member' else 
			case when isnull(M.Leave_Date, getdate()+1) <= getdate()  then 'Ex-Member' else 'Member' end end,
		isnull(ll.lookup_full_desc, 'Non-Delegate')--, isnull(E.DeptNo, '')
		,case when month(E.Start_Date)>= 10  then year(E.Start_Date)+1 else year(E.Start_Date) end 


GO
