USE [BI_Academic]
GO
/****** Object:  StoredProcedure [DW].[SSPP_SpecialtyEvents]    Script Date: 07/11/2014 15:17:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create proc [DW].[SSPP_SpecialtyEvents]
as
select distinct E.Code, E.Name, E.Start_date, Lu.lookup_full_desc, 
		T.FinancialYear, T.FinancialPeriod, T.MonthName, MonthStartDate, MonthEndDate 
from RSMCRM.RSM_Live.dbo.Attribute A inner join
RSMCRM.RSM_Live.dbo.lookup Lu on Lu.lookup_code = A.Attribute_code inner join
RSMCRM.RSM_Live.dbo.Event E on E.Event_Ref = A.Event_Ref inner join
BI_Reference.LU.TDates T on T.TDate = E.Start_date
where code_type = 249 and A.event_ref is not null
	and A.valid_to is null  and lookup_type_ref = 249
	

GO
