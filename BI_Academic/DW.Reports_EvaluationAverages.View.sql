USE [BI_Academic]
GO
/****** Object:  View [DW].[Reports_EvaluationAverages]    Script Date: 07/11/2014 15:17:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE view [DW].[Reports_EvaluationAverages]

as

Select EventID, Presentation, Usefulness, Relevance, Objectives
from (
select EventID,  
	case when SUM(cast(P1+P2+P3+P4+P5 as money))=0 then 0 
		else SUM(cast((P1*1)+(P2*2)+(P3*3)+(P4*4)+(P5*5) as money))/SUM(cast((P1+P2+P3+P4+P5) as money)) end 'Presentation', 
	case when SUM(U1+U2+U3+U4+U5)=0 then 0 
		else SUM(cast((U1*1)+(U2*2)+(U3*3)+(U4*4)+(U5*5) as money))/SUM(cast((U1+U2+U3+U4+U5) as money)) end 'Usefulness'
from Reports_SpeakerEvaluation
GROUP BY EventID)Bob left outer join
(select EventCode,  
	case when SUM(cast(R1+R2+R3+R4+R5 as money))=0 then 0 
		else SUM(cast((R1*1)+(R2*2)+(R3*3)+(R4*4)+(R5*5) as money))/SUM(cast((R1+R2+R3+R4+R5) as money)) end 'Relevance', 
	case when SUM(cast(O1+O2+O3+O4+O5 as money))=0 then 0 
		else SUM(cast((O1*1)+(O2*2)+(O3*3)+(O4*4)+(O5*5) as money))/SUM(cast((O1+O2+O3+O4+O5) as money)) end 'Objectives'
from Reports_EventEvaluation
group by EventCode)Fred on Fred.EventCode = Bob.EventID
 




GO
