USE [BI_Academic]
GO
/****** Object:  Table [DW].[EventParticipants_rank]    Script Date: 07/11/2014 15:17:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [DW].[EventParticipants_rank](
	[event_ref] [int] NOT NULL,
	[member_ref] [int] NULL,
	[Surname] [varchar](254) NOT NULL,
	[EventRank] [bigint] NULL,
	[ColumnNo] [int] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
