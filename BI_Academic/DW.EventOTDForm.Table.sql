USE [BI_Academic]
GO
/****** Object:  Table [DW].[EventOTDForm]    Script Date: 07/11/2014 15:17:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [DW].[EventOTDForm](
	[HostSection] [varchar](max) NULL,
	[EventName] [varchar](max) NULL,
	[EventDate] [datetime] NULL,
	[EventCode] [varchar](20) NULL,
	[Organisation_Ref] [int] NULL,
	[EventRef] [int] NULL,
	[SectionEmail] [varchar](max) NOT NULL,
	[SectionWeb] [varchar](max) NOT NULL,
	[SectionFax] [varchar](max) NULL,
	[SectionTelephone] [varchar](max) NULL,
	[Coordinator] [varchar](max) NULL,
	[Venue] [varchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_OTDForm_EventCode]    Script Date: 07/11/2014 15:17:24 ******/
CREATE NONCLUSTERED INDEX [IX_OTDForm_EventCode] ON [DW].[EventOTDForm]
(
	[EventCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_OTDForm_EventRef]    Script Date: 07/11/2014 15:17:24 ******/
CREATE NONCLUSTERED INDEX [IX_OTDForm_EventRef] ON [DW].[EventOTDForm]
(
	[EventRef] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_OTDForm_OrgRef]    Script Date: 07/11/2014 15:17:24 ******/
CREATE NONCLUSTERED INDEX [IX_OTDForm_OrgRef] ON [DW].[EventOTDForm]
(
	[Organisation_Ref] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
