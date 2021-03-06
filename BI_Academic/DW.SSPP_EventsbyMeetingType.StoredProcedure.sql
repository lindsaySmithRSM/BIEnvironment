USE [BI_Academic]
GO
/****** Object:  StoredProcedure [DW].[SSPP_EventsbyMeetingType]    Script Date: 07/11/2014 15:17:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [DW].[SSPP_EventsbyMeetingType]
as

select nomeetings 'eventcode', totaldelegates, financialyear, status, depname, lookup_full_desc,
		case when [group] = 'sections' then [group]+' '+lookup_full_desc else [group] end 'MeetingType'
from DW.DelegatesCountPerMeeting dc inner join
[DW].[Event_Duration] ed on ed.code = dc.nomeetings inner join
[BI_Reference].[LU].[Integra_Departments] d on d.depno = dc.deptno inner join
[BI_Reference].[LU].[Integragroups] ig on ig.[Depno] = d.depno


GO
