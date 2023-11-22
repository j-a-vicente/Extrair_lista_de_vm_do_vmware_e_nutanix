# Consolidando os dados.

Devidos a origem dos dados ser de dois lugares diferentes será preciso consolidar os dados em uma tabelas <b>[ServerHost].[Servidor]</b>. Foi desenvolvido duas <b>Stored Procedures</b> que vão executar estás tarefas.


Executar as SP de consolidação.
````
DECLARE @RC int

-- Orgiem Nutanix para [ServerHost].[Servidor]
EXECUTE @RC = [dbo].[SP_carga_nx_ServerHost_Servidor] 
GO

-- Orgiem VMWare para [ServerHost].[Servidor]
EXECUTE @RC = [dbo].[SP_carga_VMware_ServerHost_Servidor] 
GO

````

Depois de finalizado a consolidação execute um select na tabela <b>[ServerHost].[Servidor]</b>
![](/imagens/ServerHost_Servidor.png)
