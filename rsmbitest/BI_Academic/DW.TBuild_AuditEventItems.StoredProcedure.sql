USE [BI_Academic]
GO
/****** Object:  StoredProcedure [DW].[TBuild_AuditEventItems]    Script Date: 07/11/2014 15:17:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [DW].[TBuild_AuditEventItems]
as

truncate table DW.Audit_EventItems

Insert INTO DW.Audit_EventItems
--#1	BUILD EVENT ITEMS
SELECT 	EC.Start_Date 'EventDate',
	EventStatus,
	(isnull(ND.NumberOfDelegates,0)) 'DelegateCount', 
	(isnull(ND.NoShow, 0)) 'NoShow', 
	(isnull(ND.BudgetDelegates,0)) 'BudgetDelegates',
	EC.LeadEventCode 'LeadEventCode',
	EC.ChildEventCode 'EventCodeLink',
	EC.DEPName 'Department',
	dbo.Reports_MeetingType(EC.Event_Ref) 'MeetingType', 
	isnull(ProgrammeKPI,'') 'ProgrammeKPI', 
	dbo.Reports_CPDPoints(EC.Event_Ref) 'CPDPoints',
	case when isnull(DW.Fn_JointEventSession(EC.Event_Ref),'N') <> 'N' then DW.Fn_JointEventSession(EC.Event_Ref) else DW.Fn_JointEventExternal(EC.Event_Ref) end 'JointSession',
	MO.MO 'MOForm', 
	substring(ISNULL(EC.CCNO, EC.CCNO), 4,1) 'YearCode',
	Presentation, 
	Usefulness, 
	isnull(Adv.Reason,'') 'AdverseReason', 
	Adverse,
	Relevance, 
	Objectives,
	EC.Event_Ref,
	DW.Fn_EventPublic(EC.Event_Ref) 'PublicInterest' ,
	[DW].[Fn_CountMembersInSection](left(EC.DEPName, 4))
FROM  DW.LeadEventCodes EC left outer join
DW.FA1_DelegateCounts DC with(nolock) on DC.Code = EC.LeadEventCode		left outer join
DW.FA1_DelegateCounts ND with(nolock) on ND.Code =  EC.ChildEventCode left outer join
	(select Event_Ref, 
	case when Completed = 'N' then 'In Progress' else case when Review_Date > Expected_Date then 'No' else 'Yes' end end 'ProgrammeKPI'
	from RSMCRM.RSM_LIVE.dbo.task T 
	where type in (3418, 2800))Jim on Jim.Event_Ref = EC.Event_Ref left outer join
(select Event_Ref, 
	case when Completed = 'N' then 'In Progress' else case when Review_Date > Expected_Date then 'No' else 'Yes' end end 'MO'
	from RSMCRM.RSM_LIVE.dbo.task T 
	where type in (3660))MO on MO.Event_Ref = EC.Event_Ref left outer join
DW.Reports_EvaluationAverages RES on RES.EventID = EC.LeadEventCode left outer join
(select event_ref, Detail 'Reason', 'a' 'Adverse' from RSMCRM.RSM_LIVE.dbo.attribute A where attribute_code = 'FOREM' and isnull(Detail, '') <> '')Adv on Adv.Event_Ref = EC.Event_Ref



update DW.Audit_EventItems
set DelegateCount = ND.NumberOfDelegates, 
	NoShow = ND.NoShow, 
	BudgetDelegates = ND.BudgetDelegates
from  DW.Audit_EventItems EI inner join
DW.LeadEventCodes EC on EC.ChildEventCode = EI.EventCodeLink inner join
DW.FA1_DelegateCounts ND with(nolock) on ND.Code =  EC.LeadEventCode
where childeventcode <> EC.leadeventcode



GO
