USE [inventario_vm]
GO


CREATE TABLE [ServerHost].[Servidor](
	[id_hservidor] [int] IDENTITY(1,1) NOT NULL,
	[Id_trilha] [int] NOT NULL,
	[HostName] [varchar](60) NULL,
	[FisicoVM] [varchar](20) NULL,
	[SistemaOperaciona] [varchar](200) NULL,
	[IPaddress] [varchar](100) NULL,
	[PortConect] [varchar](10) NULL,
	[Descricao] [varchar](max) NULL,
	[Versao] [varchar](350) NULL,
	[cpu] [int] NULL,
	[MemoryRam] [int] NULL,
	[dhcriacao] [datetime] NULL,
	[dhalteracao] [datetime] NULL,
	[Ativo] [bit] NULL,
	[OR_AD] [bit] NULL,
	[OR_SCCM] [bit] NULL,
	[OR_NX] [bit] NULL,
	[OR_VW] [bit] NULL,
 CONSTRAINT [PK_id_hservidor] PRIMARY KEY CLUSTERED 
(
	[id_hservidor] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [ServerHost]
) ON [ServerHost] TEXTIMAGE_ON [ServerHost]
GO



CREATE TABLE [staging].[NutanixVM](
	[idNutanixVM] [int] IDENTITY(1,1) NOT NULL,
	[pcHostName] [varchar](100) NULL,
	[powerState] [varchar](10) NULL,
	[vmName] [varchar](256) NULL,
	[ipAddresses] [varchar](100) NULL,
	[hypervisorType] [varchar](100) NULL,
	[hostName] [varchar](256) NULL,
	[memoryCapacityInBytes] [varchar](max) NULL,
	[memoryReservedCapacityInBytes] [varchar](max) NULL,
	[numVCpus] [varchar](max) NULL,
	[numNetworkAdapters] [varchar](max) NULL,
	[controllerVm] [varchar](10) NULL,
	[vdiskNames] [varchar](max) NULL,
	[vdiskFilePaths] [varchar](max) NULL,
	[diskCapacityInBytes] [varchar](max) NULL,
	[description] [varchar](max) NULL,
 CONSTRAINT [PK_idNutanixVM] PRIMARY KEY CLUSTERED 
(
	[idNutanixVM] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [staging]
) ON [staging] TEXTIMAGE_ON [staging]
GO



CREATE TABLE [staging].[VMware](
	[idVMware] [int] IDENTITY(1,1) NOT NULL,
	[Id] [varchar](100) NULL,
	[Name] [varchar](255) NULL,
	[PowerState] [varchar](100) NULL,
	[Notes] [varchar](255) NULL,
	[Guest] [varchar](100) NULL,
	[NumCpu] [int] NULL,
	[CoresPerSocket] [int] NULL,
	[MemoryMB] [real] NULL,
	[MemoryGB] [real] NULL,
	[VMHost] [varchar](255) NULL,
	[Folder] [varchar](100) NULL,
	[ResourcePoolId] [varchar](100) NULL,
	[ResourcePool] [varchar](100) NULL,
	[HARestartPriority] [varchar](100) NULL,
	[HAIsolationResponse] [varchar](100) NULL,
	[DrsAutomationLevel] [varchar](100) NULL,
	[VMSwapfilePolicy] [varchar](100) NULL,
	[VMResourceConfiguration] [varchar](100) NULL,
	[Version] [varchar](100) NULL,
	[HardwareVersion] [varchar](100) NULL,
	[PersistentId] [varchar](100) NULL,
	[GuestId] [varchar](100) NULL,
	[UsedSpaceGB] [real] NULL,
	[ProvisionedSpaceGB] [real] NULL,
	[DatastoreIdList] [varchar](100) NULL,
	[CreateDate] [datetime] NULL,
	[IP] [varchar](500) NULL,
 CONSTRAINT [PK_idVMware] PRIMARY KEY CLUSTERED 
(
	[idVMware] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [staging]
) ON [staging]
GO

CREATE TABLE [dbo].[trilha](
	[id_trilha] [int] IDENTITY(1,1) NOT NULL,
	[trilha] [nvarchar](50) NULL,
	[sigla] [nvarchar](3) NULL,
 CONSTRAINT [PK_id_trilha] PRIMARY KEY CLUSTERED 
(
	[id_trilha] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

SET IDENTITY_INSERT [dbo].[trilha] ON 

INSERT [dbo].[trilha] ([id_trilha], [trilha], [sigla]) VALUES (1, N'Produção', N'PRD')
INSERT [dbo].[trilha] ([id_trilha], [trilha], [sigla]) VALUES (2, N'Homologação', N'HML')
INSERT [dbo].[trilha] ([id_trilha], [trilha], [sigla]) VALUES (3, N'Teste', N'TST')
INSERT [dbo].[trilha] ([id_trilha], [trilha], [sigla]) VALUES (4, N'Desenvolvimento', N'DSV')
INSERT [dbo].[trilha] ([id_trilha], [trilha], [sigla]) VALUES (5, N'Proof of Concept', N'POC')
INSERT [dbo].[trilha] ([id_trilha], [trilha], [sigla]) VALUES (6, N'Não classificado', N'NCL')
SET IDENTITY_INSERT [dbo].[trilha] OFF
GO

/* 
---- A criação dos index não é obrigatoria para execução do projeto.

CREATE NONCLUSTERED INDEX [IX_Servidor_IPaddress_25FEB] ON [ServerHost].[Servidor]
(
	[IPaddress] ASC
)
INCLUDE([HostName],[SistemaOperaciona],[PortConect],[MemoryRam]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [ServerHost]
GO
SET ANSI_PADDING ON
GO
CREATE NONCLUSTERED INDEX [IX_Servidor_IPaddress_3C19E] ON [ServerHost].[Servidor]
(
	[IPaddress] ASC
)
INCLUDE([HostName],[SistemaOperaciona],[PortConect],[MemoryRam]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [ServerHost]
GO
SET ANSI_PADDING ON
GO
CREATE NONCLUSTERED INDEX [IX_Servidor_IPaddress_C8BB4] ON [ServerHost].[Servidor]
(
	[IPaddress] ASC
)
INCLUDE([id_hservidor],[Id_trilha],[HostName],[FisicoVM],[SistemaOperaciona],[dhalteracao],[Ativo],[OR_AD],[OR_SCCM],[OR_NX],[OR_VW],[PortConect],[Descricao],[Versao],[cpu],[MemoryRam],[dhcriacao]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [ServerHost]
GO
SET ANSI_PADDING ON
GO
CREATE NONCLUSTERED INDEX [IX_Servidor_IPaddress_CB27F] ON [ServerHost].[Servidor]
(
	[IPaddress] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [ServerHost]
GO
SET ANSI_PADDING ON
GO
CREATE NONCLUSTERED INDEX [IX_Servidor_IPaddress_D4867] ON [ServerHost].[Servidor]
(
	[IPaddress] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [ServerHost]
GO
SET ANSI_PADDING ON
GO
CREATE NONCLUSTERED INDEX [IX_Servidor_IPaddress_EF89E] ON [ServerHost].[Servidor]
(
	[IPaddress] ASC
)
INCLUDE([id_hservidor],[Id_trilha],[FisicoVM],[SistemaOperaciona],[PortConect],[Ativo],[OR_AD],[OR_SCCM],[OR_NX],[OR_VW],[Descricao],[Versao],[cpu],[MemoryRam],[dhcriacao],[dhalteracao]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [ServerHost]
GO
SET ANSI_PADDING ON
GO
CREATE NONCLUSTERED INDEX [missing_index_67_66] ON [ServerHost].[Servidor]
(
	[HostName] ASC
)
INCLUDE([id_hservidor]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [ServerHost]
GO
ALTER TABLE [ServerHost].[Servidor] ADD  CONSTRAINT [DF__Servidor__dhcria__09746778]  DEFAULT (getdate()) FOR [dhcriacao]
GO
ALTER TABLE [ServerHost].[Servidor] ADD  CONSTRAINT [DF_ServerHost_Ativo]  DEFAULT ((1)) FOR [Ativo]
GO
ALTER TABLE [ServerHost].[Servidor] ADD  CONSTRAINT [DF_ServerHost_OR_AD]  DEFAULT ((0)) FOR [OR_AD]
GO
ALTER TABLE [ServerHost].[Servidor] ADD  CONSTRAINT [DF_ServerHost_OR_SCCM]  DEFAULT ((0)) FOR [OR_SCCM]
GO
ALTER TABLE [ServerHost].[Servidor] ADD  CONSTRAINT [DF_ServerHost_OR_NX]  DEFAULT ((0)) FOR [OR_NX]
GO
ALTER TABLE [ServerHost].[Servidor] ADD  CONSTRAINT [DF_ServerHost_OR_VW]  DEFAULT ((0)) FOR [OR_VW]
GO
ALTER TABLE [ServerHost].[Servidor]  WITH CHECK ADD  CONSTRAINT [FK_ServerHost_Trilha] FOREIGN KEY([Id_trilha])
REFERENCES [dbo].[trilha] ([id_trilha])
GO
ALTER TABLE [ServerHost].[Servidor] CHECK CONSTRAINT [FK_ServerHost_Trilha]
GO
*/

CREATE PROCEDURE [staging].[SP_carga_nx_ServerHost_Servidor]
AS
--Insere dados novos
INSERT INTO [ServerHost].[Servidor]
           ([Id_trilha]
           ,[HostName]
           ,[Descricao]
           ,[IPaddress]
		   ,[MemoryRam]
		   ,[cpu]
           ,[OR_NX])
SELECT 6                                                              as [Id_trilha]
      ,[vmName]                                                       as [HostName]
	  ,[description]                                                  as [Descricao]
	  , CASE 
	      WHEN CHARINDEX(' ',[ipAddresses])  = 0 THEN [ipAddresses]
		  ELSE LEFT([ipAddresses],CHARINDEX(' ',[ipAddresses])) 
		END                                                           AS [IPaddress]
      ,CAST([memoryCapacityInBytes] AS FLOAT) / 1024                  as [MemoryRam]
      ,[numVCpus]                                                     as [cpu]
	  ,1                                                              as [OR_NX]
  FROM [staging].[NutanixVM] AS NX
LEFT JOIN [ServerHost].[Servidor] AS SH ON RTRIM(LTRIM(SH.[HostName])) = RTRIM(LTRIM(NX.[vmName]))
WHERE SH.[HostName] IS NULL --AND NX.[ipAddresses] <> ''

--Realiza o UPDATE de campos antigos
UPDATE SH
   SET SH.[OR_NX]    = 1
      ,[FisicoVM] = 'Virtual'
	  ,SH.[Descricao] = NX.[description]
	  , SH.[IPaddress] = (CASE WHEN SH.[IPaddress] = '' THEN NX.[ipAddresses] ELSE SH.[IPaddress] END)
FROM [staging].[NutanixVM] AS NX
LEFT JOIN [ServerHost].[Servidor] AS SH ON RTRIM(LTRIM(SH.[HostName])) = RTRIM(LTRIM(NX.[vmName]))
WHERE SH.[HostName] IS NOT NULL
GO


CREATE PROCEDURE [staging].[SP_carga_VMware_ServerHost_Servidor]
AS
--Insere novos dados
INSERT INTO [ServerHost].[Servidor]
           ([Id_trilha]
           ,[HostName]
           ,[Descricao]
           ,[IPaddress]
		   ,[MemoryRam]
		   ,[cpu]
           ,[OR_VW])
SELECT 6   as [Id_trilha]
      , [Name]
      ,[Notes]
	  ,[IP]
      ,[MemoryMB]
      ,[NumCpu] * [CoresPerSocket] as CPU
	  , 1
  FROM [staging].[VMware] AS VW
LEFT JOIN [ServerHost].[Servidor] AS SH ON RTRIM(LTRIM(SH.[HostName])) = RTRIM(LTRIM(VW.[Name]))
WHERE SH.[HostName] IS NULL --AND VW.[IP] <> ''

--Realiza o Update de dados antigos
UPDATE SH
   SET SH.[OR_VW]    = 1
      ,[FisicoVM] = 'Virtual'
	  ,SH.[Descricao] = VW.[Notes]
	  , SH.[IPaddress] = (CASE WHEN SH.IPaddress = '' THEN VW.[IP] ELSE SH.IPaddress END)
FROM [staging].[VMware] AS VW
LEFT JOIN [ServerHost].[Servidor] AS SH ON RTRIM(LTRIM(SH.[HostName])) = RTRIM(LTRIM(VW.[Name]))
WHERE SH.[HostName] IS NOT NULL

GO



CREATE TRIGGER [ServerHost].[tg_insert_Servidor] ON [ServerHost].[Servidor]
AFTER INSERT
AS
BEGIN
    UPDATE H
    SET H.[dhalteracao] = GETDATE()
    FROM [ServerHost].[Servidor] AS H 
    INNER JOIN INSERTED AS INS ON INS.[id_hservidor] = H.[id_hservidor]
END
GO
ALTER TABLE [ServerHost].[Servidor] ENABLE TRIGGER [tg_insert_Servidor]
GO


CREATE TRIGGER [ServerHost].[tg_update_Servidor] ON [ServerHost].[Servidor]
AFTER UPDATE
AS
BEGIN
    UPDATE H
    SET H.[dhalteracao] = GETDATE()
    FROM [ServerHost].[Servidor] AS H 
    INNER JOIN INSERTED AS INS ON INS.[id_hservidor] = H.[id_hservidor]
END
GO



ALTER TABLE [ServerHost].[Servidor] ENABLE TRIGGER [tg_update_Servidor]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Esta tabela contem o cruzamento dos hosts de diferentes fonte de dados' , @level0type=N'SCHEMA',@level0name=N'ServerHost', @level1type=N'TABLE',@level1name=N'Servidor'
GO



