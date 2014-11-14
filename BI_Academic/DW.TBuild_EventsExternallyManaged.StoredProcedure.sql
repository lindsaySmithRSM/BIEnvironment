USE [BI_Academic]
GO
/****** Object:  StoredProcedure [DW].[TBuild_EventsExternallyManaged]    Script Date: 07/11/2014 15:17:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create proc [DW].[TBuild_EventsExternallyManaged]
as

truncate table DW.EventsExternallyManaged
insert into DW.EventsExternallyManaged
select event_ref, code 'EventCode', lookup_full_desc
from RSMCRM.RSM_Live.dbo.Event E inner join
RSMCRM.RSM_Live.dbo.lookup lu on lu.lookup_ref = E.category
where category in (3563, 3564, 3565)





GO
