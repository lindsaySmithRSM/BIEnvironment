USE [BI_Academic]
GO
/****** Object:  StoredProcedure [DW].[SSRS_EvaluationPublicity]    Script Date: 07/11/2014 15:17:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [DW].[SSRS_EvaluationPublicity]
--declare
@EventCode as varchar(10)
--set @EventCode = 'CDD01'
as

select Bob.EventCode, NoResponses, Type, EventName, count(distinct MemberRef) 'SelectNo'
from 
(
select EventCode, sum(isnull(cast(Mailing as int), 0))'NoResponses', 'Mailing' 'Type'
from dbo.Reports_PublicityEvaluation
where EventCode = @EventCode
group by EventCode
union all 
select EventCode, sum(isnull(cast(Emailing as int), 0)), 'Emailing'
from dbo.Reports_PublicityEvaluation
where EventCode = @EventCode
group by EventCode
union all 
select EventCode, sum(isnull(cast(Flyer as int), 0)), 'Flyer'
from dbo.Reports_PublicityEvaluation
where EventCode = @EventCode
group by EventCode
union all 
select EventCode, sum(isnull(cast(Advert as int), 0)), 'Advert'
from dbo.Reports_PublicityEvaluation
where EventCode = @EventCode
group by EventCode
union all 
select EventCode, sum(isnull(cast([RSM Web] as int), 0)), 'RSM Web'
from dbo.Reports_PublicityEvaluation
where EventCode = @EventCode
group by EventCode
union all 
select EventCode, sum(isnull(cast(Bulletin as int), 0)), 'Bulletin'
from dbo.Reports_PublicityEvaluation
where EventCode = @EventCode
group by EventCode
union all 
select EventCode, sum(isnull(cast(WOM as int), 0)), 'WOM'
from dbo.Reports_PublicityEvaluation
where EventCode = @EventCode
group by EventCode
union all 
select EventCode, sum(isnull(cast(Other as int), 0)), 'Other'
from dbo.Reports_PublicityEvaluation
where EventCode = @EventCode
group by EventCode
)Bob inner join DW.EventDetails E on E.EventCode = Bob.EventCode
group by Bob.EventCode, NoResponses, Type, EventName


GO
