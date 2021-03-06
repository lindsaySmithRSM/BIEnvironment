USE [BI_Academic]
GO
/****** Object:  StoredProcedure [DW].[Build_EventDetails]    Script Date: 07/11/2014 15:17:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [DW].[Build_EventDetails]

as

truncate table DW.EventDetails

insert into DW.EventDetails
select	isnull(m.Member_Ref, '') 'MemberRef', e.Event_ref 'EventRef', e.[Code] 'EventCode',	 
		e.[Name] 'EventName', e.Start_Date 'EventDate',
		isnull(er.Net_Value, 0) 'EventRevenue', DelType.lookup_Full_Desc 'DelegateType', dep.DepName 'HostSection',
		dep.DepNo
from RSMCRM.RSM_LIVE.dbo.[Event] e with(nolock) left outer join 
RSMCRM.RSM_LIVE.dbo.Session s with(nolock) on e.Event_Ref = s.Event_Ref left outer join 
RSMCRM.RSM_LIVE.dbo.Delegate_Session ds with(nolock) on s.Session_Ref = ds.Session_Ref left outer join 
RSMCRM.RSM_LIVE.dbo.Delegate d with(nolock) on ds.Delegate_Ref = d.Delegate_Ref left outer join
RSMCRM.RSM_LIVE.dbo.Lookup DelType with(nolock) on DelType.lookup_ref = d.[Type]  left outer join 
RSMCRM.RSM_LIVE.dbo.Individual i with(nolock) on i.Individual_Ref = d.Individual_Ref left outer join 
RSMCRM.RSM_LIVE.dbo.Event_Rate er with(nolock) on ds.Event_Rate_Ref = er.Event_Rate_Ref left outer join 
RSMCRM.RSM_LIVE.ACOCMP1.Departmt dep with(nolock) on dep.DepNo = e.DeptNo left outer join 
RSMCRM.RSM_LIVE.dbo.Member m with(nolock) on m.Individual_Ref = i.Individual_Ref 
where isnull(d.status, 1916) = 1916



truncate table DW.EventSummary

insert into DW.EventSummary
select dep.DepName 'HostSection', dep.DepNo 'DepNo',
		E.Name 'EventName', E.Start_date 'EventDate', E.Code 'EventCode', 
		E.Event_Ref 'EventRef'
from RSMCRM.RSM_LIVE.dbo.[Event] e with(nolock) inner join
RSMCRM.RSM_LIVE.ACOCMP1.Departmt dep with(nolock) on dep.DepNo = e.DeptNo 

GO
