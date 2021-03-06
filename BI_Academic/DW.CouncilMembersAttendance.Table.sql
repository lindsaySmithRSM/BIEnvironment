USE [BI_Academic]
GO
/****** Object:  Table [DW].[CouncilMembersAttendance]    Script Date: 07/11/2014 15:17:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [DW].[CouncilMembersAttendance](
	[DepNo] [varchar](254) NULL,
	[EventDate] [datetime] NULL,
	[Member_Ref] [float] NULL,
	[EventCode] [varchar](20) NULL,
	[Attended] [float] NOT NULL,
	[MemberName] [varchar](200) NULL,
	[Position] [varchar](200) NULL,
	[SectionName] [varchar](200) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
