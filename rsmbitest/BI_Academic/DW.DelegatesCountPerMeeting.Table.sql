USE [BI_Academic]
GO
/****** Object:  Table [DW].[DelegatesCountPerMeeting]    Script Date: 07/11/2014 15:17:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [DW].[DelegatesCountPerMeeting](
	[NoMeetings] [varchar](20) NULL,
	[TotalDelegates] [int] NULL,
	[FinancialYear] [int] NULL,
	[Status] [varchar](9) NOT NULL,
	[deptno] [varchar](6) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
