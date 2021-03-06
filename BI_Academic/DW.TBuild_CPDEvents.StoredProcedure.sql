USE [BI_Academic]
GO
/****** Object:  StoredProcedure [DW].[TBuild_CPDEvents]    Script Date: 07/11/2014 15:17:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [DW].[TBuild_CPDEvents]
as

truncate table DW.CPDEvents

insert into DW.CPDEvents
select  A.event_ref, E.Code, E.Start_Date 'EventDate',
	case when lookup_full_desc like '%CPD Points' then replace(lookup_full_desc, ' CPD Points','') else 
		case when lookup_full_desc like '%CPD Point' then replace(lookup_full_desc, ' CPD Point','') else 
			case when lookup_full_desc like '%CPD - Applied for%' then replace(lookup_full_desc, 'CPD - ','') else 
			case when lookup_full_desc like '%Other (please specify)' then replace(Detail, ' CPD Points','') else lookup_full_desc end end end end 'CPDPoints'

from RSMCRM.RSM_LIVE.dbo.Event E with(nolock) inner join
RSMCRM.RSM_LIVE.dbo.attribute A with(nolock) on A.Event_Ref = E.Event_Ref inner join
RSMCRM.RSM_LIVE.dbo.lookup lu with(nolock) on lu.lookup_ref = a.attr_code_ref 
where lookup_type_ref = 202 and E.Start_Date >= '01 Oct 2010'




GO
