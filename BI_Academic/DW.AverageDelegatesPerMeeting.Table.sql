USE [BI_Academic]
GO
/****** Object:  Table [DW].[AverageDelegatesPerMeeting]    Script Date: 07/11/2014 15:17:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [DW].[AverageDelegatesPerMeeting](
	[AveDelegates] [float] NULL,
	[NoMeetings] [int] NULL,
	[TotalDelegates] [int] NULL,
	[FinancialYear] [int] NULL,
	[Status] [varchar](9) NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
