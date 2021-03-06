USE [BI_Academic]
GO
/****** Object:  View [dbo].[Reports_EventRatesExpiring]    Script Date: 07/11/2014 15:17:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE view [dbo].[Reports_EventRatesExpiring]
as

select distinct E.EventCode 'EventCode', isnull(S.Event_Ref, ER.Event_Ref) 'EventRef', 
		E.EventName 'EventName', E.EventDate 'EventDate', HostSection,
		ER.Description 'RateName', ER.Net_Value 'RateValue', S.Name 'SessionName', 
		valid_to 'Expires'
from RSMCRM.RSM_Live.dbo.EVENT_RATE ER left outer join
RSMCRM.RSM_Live.dbo.Session S on S.Session_Ref = ER.Session_Ref left outer join
(select distinct EventCode, EventRef, EventNAme, EventDate, HostSection from [DW].[EventDetails] ) E on E.EventRef = S.Event_Ref
where isnull(valid_to, dateadd(dd, 100, cast(convert(varchar(8), getdate(), 112) as datetime))) >= 
		dateadd(d, -1, cast(convert(varchar(8), getdate(), 112) as datetime)) 
		and isnull(valid_to, dateadd(dd, 100, cast(convert(varchar(8), getdate(), 112) as datetime))) <
		 cast(convert(varchar(8), getdate(), 112) as datetime)



GO
