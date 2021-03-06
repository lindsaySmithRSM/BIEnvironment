USE [BI_Academic]
GO
/****** Object:  StoredProcedure [DW].[TBuild_AuditFinancialActuals]    Script Date: 07/11/2014 15:17:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [DW].[TBuild_AuditFinancialActuals]
as

truncate table DW.Audit_FinancialActuals

insert into DW.Audit_FinancialActuals
SELECT 	EC.ChildEventCode, 
	AMOUNT 'ActualAmount', 
	CASE WHEN SUBSTRING(N .ACNO, 4, 3) IN ('000') THEN AMOUNT ELSE 0 end 'ActualSponsor', N.Trandate, 
	NLYear, NLPeriod
FROM  DW.LeadEventCodes EC left outer join
RSMCRM.RSM_LIVE.ACOCMP1.NOMDET N with(nolock) on N.depno = EC.deptno
											and  N.ccno  = EC.ccno		left outer join
RSMCRM.RSM_LIVE.ACOCMP1.AUDTAB HEAD with(nolock) ON N.TRANREF = HEAD.TRANREF 
where isnull(N.ACNO,'') not like 'B%' and amount <> 0 and isnull(N.ACNO,'') <> 'P06999'

GO
