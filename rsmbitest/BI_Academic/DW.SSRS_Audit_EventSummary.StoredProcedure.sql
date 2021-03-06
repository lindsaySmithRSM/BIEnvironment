USE [BI_Academic]
GO
/****** Object:  StoredProcedure [DW].[SSRS_Audit_EventSummary]    Script Date: 07/11/2014 15:17:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [DW].[SSRS_Audit_EventSummary]
--declare
--@DepartmentCode as varchar(4),
@YearCode as varchar(1),
@FY as int,
@FP as int
as


--set @YearCode = 'F'
--set @FY = 2015
--set @FP = 12

select	SectionMembers'MembersInSection',
		YearCode, left(Department, 4) 'DepartmentCode', Department,
		--EI.EventCodeLink, MeetingType, EventStatus, 
		sum(Bob.Actual) 'Actual', 
		sum(Fred.Budget) 'Budget', 
		sum(Bob.ActualSponsor) 'ActualSponsor', 
		sum(Fred.BudgetSponsor) 'BudgetSponsor',
		sum(case when EI.EventCodeLink like '%99' then 0 else 1 end) 'NoPlannedMeetings', 
		sum(case when eventstatus ='Abandoned' then 1 else 0 end) 'MeetingsAbandoned',
		sum(case when EI.MeetingType = 'Day' then 1 else 0 end) 'DayMeetings',
		sum(case when EI.MeetingType = 'Half Day' then 1 else 
				case when EI.MeetingType = 'Morning' then 1 else 0 end end) 'HalfDayMeetings',
		sum(case when EI.MeetingType = 'Evening' then 1 else 0 end) 'EveningMeetings',
		sum(case when EI.MeetingType in ('Day', 'Half Day','Evening', 'Morning') then 0 else
				case when EI.EventCodeLink like '%99' then 0 else 1 end end) 'LongerMeetings',
		sum(case when eventstatus in ('Cancelled', 'Postponed', 'Abandoned') then 0 else
				case when eventdate >= getdate() then 0 else
					case when EI.EventCodeLink like '%99' then 0 else 1 end end end) 'MeetingsRun',
		case when cast(sum(case when EI.EventCodeLink like '%99' then 0 else 1 end) as float) = 0 then 0 else
		cast(sum(case when eventstatus in ('Cancelled', 'Postponed', 'Abandoned') then 0 else
				case when eventdate >= getdate() then 0 else
					case when EI.EventCodeLink like '%99' then 0 else 1 end end end) as float)/
			cast(sum(case when EI.EventCodeLink like '%99' then 0 else 1 end) as float) end 'Perc_Run',

		sum(case when eventstatus in ('Cancelled') then 1 else 0 end) 'Cancelled',
		
		case when cast(sum(case when EI.EventCodeLink like '%99' then 0 else 1 end) as float)=0 then 0 else
		cast(sum(case when eventstatus in ('Cancelled') then 1 else 0 end) as float)/
			cast(sum(case when EI.EventCodeLink like '%99' then 0 else 1 end) as float) end 'Perc_Cancelled',
		sum(DelegateCount) 'Delegates', 
		sum(BudgetDelegates) 'BudgetDelegates',
		case when cast(sum(case when eventstatus in ('Cancelled', 'Postponed', 'Abandoned') then 0 else
				case when eventdate >= getdate() then 0 else
					case when EI.EventCodeLink like '%99' then 0 else 1 end end end) as float) = 0 then 0 else
		cast(sum(DelegateCount) as float)/
			cast(sum(case when eventstatus in ('Cancelled', 'Postponed', 'Abandoned') then 0 else
				case when eventdate >= getdate() then 0 else
					case when EI.EventCodeLink like '%99' then 0 else 1 end end end) as float) end 'AvgDelegatesperMeeting',
		sum(case when JointSession = 'Y' then 1 else 0 end) 'NoJointMeetings',
		sum(case when isnumeric(cpdpoints) = 1 then 1 else 0 end) 'CPDAccredited',
		sum(case when isnumeric(cpdpoints) = 1 then cast(cpdpoints as float) else 0.0 end) 'CPDPoints',
		sum(case when publicinterest = 'Y' then 1 else 0 end) 'PublicInterest',
		case when sum(isnull(Presentation, 0))=0 then 0 else 
						sum(isnull(presentation, 0)) /sum(case when isnull(Presentation, 0)=0 then 0 else 1 end) end'Presentation',
		case when sum(isnull(usefulness, 0))=0 then 0 else 
		sum(isnull(usefulness, 0))/sum(case when isnull(usefulness, 0)=0 then 0 else 1 end) end 'Usefulness',
		case when sum(isnull(Relevance, 0))=0 then 0 else 
		sum(isnull(Relevance, 0)) /sum(case when isnull(Relevance, 0)=0 then 0 else 1 end) end 'Relevance',
		case when sum(isnull(Objectives, 0))=0 then 0 else 
		sum(isnull(Objectives, 0))/sum(case when isnull(Objectives, 0)=0 then 0 else 1 end) end 'Objectives'

from DW.Audit_EventItems EI left outer join
			(select ChildEventCode, sum(isnull(ActualAmount, 0)) 'Actual', sum(isnull(ActualSponsor, 0)) 'ActualSponsor'--select *
			from [DW].[Audit_FinancialActuals] FA 
			where FA.NLYear < @FY or (FA.NLYear = @FY and FA.NLPeriod <= @FP)
			group by ChildEventCode)Bob on Bob.ChildEventCode = EI.EventCodeLink left outer join
					(select EventCodeLink, sum(isnull(Budget, 0)) 'Budget', sum(isnull(BudgetSponsor, 0)) 'BudgetSponsor'
					from [DW].[Audit_Budgets] FB
					group by EventCodeLink)Fred on Fred.EventCodeLink = EI.EventCodeLink
where YearCode = @YearCode and left(Department, 2) in ('03','05','06','25','27','28','29')
		--and EventStatus <> 'Abandoned'
group by YearCode, left(Department, 4), Department, SectionMembers

GO
