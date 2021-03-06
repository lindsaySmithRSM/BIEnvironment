USE [BI_Academic]
GO
/****** Object:  View [DW].[Reports_RegionalMeetingLocation]    Script Date: 07/11/2014 15:17:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE view [DW].[Reports_RegionalMeetingLocation]
as

select distinct Event_Ref, 
		case when lookup_full_desc = 'London' then 'London' else 
			case when lookup_full_desc in ('Europe','Ireland', 'Rest of the world') then 'Overseas' else 'Regional' end end 'LocationGroup', 
		case when lookup_full_desc = 'Other (Please specify)' then A.Detail else Lookup_full_desc end 'MeetingLocation'
from RSMCRM.RSM_Live.dbo.attribute A inner join
RSMCRM.RSM_Live.dbo.lookup Lu on Lu.Lookup_ref = A.Attr_code_Ref
where lookup_type_ref = 235

GO
