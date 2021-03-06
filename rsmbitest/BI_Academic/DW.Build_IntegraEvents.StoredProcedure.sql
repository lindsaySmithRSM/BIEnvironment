USE [BI_Academic]
GO
/****** Object:  StoredProcedure [DW].[Build_IntegraEvents]    Script Date: 07/11/2014 15:17:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [DW].[Build_IntegraEvents]
as

truncate table Integra.Events
insert into Integra.Events
select Event_Ref, Code 'EventCode', Name 'EventName', lu.lookup_full_desc 'Category', lu2.lookup_full_desc 'Status',
		DepName 'Department', DeptNo 'DepartmentCode'
from RSMCRM.RSM_LIVE.dbo.Event E inner join
RSMCRM.RSM_LIVE.dbo.lookup lu on lu.lookup_ref = E.Category left outer join
RSMCRM.RSM_LIVE.ACOCMP1.DEPARTMT DT on DT.DEPNO = E.DeptNo  inner join
RSMCRM.RSM_LIVE.dbo.lookup lu2 on lu2.lookup_ref = E.Status




GO
