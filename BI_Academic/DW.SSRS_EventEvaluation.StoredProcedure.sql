USE [BI_Academic]
GO
/****** Object:  StoredProcedure [DW].[SSRS_EventEvaluation]    Script Date: 07/11/2014 15:17:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create proc [DW].[SSRS_EventEvaluation]

@EventCode as varchar(10)

as


select * 
from [dbo].[Reports_EventEvaluation]
where EventCode = @EventCode


GO
