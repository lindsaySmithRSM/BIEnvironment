USE [BI_Academic]
GO
/****** Object:  Table [DW].[CouncilMeetingTasks]    Script Date: 07/11/2014 15:17:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [DW].[CouncilMeetingTasks](
	[Session Name] [varchar](254) NOT NULL,
	[Event Code] [varchar](20) NULL,
	[Event Name] [varchar](254) NULL,
	[Event Date] [datetime] NULL,
	[Delegate Nos] [int] NOT NULL,
	[Agenda/ Papers preparation and approval] [varchar](191) NULL,
	[Agenda/ Papers to council] [varchar](191) NULL,
	[Action notes to council] [varchar](191) NULL,
	[EventCoordinator] [varchar](254) NOT NULL,
	[EventComment] [text] NULL,
	[EventStatus] [varchar](254) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
