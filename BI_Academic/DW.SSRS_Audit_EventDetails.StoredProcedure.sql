USE [BI_Academic]
GO
/****** Object:  StoredProcedure [DW].[SSRS_Audit_EventDetails]    Script Date: 07/11/2014 15:17:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [DW].[SSRS_Audit_EventDetails]

@DepartmentCode as varchar(4),
@YearCode as varchar(1),
@FY as int,
@FP as int
as

select	YearCode, left(Department, 4) 'DepartmentCode',
		EI.EventCodeLink, MeetingType, EventStatus, DelegateCount, BudgetDelegates,
		case when ProgrammeKPI = 'Yes' then 'a' else 
			case when ProgrammeKPI = 'No' then 'r' else '' end end 'ProgrammeKPI',
		case when JointSession = 'Y' then 'a' else '' end 'JointSession',
		isnull(CPDPoints, '') 'CPDPoints', 
		case when PublicInterest = 'Y' then 'a' else 'r' end 'PublicInterest',
		isnull(Presentation, 0) 'Presentation',
		isnull(usefulness, 0) 'Usefulness',
		isnull(Relevance, 0) 'Relevance',
		isnull(Objectives, 0) 'Objectives',
		case when EventStatus = 'Cancelled' then '' else
			case when ProgrammeKPI = '' then '' else
				case when MOForm = 'Yes' then 'a' else 
					case when MOForm = 'No' then 'r' else 'r' end end end end 'MOForm', 
		Bob.Actual, Bob.ActualSponsor, Fred.Budget, Fred.BudgetSponsor, 
		case when EI.EventCodeLink like '%99' then 1 else 0 end 'AdminOnly',
		case when isnull(EEM.EventCode, '') = '' then ' ' else 'n' end 'ExternallyManaged'
from DW.Audit_EventItems EI left outer join
			(select ChildEventCode, sum(isnull(ActualAmount, 0)) 'Actual', sum(isnull(ActualSponsor, 0)) 'ActualSponsor'--select *
			from [DW].[Audit_FinancialActuals] FA 
			where FA.NLYear < @FY or (FA.NLYear = @FY and FA.NLPeriod <= @FP)
			group by ChildEventCode)Bob on Bob.ChildEventCode = EI.EventCodeLink left outer join
					(select EventCodeLink, sum(isnull(Budget, 0)) 'Budget', sum(isnull(BudgetSponsor, 0)) 'BudgetSponsor'
					from [DW].[Audit_Budgets] FB
					group by EventCodeLink)Fred on Fred.EventCodeLink = EI.EventCodeLink left outer join
	DW.EventsExternallyManaged EEM on EEM.Event_ref = EI.Event_Ref
where left(Department, 4) = @DepartmentCode and YearCode = @YearCode
		--and EventStatus <> 'Abandoned'

GO
