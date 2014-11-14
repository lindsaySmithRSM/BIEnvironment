USE [BI_Academic]
GO
/****** Object:  Table [dbo].[Reports_PublicityEvaluation]    Script Date: 07/11/2014 15:17:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Reports_PublicityEvaluation](
	[EventCode] [varchar](50) NULL,
	[Mailing] [varchar](50) NULL,
	[Emailing] [varchar](50) NULL,
	[Flyer] [varchar](50) NULL,
	[Advert] [varchar](50) NULL,
	[RSM web] [varchar](50) NULL,
	[Bulletin] [varchar](50) NULL,
	[WoM] [varchar](50) NULL,
	[Other] [varchar](50) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
