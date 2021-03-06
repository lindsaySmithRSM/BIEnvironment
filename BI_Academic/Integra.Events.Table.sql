USE [BI_Academic]
GO
/****** Object:  Table [Integra].[Events]    Script Date: 07/11/2014 15:17:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Integra].[Events](
	[Event_Ref] [int] NOT NULL,
	[EventCode] [varchar](20) NULL,
	[EventName] [varchar](254) NULL,
	[Category] [varchar](254) NULL,
	[Status] [varchar](254) NULL,
	[Department] [varchar](50) NULL,
	[DepartmentCode] [varchar](6) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
