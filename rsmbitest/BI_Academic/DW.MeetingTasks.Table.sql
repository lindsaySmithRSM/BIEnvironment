USE [BI_Academic]
GO
/****** Object:  Table [DW].[MeetingTasks]    Script Date: 07/11/2014 15:17:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [DW].[MeetingTasks](
	[Session Name] [varchar](254) NOT NULL,
	[Event Code] [varchar](20) NULL,
	[Event Name] [varchar](254) NULL,
	[Event Date] [datetime] NULL,
	[Budget Delegate Nos] [int] NOT NULL,
	[Delegate Nos] [int] NOT NULL,
	[Programme Received] [varchar](191) NULL,
	[Budget Approved] [varchar](191) NULL,
	[Joint Contract Signed] [varchar](191) NULL,
	[CPD Applied For] [varchar](191) NULL,
	[Publicity Started] [varchar](191) NULL,
	[Publicity/ Low Nos] [varchar](191) NULL,
	[Low Nos/Remedial action] [varchar](191) NULL,
	[Speaker Letters] [varchar](191) NULL,
	[Send C&C Form (incl web lectures)] [varchar](191) NULL,
	[Final nos and Check BEO] [varchar](191) NULL,
	[Evaluation Summary] [varchar](191) NULL,
	[MO Form] [varchar](191) NULL,
	[Finance Rec/ Event Closed] [varchar](191) NULL,
	[Sponsorship Total] [float] NOT NULL,
	[CPD Points] [varchar](511) NOT NULL,
	[EventCoordinator] [varchar](254) NOT NULL,
	[EventComment] [text] NULL,
	[EventStatus] [varchar](254) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
