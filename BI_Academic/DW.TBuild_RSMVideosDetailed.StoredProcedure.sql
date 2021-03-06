USE [BI_Academic]
GO
/****** Object:  StoredProcedure [DW].[TBuild_RSMVideosDetailed]    Script Date: 07/11/2014 15:17:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [DW].[TBuild_RSMVideosDetailed]
as

truncate table DW.RSMVideosDetailed

insert into DW.RSMVideosDetailed
select cast(convert(varchar(8),ds.create_timestamp, 112) as datetime) 'PurchaseDate', 
		e.code 'EventCode', s.name 'EventName', d.name 'DelegateName',
		[dbo].[Reports_SelectEmailAddress](M.Individual_ref) 'EmailAddress',
		case when s.name like 'CPD%' then 'CPD' else 'Video' end 'Type',
		d.Member_Ref 'MemberRef', isnull(membership_no, '') 'MembershipNo',
		case when membership_no is null then 'NonMember' else 
			case when isnull(Leave_Date, dateadd(y, 1, getdate())) < cast(convert(varchar(8),ds.create_timestamp, 112) as datetime) then 'ExMember' else 'Member' end end 'MemberStatus',
		join_date 'Joined',  Leave_Date 'Left', 
		er.net_value 'AmountPaid'  
--into DW.RSMVideosDetailed
from RSMCRM.RSM_Live.dbo.delegate D inner join
RSMCRM.RSM_Live.dbo.delegate_session ds on ds.delegate_ref = D.delegate_ref inner join
RSMCRM.RSM_Live.dbo.session s on s.session_ref = ds.session_ref inner join
RSMCRM.RSM_Live.dbo.event e on e.event_ref = s.event_ref inner join
RSMCRM.RSM_Live.dbo.member m on m.member_ref = d.member_ref inner join
RSMCRM.RSM_Live.dbo.event_rate er on er.event_rate_ref = ds.event_rate_ref
where (s.Name  like '%CPD%' or s.Name  like '%Video%') and s.Name not like '%Add video title%'

GO
