USE [BI_Academic]
GO
/****** Object:  StoredProcedure [DW].[TBuild_AuditBudgets]    Script Date: 07/11/2014 15:17:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [DW].[TBuild_AuditBudgets]
as


TRUNCATE TABLE DW.Audit_Budgets

INSERT into DW.Audit_Budgets
select EventCodeLink, sum(Budget) 'Budget', sum(BudgetSponsor) 'BudgetSponsor'
from 
(
--BUDGET TRANSACTIONS
--TRANSFERRED JOINT SESSIONS
select 	cast(Budget as float)*cast(Ratio as float) 'Budget',
		BudgetSponsor*Ratio 'BudgetSponsor',
		EC.ChildEventCode 'EventCodeLink',
		EC.Event_Ref
from DW.LeadEventCodes EC inner join
(
select Department, CostCentre, Event_Ref,
	sum(cast(CASE WHEN SUBSTRING(AccountCode, 4, 3) IN ('000', '001', '002') THEN Budget else Budget*-1 end as float)) 'Budget', 
	sum(cast(CASE WHEN SUBSTRING(AccountCode, 4, 3) IN ('000') THEN Budget else 0 end as float)) 'BudgetSponsor'
from  DW.LeadEventCodes LE inner join
DataMart_Budgets.dbo.FACT_EventBudgets EB on right(EB.Department,2)+right(EB.CostCentre,3) = LE.LeadEventCode
where main = 1
group by Department, CostCentre, Event_Ref
)Bob on EC.Event_Ref = Bob.Event_Ref inner join
	(select Event_Ref, Lookup_Code, cast(Detail as float)/100 'Ratio'
	from RSMCRM.RSM_LIVE.dbo.attribute A inner join
	RSMCRM.RSM_LIVE.dbo.lookup_type lt on lt.lookup_type_Ref = Code_type inner join
	RSMCRM.RSM_LIVE.dbo.lookup lu on lu.lookup_ref = attr_code_ref 
	where lookup_type_code = 'JOITMS' and isnumeric(detail) = 1)Rat on Rat.Event_Ref = Bob.Event_Ref left outer join
RSMCRM.RSM_LIVE.ACOCMP1.CCENTRES C2 with(nolock) on C2.CCNO = EC.CCNO 
where Lookup_Code = EC.DEPTNO and isnumeric(right(C2.CCNAME, 2))=1

union all
--LEAD EVENT CODES BUDGET ONLY
select 	(cast(CASE WHEN SUBSTRING(AccountCode, 4, 3) IN ('000', '001', '002') THEN Budget else Budget*-1 end as float)) 'Budget',
		(cast(CASE WHEN SUBSTRING(AccountCode, 4, 3) IN ('000') THEN Budget else 0 end as float)) 'BudgetSponsor',
		EC.ChildEventCode 'EventCodeLink',
		EC.Event_Ref
from  DW.LeadEventCodes EC inner join
DataMart_Budgets.dbo.FACT_EventBudgets EB on right(EB.Department,2)+right(EB.CostCentre,3) = EC.ChildEventCode  left outer join
RSMCRM.RSM_LIVE.ACOCMP1.CCENTRES C2 with(nolock) on C2.CCNO = EC.CCNO 
where main = 1 and isnumeric(right(C2.CCNAME, 2))=1
union all
--DEDUCT LEAD WHERE JOINT MEETING
select 	cast(Budget as float)*cast(Ratio as float)*-1 'Budget',
		0 'BudgetSponsor',
		EC.ChildEventCode 'EventCodeLink',
		EC.Event_Ref
from 
DW.LeadEventCodes EC inner join
(
select Department, CostCentre, Event_Ref,
	(cast(CASE WHEN SUBSTRING(AccountCode, 4, 3) IN ('000', '001', '002') THEN Budget else Budget*-1 end as float)) 'Budget' --select *
from  DW.LeadEventCodes LE inner join
DataMart_Budgets.dbo.FACT_EventBudgets EB on right(EB.Department,2)+right(EB.CostCentre,3) = LE.LeadEventCode
where main = 1
)Bob on EC.Event_Ref = Bob.Event_Ref inner join
	(select Event_Ref, Lookup_Code, cast(Detail as float)/100 'Ratio'
	from RSMCRM.RSM_LIVE.dbo.attribute A inner join
	RSMCRM.RSM_LIVE.dbo.lookup_type lt on lt.lookup_type_Ref = Code_type inner join
	RSMCRM.RSM_LIVE.dbo.lookup lu on lu.lookup_ref = attr_code_ref 
	where lookup_type_code = 'JOITMS' and isnumeric(detail) = 1)Rat on Rat.Event_Ref = Bob.Event_Ref left outer join
RSMCRM.RSM_LIVE.ACOCMP1.CCENTRES C2 with(nolock) on C2.CCNO = EC.CCNO 
where Lookup_Code <> EC.DEPTNO and isnumeric(right(C2.CCNAME, 2))=1
)bob
group by EventCodeLink
GO
