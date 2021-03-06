USE [BI_Academic]
GO
/****** Object:  StoredProcedure [DW].[Evaluation_Speakers]    Script Date: 07/11/2014 15:17:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [DW].[Evaluation_Speakers]

@EventCode as varchar(10)
as

select EL.EventID, SpeakerNo, SpeakerName, E.EventName 'EventName', P1, P2, P3, P4, P5, U1, U2, U3, U4, U5, E,
		isnull([CPDPoints],0)'CPDPoints', 	DelegateCount, EventDate
from Reports_SpeakerEvaluation EL inner join
(select EventCode, EventName, count(MemberRef) 'DelegateCount' from DW.EventDetails group by EventCode, EventName) E on E.EventCode = EL.EventID left outer join
DW.FA1_DelegateCounts ND with(nolock) on ND.Code =  EL.EventID left outer join
[DW].[CPDEvents] CPD on CPD.Code = E.EventCode
where E.EventCode = @EventCode

GO
