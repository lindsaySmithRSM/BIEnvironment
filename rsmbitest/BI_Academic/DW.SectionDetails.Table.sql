USE [BI_Academic]
GO
/****** Object:  Table [DW].[SectionDetails]    Script Date: 07/11/2014 15:17:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [DW].[SectionDetails](
	[MemberRef] [int] NOT NULL,
	[SectionID] [int] NOT NULL,
	[SectionName] [varchar](120) NOT NULL,
	[Valid_From] [datetime] NULL,
	[Valid_To] [datetime] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
