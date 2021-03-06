USE [BI_Academic]
GO
/****** Object:  View [dbo].[Reports_EventRatesAvailable]    Script Date: 07/11/2014 15:17:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE view [dbo].[Reports_EventRatesAvailable]
as

select distinct isnull(S.Event_Ref, ER.Event_Ref) 'EventRef', ER.Description 'RateName', ER.Net_Value 'RateValue', S.Name 'SessionName'
from RSMCRM.RSM_Live.dbo.EVENT_RATE ER left outer join
RSMCRM.RSM_Live.dbo.Session S on S.Session_Ref = ER.Session_Ref
where isnull(valid_to, getdate()) >= getdate() and isnull(valid_from, getdate()) <= getdate()
	and	ER.Description not like '%No show%' and ER.Description not like '%No_show%'
	and ER.Description not like '%sponsor%' and ER.Description not like '%donation%' and ER.Description not like '%Delegate pack insert%'
	and ER.Description not like '%CPD%' and ER.Description not like '%Video%' 
	and ER.Net_Value <> 0
	and S.Name in ('Meeting', 'Optional Meal', 'Other activities', 'Workshops', 'Webinar')





GO
