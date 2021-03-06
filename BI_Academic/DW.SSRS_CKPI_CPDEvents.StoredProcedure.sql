USE [BI_Academic]
GO
/****** Object:  StoredProcedure [DW].[SSRS_CKPI_CPDEvents]    Script Date: 07/11/2014 15:17:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [DW].[SSRS_CKPI_CPDEvents]
as

select EventCode, cast(CPDPoints as float) 'CPDPoints', --ED.EventDate, 
		case when month(ED.EventDate) >= 10 then year(ED.EventDate )+1 else year(ED.EventDate) end 'FinancialYear',
		count(MemberRef) 'NoDelegates'
from DW.CPDEvents CPD left outer join
[DW].[EventDetails] ED on ED.EventRef = CPD.Event_Ref
where isnumeric(CPDPoints) = 1 and EventCode is not null and DelegateType = 'Delegate'
		and case when month(ED.EventDate) >= 10 then year(ED.EventDate )+1 else year(ED.EventDate) end <=
			case when month(getdate()) >= 10 then year(getdate())+1 else year(getdate()) end
group by EventCode, CPDPoints, ED.EventDate,
		case when month(ED.EventDate) >= 10 then year(ED.EventDate )+1 else year(ED.EventDate) end



GO
