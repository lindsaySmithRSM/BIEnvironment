USE [BI_Academic]
GO
/****** Object:  StoredProcedure [DW].[SSPP_PrizesData]    Script Date: 07/11/2014 15:17:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE proc [DW].[SSPP_PrizesData]

@StartDate as datetime,
@EndDate as datetime

as


select  O.Company_Name 'Section Name', course_title 'Prize Name', visit_due 'Submission Deadline'
from RSMCRM.RSM_Live.[dbo].[AWARD_BODY_QUAL] Q inner join
RSMCRM.RSM_Live.[dbo].[AWARDING_BODY] AB on AB.awarding_body_ref = Q.awarding_body_ref inner join
RSMCRM.RSM_Live.dbo.Organisation O on O.Organisation_ref = AB.Organisation_ref
where Q.Visit_Due is not null and Q.Visit_Due between @StartDate and @EndDate
GO
