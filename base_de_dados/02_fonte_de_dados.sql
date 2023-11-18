

CREATE TABLE [dbo].[tipo_fonte_de_dados](
	[id_tipo_fonte_de_dados] [int] IDENTITY(1,1) NOT NULL,
	[nome] [nvarchar](100) NULL,
 CONSTRAINT [PK_id_tipo_fonte_de_dados] PRIMARY KEY CLUSTERED 
(
	[id_tipo_fonte_de_dados] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON ) ON [PRIMARY]
) ON [PRIMARY]
GO


CREATE TABLE [dbo].[fonte_de_dados](
	[id_fonte_de_dados] [int] IDENTITY(1,1) NOT NULL,
	[id_tipo_fonte_de_dados] [int] NOT NULL,
	[nome] [nvarchar](100) NULL,
	[prioridade] [int] NOT NULL,
	[dhcriacao] [datetime] NULL,
	[dhalteracao] [datetime] NULL,	
	[Ativo] [bit] NULL,
 CONSTRAINT [PK_id_fonte_de_dados] PRIMARY KEY CLUSTERED 
(
	[id_fonte_de_dados] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON ) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[fonte_de_dados]ADD  CONSTRAINT [DF_fonte_de_dado_prioridade]  DEFAULT ((1)) FOR [prioridade]
GO

ALTER TABLE [dbo].[fonte_de_dados] ADD  DEFAULT (getdate()) FOR [dhcriacao]
GO

ALTER TABLE [dbo].[fonte_de_dados] ADD  CONSTRAINT [DF_fonte_de_dados_Ativo]  DEFAULT ((1)) FOR [Ativo]
GO

ALTER TABLE [dbo].[fonte_de_dados] WITH CHECK ADD  CONSTRAINT [FK_fonte_de_dados_tipo_fonte_de_dados] FOREIGN KEY([id_tipo_fonte_de_dados])
REFERENCES [dbo].[tipo_fonte_de_dados] ([id_tipo_fonte_de_dados])
GO


CREATE TABLE [dbo].[fonte_de_dados_tabelas](
	[id_fonte_de_dados_tabelas] [int] IDENTITY(1,1) NOT NULL,
	[id_fonte_de_dados] [int] NOT NULL,
	[schema_name] [nvarchar](100) NOT NULL,
	[table_name] [nvarchar](100) NOT NULL,
	[dhcriacao] [datetime] NULL,
	[dhalteracao] [datetime] NULL,
	[Ativo] [bit] NULL,
 CONSTRAINT [PK_id_fonte_de_dados_tabelas] PRIMARY KEY CLUSTERED 
(
	[id_fonte_de_dados_tabelas] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[fonte_de_dados_tabelas] ADD  DEFAULT (getdate()) FOR [dhcriacao]
GO

ALTER TABLE [dbo].[fonte_de_dados_tabelas] ADD  CONSTRAINT [DF_fonte_de_dados_tabelas_Ativo]  DEFAULT ((1)) FOR [Ativo]
GO

ALTER TABLE [dbo].[fonte_de_dados_tabelas]  WITH CHECK ADD  CONSTRAINT [FK_fonte_de_dados_fonte_de_dados_tabelas] FOREIGN KEY([id_fonte_de_dados])
REFERENCES [dbo].[fonte_de_dados] ([id_fonte_de_dados])
GO
