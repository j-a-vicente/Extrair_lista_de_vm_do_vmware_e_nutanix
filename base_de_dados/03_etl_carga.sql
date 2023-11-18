CREATE TABLE [dbo].[etl_carga_dados](
	[id_etl_carga_dados] [int] IDENTITY(1,1) NOT NULL,
	[id_fonte_de_dados] [int] NOT NULL,
	[iniciado_por] [nvarchar](max) NULL,
	[status_etl] [INT] NULL,
	[dh_inicio] [datetime] NULL,
	[dh_final] [datetime] NULL,
 CONSTRAINT [PK_id_etl_carga_dados] PRIMARY KEY CLUSTERED 
(
	[id_etl_carga_dados] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[etl_carga_dados] ADD  DEFAULT (getdate()) FOR [dh_inicio]
GO

ALTER TABLE [dbo].[etl_carga_dados]  WITH CHECK ADD  CONSTRAINT [FK_fonte_de_dados_etl_carga_dados] FOREIGN KEY([id_fonte_de_dados])
REFERENCES [dbo].[fonte_de_dados] ([id_fonte_de_dados])
GO
