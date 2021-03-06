USE [BI_Academic]
GO
/****** Object:  UserDefinedFunction [dbo].[Reports_MeetingType]    Script Date: 07/11/2014 15:17:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



create function [dbo].[Reports_MeetingType] (@EventRef as int)
returns varchar(20)
as

	BEGIN

	Declare @MeetingType as varchar(20)

	set @MeetingType = ''

		select  @MeetingType = lookup_full_desc 
		from RSMCRM.RSM_LIVE.dbo.attribute A with(nolock) inner join
		RSMCRM.RSM_LIVE.dbo.lookup lu with(nolock) on lu.lookup_ref = a.attr_code_ref
		where code_type = 236 and Event_Ref = @EventRef


		Return @MeetingType

	END









GO
