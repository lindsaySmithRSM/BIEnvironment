USE [BI_Academic]
GO
/****** Object:  Table [dbo].[Reports_SpeakerEvaluation]    Script Date: 07/11/2014 15:17:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Reports_SpeakerEvaluation](
	[EventID] [varchar](50) NULL,
	[SpeakerNo] [varchar](50) NULL,
	[SpeakerName] [varchar](255) NULL,
	[P1] [int] NULL,
	[P2] [int] NULL,
	[P3] [int] NULL,
	[P4] [int] NULL,
	[P5] [int] NULL,
	[U1] [int] NULL,
	[U2] [int] NULL,
	[U3] [int] NULL,
	[U4] [int] NULL,
	[U5] [int] NULL,
	[E] [int] NULL,
	[Category] [varchar](8) NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
