USE [BI_Academic]
GO
/****** Object:  StoredProcedure [DW].[A118_MeetingTasks]    Script Date: 07/11/2014 15:17:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE proc [DW].[A118_MeetingTasks]

--declare
	@EventYear as varchar(1)
as

set @EventYear = 'E'

select substring([Event Code],3,1) 'EventYear', [Session Name], [Event Code], [Event Name], [Event Date], [Budget Delegate Nos], [Delegate Nos],
		[Programme Received], [Budget Approved], [Joint Contract Signed], [CPD Applied For], [Publicity Started], [Publicity/ Low Nos],
		[Low Nos/Remedial action], [Speaker Letters], [Send C&C Form (incl web lectures)], [Final nos and Check BEO],
		[Evaluation Summary], [MO Form], [Finance Rec/ Event Closed], [Sponsorship Total], [CPD Points], EventCoordinator, eventstatus,
		
		 case when LEFT([Programme Received],3)='N/A' then 0 else 1 end +
		 case when LEFT([Budget Approved],3)='N/A' then 0 else 1 end +
		 case when LEFT([Joint Contract Signed],3)='N/A' then 0 else 1 end +
		 case when LEFT([CPD Applied For],3)='N/A' then 0 else 1 end +
		 case when LEFT([Publicity Started],3)='N/A' then 0 else 1 end +
		 case when LEFT([Publicity/ Low Nos],3)='N/A' then 0 else 1 end +
		 case when LEFT([Low Nos/Remedial action],3)='N/A' then 0 else 1 end +
		 case when LEFT([Speaker Letters],3)='N/A' then 0 else 1 end +
		 case when LEFT([Send C&C Form (incl web lectures)],3)='N/A' then 0 else 1 end +
		 case when LEFT([Final nos and Check BEO],3)='N/A' then 0 else 1 end +
		 case when LEFT([Evaluation Summary],3)='N/A' then 0 else 1 end +
		 case when LEFT([MO Form],3)='N/A' then 0 else 1 end +
		 case when LEFT([Finance Rec/ Event Closed],3)='N/A' then 0 else 1 end 'KPI Set',

		 case when LEFT([Programme Received],1)='Y' then 1 else 0 end +
		 case when LEFT([Budget Approved],1)='Y' then 1 else 0 end +
		 case when LEFT([Joint Contract Signed],1)='Y' then 1 else 0 end +
		 case when LEFT([CPD Applied For],1)='Y' then 1 else 0 end +
		 case when LEFT([Publicity Started],1)='Y' then 1 else 0 end +
		 case when LEFT([Publicity/ Low Nos],1)='Y' then 1 else 0 end +
		 case when LEFT([Low Nos/Remedial action],1)='Y' then 1 else 0 end +
		 case when LEFT([Speaker Letters],1)='Y' then 1 else 0 end +
		 case when LEFT([Send C&C Form (incl web lectures)],1)='Y' then 1 else 0 end + 
		 case when LEFT([Final nos and Check BEO],1)='Y' then 1 else 0 end + 
		 case when LEFT([Evaluation Summary],1)='Y' then 1 else 0 end + 
		 case when LEFT([MO Form],1)='Y' then 1 else 0 end + 
		 case when LEFT([Finance Rec/ Event Closed],1)='Y' then 1 else 0 end 'KPI Met',

		 T.FinancialYear 'Academic Year',

		 case when LEFT([Event Code],2) = 'PE' then '25PE' else 
			case when LEFT([Event Code],2)='MM' then '25MM' else 
				case when LEFT([Event Code],2)='EV' then '03EV' else 
					case when LEFT([Event Code],2)='EX' then '03EX' else '06'+LEFT([Event Code],2) end end end end 'Section'

from DW.MeetingTasks MT inner join
BI_Reference.LU.TDates T on T.TDate = MT.[Event Date]
where len([Event Code])< 6 and substring([Event Code],3,1) =  @EventYear


GO
