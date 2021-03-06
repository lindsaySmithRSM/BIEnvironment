USE [BI_Academic]
GO
/****** Object:  StoredProcedure [DW].[TBuild_LeadEventCodes]    Script Date: 07/11/2014 15:17:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE proc [DW].[TBuild_LeadEventCodes]

as

truncate table DW.LeadEventCodes

insert into DW.LeadEventCodes
--EVENT CODES AND CHILD EVENTS
SELECT Event_Ref, DEPTNO, DEPNAME, Bob.CCNO, LeadEventCode, NAME, START_DATE, ChildEventCode, main, EventStatus
FROM (
select distinct S.Event_Ref, S.DEPTNO, S.CCNO, E.CODE 'LeadEventCode', E.NAME, E.Start_Date,
			RIGHT(S.DEPTNO, 2) + RIGHT(S.CCNO, 3) 'ChildEventCode', 0 'main', lu.lookup_full_desc 'EventStatus'
		from RSMCRM.RSM_LIVE.dbo.session S with(nolock) inner join
		RSMCRM.RSM_LIVE.dbo.Event E with(nolock) on E.Event_Ref = S.Event_Ref inner join
		RSMCRM.RSM_LIVE.dbo.lookup lu on lu.lookup_ref = E.status
		where S.name LIKE 'Joint RSM event transfer%'    
			--and S.Allow_Bookings = 'Y'
		union
		select distinct E.Event_Ref, E.DEPTNO, E.CCNO, E.Code 'LeadEventCode', E.Name, E.Start_Date,
				RIGHT(E.DEPTNO, 2) + RIGHT(E.CCNO, 3) 'ChildEventCode', 1 'main', lu.lookup_full_desc 'EventStatus'
		from RSMCRM.RSM_LIVE.dbo.EVENT E with(nolock) inner join
		RSMCRM.RSM_LIVE.dbo.lookup lu on lu.lookup_ref = E.status
) BOB LEFT OUTER JOIN
RSMCRM.RSM_LIVE.ACOCMP1.DEPARTMT D with(nolock) ON bob.DEPTNO = D.DEPNO 
where len(LeadEventCode) = 5
--WHERE LeadEventCode = 'EMC02'



GO
