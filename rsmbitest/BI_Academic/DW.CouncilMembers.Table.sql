USE [BI_Academic]
GO
/****** Object:  Table [DW].[CouncilMembers]    Script Date: 07/11/2014 15:17:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [DW].[CouncilMembers](
	[Section Name] [varchar](120) NOT NULL,
	[Member Ref] [int] NULL,
	[Member Name] [varchar](254) NULL,
	[company_name] [varchar](120) NOT NULL,
	[Membership No] [varchar](20) NULL,
	[Joined] [datetime] NULL,
	[Left] [datetime] NULL,
	[Member Status] [varchar](6) NOT NULL,
	[Position] [varchar](8000) NULL,
	[Position From Date] [datetime] NULL,
	[Position To Date] [datetime] NULL,
	[Joined Council Date] [datetime] NULL,
	[Main Email] [varchar](500) NULL,
	[Section Email] [varchar](500) NULL,
	[Address1] [varchar](100) NULL,
	[Address2] [varchar](100) NULL,
	[Address3] [varchar](100) NULL,
	[Town] [varchar](100) NULL,
	[County] [varchar](100) NULL,
	[PostCode] [varchar](100) NULL,
	[Country] [varchar](100) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
