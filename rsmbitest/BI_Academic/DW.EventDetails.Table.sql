USE [BI_Academic]
GO
/****** Object:  Table [DW].[EventDetails]    Script Date: 07/11/2014 15:17:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [DW].[EventDetails](
	[MemberRef] [int] NOT NULL,
	[EventRef] [int] NOT NULL,
	[EventCode] [varchar](20) NULL,
	[EventName] [varchar](254) NULL,
	[EventDate] [datetime] NULL,
	[EventRevenue] [float] NOT NULL,
	[DelegateType] [varchar](254) NULL,
	[HostSection] [varchar](50) NULL,
	[DepNo] [varchar](6) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_EventDetails_DelegateType]    Script Date: 07/11/2014 15:17:24 ******/
CREATE NONCLUSTERED INDEX [IX_EventDetails_DelegateType] ON [DW].[EventDetails]
(
	[DelegateType] ASC
)
INCLUDE ( 	[MemberRef],
	[EventRef]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
