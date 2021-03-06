USE [BI_Academic]
GO
/****** Object:  StoredProcedure [DW].[SSRS_EventEvaluationSummary]    Script Date: 07/11/2014 15:17:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [DW].[SSRS_EventEvaluationSummary]
as

select	left(Department, 4) 'DepartmentCode', Department, yearcode,
		EI.EventDate, EI.EventCodeLink, EventStatus, 
		case when EI.EventDate <= dateadd(dd, -7, getdate()) then 'Completed' else 'Incomplete' end 'EvaluationStatus',
		case when sum(isnull(Presentation, 0))=0 then 0 else 
			sum(isnull(presentation, 0)) /sum(case when isnull(Presentation, 0)=0 then 0 else 1 end) end'Presentation',
		case when sum(isnull(usefulness, 0))=0 then 0 else 
			sum(isnull(usefulness, 0))/sum(case when isnull(usefulness, 0)=0 then 0 else 1 end) end 'Usefulness',
		case when sum(isnull(Relevance, 0))=0 then 0 else 
			sum(isnull(Relevance, 0)) /sum(case when isnull(Relevance, 0)=0 then 0 else 1 end) end 'Relevance',
		case when sum(isnull(Objectives, 0))=0 then 0 else 
			sum(isnull(Objectives, 0))/sum(case when isnull(Objectives, 0)=0 then 0 else 1 end) end 'Objectives'
from DW.Audit_EventItems EI 
where left(Department, 2) in ('03','05','06','25','27','28','29') and yearcode not in ('A','B')
		AND EventStatus <> 'Cancelled' and EventStatus <> 'Abandoned'
		and EI.EventCodeLink not like '%99'
group by YearCode, left(Department, 4), Department, EI.EventCodeLink, MeetingType, EventStatus, EI.EventDate


GO
