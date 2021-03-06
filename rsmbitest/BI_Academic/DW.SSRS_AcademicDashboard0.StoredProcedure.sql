USE [BI_Academic]
GO
/****** Object:  StoredProcedure [DW].[SSRS_AcademicDashboard0]    Script Date: 07/11/2014 15:17:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE proc [DW].[SSRS_AcademicDashboard0]
as

select ED.LeadEventCode, FinancialYear, FinancialPeriod, 
		case when EventStatus in ('Closed','Active') then 'Run' else 
				case when EventStatus = 'Cancelled' then 'Cancelled' else 'Abandoned' end end 'EventStatus',
		case when left(Department, 2) in ('06') then 1 else 0 end 'SectionMeeting',
		case when left(Department, 2) in ('06','05', '03') then 1 else 
			case when left(Department, 4) in ('25MM','25PE', '27RP') then 1 else 0 end end 'AcademicMeeting',
		case when left(Department, 2) in ('06', '29','28','13', '05', '03', '01') then 1 else
			case when left(Department, 4) in ('25MM','25PE', '27RP', '29GH') then 1 else 0 end end 'RSMMeeting',
		case when left(Department, 4) in ('25MM', '25PE') then 1 else 0 end 'PEMeetings',
		case when left(Department, 4) in ('27RP') then 1 else 0 end 'RSMProfessionals',
		DelegateCount, 
		case when isnumeric(cpdpoints) = 1 then cast(cpdpoints as float) else 0.0 end 'CPDPoints',
		case when isnumeric(cpdpoints) = 1 then 1 else 0 end 'CPDMeeting',
		isnull(L.LocationGroup, 'London') 'MeetingLocation'
from [DW].[Audit_EventItems] ED inner join
BI_Reference.LU.TDates TD on TD.TDate = ED.EventDate left outer join
DW.Reports_RegionalMeetingLocation L on L.Event_Ref = ED.Event_Ref
where EventStatus in ('Closed','Active', 'Cancelled', 'Abandoned')
		and TD.FinancialYear <= case when month(getdate())>=10 then year(getdate())+1 else year(getdate()) end





GO
