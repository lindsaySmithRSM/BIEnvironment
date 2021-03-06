USE [BI_Academic]
GO
/****** Object:  Table [DW].[LeadEventCodes]    Script Date: 07/11/2014 15:17:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [DW].[LeadEventCodes](
	[Event_Ref] [int] NULL,
	[DEPTNO] [varchar](6) NULL,
	[DEPNAME] [varchar](50) NULL,
	[CCNO] [varchar](6) NULL,
	[LeadEventCode] [varchar](20) NULL,
	[NAME] [varchar](254) NULL,
	[START_DATE] [datetime] NULL,
	[ChildEventCode] [varchar](5) NULL,
	[main] [int] NOT NULL,
	[EventStatus] [varchar](254) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
