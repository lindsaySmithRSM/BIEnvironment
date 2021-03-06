USE [BI_Academic]
GO
/****** Object:  Table [DW].[EventParticipantsLists]    Script Date: 07/11/2014 15:17:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [DW].[EventParticipantsLists](
	[Session_Ref] [int] NOT NULL,
	[Event_ref] [int] NOT NULL,
	[Member_Ref] [int] NULL,
	[EventDate] [datetime] NULL,
	[JobTitle] [varchar](75) NOT NULL,
	[PersonOrg] [varchar](75) NULL,
	[BadgeName] [varchar](254) NULL,
	[Surname] [varchar](254) NOT NULL,
	[Forenames] [varchar](254) NULL,
	[EventName] [varchar](254) NULL,
	[SessionName] [varchar](254) NULL,
	[EventCode] [varchar](20) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
