USE [BI_Academic]
GO
/****** Object:  StoredProcedure [DW].[TBuild_FA1_DelegateCounts]    Script Date: 07/11/2014 15:17:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE proc [DW].[TBuild_FA1_DelegateCounts]
as

--declare
--@EventCode as varchar(20)

--set @EventCode = 'EVC01'

truncate table DW.FA1_DelegateCounts

insert into DW.FA1_DelegateCounts
--LCS 20130425	REMOVED BOOKING ALLOW FLAG AS THIS IS NOW BEING USED FOR THE NEW ONLINE BOOKING 
select  Code, sum(case when status = 1916 then NO_DELEGATES else 0 end) as NumberOfDelegates,
	sum(case when status = 1919 then NO_DELEGATES else 0 end) as NoShow, sum(no_delegates) 'AllDelegates',
	max(isnull(Delegate, 0)) 'BudgetDelegates'
from (
    select e.code, d.no_delegates, dn.name 'DelegateName', dn.status, db.delegate, s.session_ref, e.event_ref
	from RSMCRM.RSM_Live.dbo.delegate_session d  inner join 
	RSMCRM.RSM_Live.dbo.Session s on d.Session_Ref = s.Session_Ref inner join 
	RSMCRM.RSM_Live.dbo.Event e on s.Event_Ref = e.Event_Ref inner join 
	RSMCRM.RSM_Live.dbo.Event_Rate r on d.Event_Rate_Ref = r.Event_Rate_Ref inner join
	RSMCRM.RSM_Live.dbo.delegate dn on dn.delegate_ref = D.delegate_ref inner join
	RSMCRM.RSM_Live.dbo.lookup lu on lu.lookup_ref = dn.status inner join
	RSMCRM.RSM_Live.dbo.individual i on i.individual_ref = dn.individual_ref left outer join
	RSMCRM.RSM_Live.dbo.lookup lu2 on lu2.lookup_ref = Dn.type left outer join
	RSMCRM.RSM_Live.dbo.member m on m.individual_ref = i.individual_ref left outer join
	RSMCRM.RSM_Live.dbo.FACT_EventBudgetDelegates DB on DB.EventCode = e.Code
	where s.name not like 'meeting -%' 
union 
select substring(s.name,11,5), d.no_delegates, dn.name 'DelegateName', dn.status, db.delegate, s.session_ref, e.event_ref
	from RSMCRM.RSM_Live.dbo.delegate_session d  inner join 
	RSMCRM.RSM_Live.dbo.Session s on d.Session_Ref = s.Session_Ref inner join 
	RSMCRM.RSM_Live.dbo.Event e on s.Event_Ref = e.Event_Ref inner join 
	RSMCRM.RSM_Live.dbo.Event_Rate r on d.Event_Rate_Ref = r.Event_Rate_Ref inner join
	RSMCRM.RSM_Live.dbo.delegate dn on dn.delegate_ref = D.delegate_ref inner join
	RSMCRM.RSM_Live.dbo.lookup lu on lu.lookup_ref = dn.status inner join
	RSMCRM.RSM_Live.dbo.individual i on i.individual_ref = dn.individual_ref left outer join
	RSMCRM.RSM_Live.dbo.lookup lu2 on lu2.lookup_ref = Dn.type left outer join
	RSMCRM.RSM_Live.dbo.member m on m.individual_ref = i.individual_ref left outer join
	RSMCRM.RSM_Live.dbo.FACT_EventBudgetDelegates DB on DB.EventCode = substring(s.name,11,5)
	where s.name like 'meeting -%' 
union 
select E.code, d.no_delegates, dn.name 'DelegateName', dn.status, db.delegate, s.session_ref, e.event_ref
	from RSMCRM.RSM_Live.dbo.delegate_session d  inner join 
	RSMCRM.RSM_Live.dbo.Session s on d.Session_Ref = s.Session_Ref inner join 
	RSMCRM.RSM_Live.dbo.Event e on s.Event_Ref = e.Event_Ref inner join 
	RSMCRM.RSM_Live.dbo.Event_Rate r on d.Event_Rate_Ref = r.Event_Rate_Ref inner join
	RSMCRM.RSM_Live.dbo.delegate dn on dn.delegate_ref = D.delegate_ref inner join
	RSMCRM.RSM_Live.dbo.lookup lu on lu.lookup_ref = dn.status inner join
	RSMCRM.RSM_Live.dbo.individual i on i.individual_ref = dn.individual_ref left outer join
	RSMCRM.RSM_Live.dbo.lookup lu2 on lu2.lookup_ref = Dn.type left outer join
	RSMCRM.RSM_Live.dbo.member m on m.individual_ref = i.individual_ref left outer join
	RSMCRM.RSM_Live.dbo.FACT_EventBudgetDelegates DB on DB.EventCode = substring(s.name,11,5)
	where s.name like 'meeting -%' 
)bob  inner join 
		(
		select Event_Ref, 
				case when zeroth <>0 then zeroth else
					case when first <> 0 then first else 
						case when second <> 0 then second else 
							case when third <> 0 then third else 'Meeting' end end end end 'PickSession', Final
		from (
		select	S.Event_Ref, 
				MAX(case when category = 3684 then session_ref else 0 end) 'zeroth',
				MAX(case when NoSessions = 1 then session_ref else	0 end) 'first',
				MAX(case when name like 'Meeting%' then Session_Ref else 0 end) 'Second',
				MAX(case when firstSession is not null then S.Session_Ref else 0 end) 'Third',
				Max(Session_Ref) 'Final'
		from RSMCRM.RSM_Live.dbo.session S inner join
		RSMCRM.RSM_Live.dbo.lookup lu on lu.lookup_ref = S.venue_status  inner join
		(select event_ref, count(*) 'NoSessions'
		from RSMCRM.RSM_Live.dbo.session  SNo inner join
		RSMCRM.RSM_Live.dbo.lookup lu on lu.lookup_ref = SNo.venue_status
		where lookup_full_desc <> 'Template'
		--where allow_bookings = 'Y'
		group by event_ref)NS on NS.event_Ref = S.Event_Ref left outer join
		(select event_Ref, min(SNT.create_timestamp) 'FirstSession'
		from RSMCRM.RSM_Live.dbo.session SNT  inner join
		RSMCRM.RSM_Live.dbo.lookup lu on lu.lookup_ref = SNT.venue_status
		where lookup_full_desc <> 'Template'
		--where allow_bookings = 'Y'
		group by event_ref)FS on FS.event_Ref = S.Event_Ref
							and FS.FirstSession = S.create_timestamp
		--where allow_bookings = 'Y'
				and case when NoSessions = 1 then session_ref else	
						case when name like 'Meeting%' then Session_Ref else
							case when firstSession is not null then S.Session_Ref else 0 end end end <> 0
		where  lookup_full_desc <> 'Template'
		group by S.Event_Ref
		)sam 
) PM on PM.PickSession = bob.session_ref
--where  Code = @EventCode 
group by bob.code
 

GO
