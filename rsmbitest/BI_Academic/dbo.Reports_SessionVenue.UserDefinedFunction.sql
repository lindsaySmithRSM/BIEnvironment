USE [BI_Academic]
GO
/****** Object:  UserDefinedFunction [dbo].[Reports_SessionVenue]    Script Date: 07/11/2014 15:17:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



create function [dbo].[Reports_SessionVenue] (@EventRef as int)

returns varchar(500)

as

BEGIN

		declare @VenueName		varchar(500)

		set @VenueName = ''
					
		select  @VenueName = R.Name
		from RSMCRM.RSM_LIVE.dbo.Session S inner join
		RSMCRM.RSM_LIVE.dbo.Venue_Room R on R.Venue_Room_Ref = S.Room
		where S.Name = 'Meeting' and Event_Ref = @EventRef

		
		return @VenueName

END



GO
