USE [BI_Academic]
GO
/****** Object:  StoredProcedure [DW].[TBuild_EventEvaluationTables]    Script Date: 07/11/2014 15:17:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [DW].[TBuild_EventEvaluationTables]
as

truncate table [dbo].[Reports_EventEvaluation]
insert into	[dbo].[Reports_EventEvaluation]
select * from DataMart_Evaluations.dbo.Reports_EventEvaluation


truncate table [dbo].[Reports_PublicityEvaluation]
insert into  [dbo].[Reports_PublicityEvaluation]
select * from DataMart_Evaluations.dbo.[tbl_PublicityDetails]

truncate table [dbo].[Reports_SpeakerEvaluation]
insert into [dbo].[Reports_SpeakerEvaluation]
select * from DataMart_Evaluations.dbo.Reports_SpeakerEvaluation


GO
