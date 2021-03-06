USE [BI_Academic]
GO
/****** Object:  Table [SD].[CouncilAttendance2012]    Script Date: 07/11/2014 15:17:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [SD].[CouncilAttendance2012](
	[MeetingDate] [datetime] NULL,
	[SectionName] [nvarchar](255) NULL,
	[SectionRef] [float] NULL,
	[Section] [nvarchar](255) NULL,
	[MemberRef] [float] NULL,
	[Name] [nvarchar](255) NULL,
	[Position] [nvarchar](255) NULL,
	[Attended] [float] NULL
) ON [PRIMARY]

GO
