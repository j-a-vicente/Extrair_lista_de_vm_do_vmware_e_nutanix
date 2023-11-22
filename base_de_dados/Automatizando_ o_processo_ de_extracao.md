# Automatizando o processo de extração.

A automação do processo de extração e consolidação será executada pelo MS SQL Agent, será criado um Job e todas as etapas seram configuradas no job.

Script de criação do job:
````
USE [msdb]
GO

BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0

IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'[Uncategorized (Local)]' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'[Uncategorized (Local)]'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'Inventario_job', 
		@enabled=1, 
		@notify_level_eventlog=0, 
		@notify_level_email=0, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'No description available.', 
		@category_name=N'[Uncategorized (Local)]', 
		@owner_login_name=N'sa', @job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [VMware limpar tabelas stg]    Script Date: 22/11/2023 15:53:18 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'VMware limpar tabelas stg', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=3, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'TRUNCATE TABLE [staging].[VMware]', 
		@database_name=N'inventario', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [VMware5x]    Script Date: 22/11/2023 15:53:18 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'VMware5x', 
		@step_id=2, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=3, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'PowerShell', 
		@command=N'# Este script foi criado para extrair as VM do virtualizado VMware.

#Parametro necessário para execução do script dentro do job
Set-Location C:


#Variáveis do servido e banco de dados
$SQLInstance = "XXXXXXXXXX" # Nome da estância de banco de dados
$SQLDatabase = "XXXXXXXXXX" # Nome da base de dados

#Install-Module SqlServer  -AllowPrerelease -Force

# Limpeza da tabela de STAGE que reseberá os dados brutos
$SQLQueryDelete = "USE $SQLDatabase
TRUNCATE TABLE [staging].[VMware]"

#$SQLQuery1Output = Invoke-Sqlcmd -query $SQLQueryDelete -ServerInstance $SQLInstance


#Conectar no servidor do VMware
# são varios servidor com isto estamos conectando apenas um nesta linha
Connect-VIServer -Server vm00.aero.vms.contoso.com.br -User svc_usr__ext_vm@contoso.gov.br -Password P@ssw0rd2023 

#Iniciar a extração dos Usuários das VM no Nutanix
# A variável "$vms" é uma matriz que receberá o resultado do comando de extração das vm

try{

    $vms = Get-VMHost | Select-Object Id, Name, PowerState, Notes, Guest, NumCpu, CoresPerSocket, MemoryMB, MemoryGB, VMHost,
    Folder, ResourcePoolId, ResourcePool, HARestartPriority, HAIsolationResponse, DrsAutomationLevel,
    VMSwapfilePolicy, VMResourceConfiguration, Version, HardwareVersion, PersistentId, GuestId,
    UsedSpaceGB, ProvisionedSpaceGB, DatastoreIdList, CreateDate

    }catch{
    Write-Output "Erro na extração."
    throw $_
    break
    }

    #Loop que será usuado para transferir os dados da matriz para o banco de dados
    ForEach($vm in $vms){
        #Write-Output $vm.Name
        #Para cada linha que a matriz percorre e inserido o valor na variável de destino.       
        $Id                      = $vm.Id
        $Name                    = $vm.Name
        $PowerState              = $vm.PowerState
        $Notes                   = $vm.Notes
        $Guest                   = $vm.Guest
        $NumCpu                  = $vm.NumCpu
        $CoresPerSocket          = $vm.CoresPerSocket
        $MemoryMB                = $vm.MemoryMB
        $MemoryGB                = $vm.MemoryGB
        $VMHost                  = $vm.VMHost
        $Folder                  = $vm.Folder
        $ResourcePoolId          = $vm.ResourcePoolId
        $ResourcePool            = $vm.ResourcePool
        $HARestartPriority       = $vm.HARestartPriority
        $HAIsolationResponse     = $vm.HAIsolationResponse
        $DrsAutomationLevel      = $vm.DrsAutomationLevel
        $VMSwapfilePolicy        = $vm.VMSwapfilePolicy
        $VMResourceConfiguration = $vm.VMResourceConfiguration
        $Version                 = $vm.Version
        $HardwareVersion         = $vm.HardwareVersion
        $PersistentId            = $vm.PersistentId
        $GuestId                 = $vm.GuestId
        $UsedSpaceGB             = $vm.UsedSpaceGB
        $ProvisionedSpaceGB      = $vm.ProvisionedSpaceGB
        $DatastoreIdList         = $vm.DatastoreIdList
        $CreateDate              = $vm.CreateDate     

   #A variável "$SQLQuery" receberar o insert com os dados para ser executado no banco
   $SQLQuery = "USE $SQLDatabase
   INSERT INTO [staging].[VMware]
   ([Id],[Name],[PowerState],[Notes],[Guest],[NumCpu],[CoresPerSocket],[MemoryMB],[MemoryGB],
    [VMHost],[Folder],[ResourcePoolId],[ResourcePool],[HARestartPriority],[HAIsolationResponse],
    [DrsAutomationLevel],[VMSwapfilePolicy],[VMResourceConfiguration],[Version],[HardwareVersion],
    [PersistentId],[GuestId],[UsedSpaceGB],[ProvisionedSpaceGB],[DatastoreIdList],[CreateDate])
   VALUES  (''$Id'',''$Name'',''$PowerState'',''$Notes'',''$Guest'',''$NumCpu'',''$CoresPerSocket'',Cast(''$MemoryMB'' as REAL),Cast(''$MemoryGB'' as REAL),
   ''$VMHost'',''$Folder'',''$ResourcePoolId'',''$ResourcePool'',''$HARestartPriority'',''$HAIsolationResponse'',
   ''$DrsAutomationLevel'',''$VMSwapfilePolicy'',''$VMResourceConfiguration'',''$Version'',''$HardwareVersion'',
   ''$PersistentId'',''$GuestId'',Cast(''$UsedSpaceGB'' as REAL),Cast(''$ProvisionedSpaceGB'' as REAL),''$DatastoreIdList'',''$CreateDate'');"        

   #Executa o comando de insert com os dados
   try{
    $SQLQuery1Output = Invoke-Sqlcmd -query $SQLQuery -ServerInstance $SQLInstance -ErrorAction stop
}catch{
Write-Output $SQLQuery
throw $_
break
}
#Fim do loop da matriz com os usuário
}   
', 
		@database_name=N'master', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [VMware6x]    Script Date: 22/11/2023 15:53:18 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'VMware6x', 
		@step_id=3, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=3, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'PowerShell', 
		@command=N'# Este script foi criado para extrair as VM do virtualizado VMware.

#Parametro necessário para execução do script dentro do job
Set-Location C:


#Variáveis do servido e banco de dados
$SQLInstance = "XXXXXXXXXX" # Nome da estância de banco de dados
$SQLDatabase = "XXXXXXXXXX" # Nome da base de dados

#Install-Module SqlServer  -AllowPrerelease -Force

# Limpeza da tabela de STAGE que reseberá os dados brutos
$SQLQueryDelete = "USE $SQLDatabase
TRUNCATE TABLE [staging].[VMware]"

#$SQLQuery1Output = Invoke-Sqlcmd -query $SQLQueryDelete -ServerInstance $SQLInstance


#Conectar no servidor do VMware
# são varios servidor com isto estamos conectando apenas um nesta linha
Connect-VIServer -Server vm00.aero.vms.contoso.com.br -User svc_usr__ext_vm@contoso.gov.br -Password P@ssw0rd2023 


#Iniciar a extração dos Usuários das VM no Nutanix
# A variável "$vms" é uma matriz que receberá o resultado do comando de extração das vm

try{

    $vms = Get-VM | Select-Object Id, Name, PowerState, Notes, Guest, NumCpu, CoresPerSocket, MemoryMB, MemoryGB, VMHost,
    Folder, ResourcePoolId, ResourcePool, HARestartPriority, HAIsolationResponse, DrsAutomationLevel,
    VMSwapfilePolicy, VMResourceConfiguration, Version, HardwareVersion, PersistentId, GuestId,
    UsedSpaceGB, ProvisionedSpaceGB, DatastoreIdList, CreateDate

    }catch{
    Write-Output "Erro na extração."
    throw $_
    break
    }

    #Loop que será usuado para transferir os dados da matriz para o banco de dados
    ForEach($vm in $vms){
        #Write-Output $vm.Name
        #Para cada linha que a matriz percorre e inserido o valor na variável de destino.       
        $Id                      = $vm.Id
        $Name                    = $vm.Name
        $PowerState              = $vm.PowerState
        $Notes                   = $vm.Notes
        $Guest                   = $vm.Guest
        $NumCpu                  = $vm.NumCpu
        $CoresPerSocket          = $vm.CoresPerSocket
        $MemoryMB                = $vm.MemoryMB
        $MemoryGB                = $vm.MemoryGB
        $VMHost                  = $vm.VMHost
        $Folder                  = $vm.Folder
        $ResourcePoolId          = $vm.ResourcePoolId
        $ResourcePool            = $vm.ResourcePool
        $HARestartPriority       = $vm.HARestartPriority
        $HAIsolationResponse     = $vm.HAIsolationResponse
        $DrsAutomationLevel      = $vm.DrsAutomationLevel
        $VMSwapfilePolicy        = $vm.VMSwapfilePolicy
        $VMResourceConfiguration = $vm.VMResourceConfiguration
        $Version                 = $vm.Version
        $HardwareVersion         = $vm.HardwareVersion
        $PersistentId            = $vm.PersistentId
        $GuestId                 = $vm.GuestId
        $UsedSpaceGB             = $vm.UsedSpaceGB
        $ProvisionedSpaceGB      = $vm.ProvisionedSpaceGB
        $DatastoreIdList         = $vm.DatastoreIdList
        $CreateDate              = $vm.CreateDate     

   #A variável "$SQLQuery" receberar o insert com os dados para ser executado no banco
   $SQLQuery = "USE $SQLDatabase
   INSERT INTO [staging].[VMware]
   ([Id],[Name],[PowerState],[Notes],[Guest],[NumCpu],[CoresPerSocket],[MemoryMB],[MemoryGB],
    [VMHost],[Folder],[ResourcePoolId],[ResourcePool],[HARestartPriority],[HAIsolationResponse],
    [DrsAutomationLevel],[VMSwapfilePolicy],[VMResourceConfiguration],[Version],[HardwareVersion],
    [PersistentId],[GuestId],[UsedSpaceGB],[ProvisionedSpaceGB],[DatastoreIdList],[CreateDate])
   VALUES  (''$Id'',''$Name'',''$PowerState'',''$Notes'',''$Guest'',''$NumCpu'',''$CoresPerSocket'',Cast(''$MemoryMB'' as REAL),Cast(''$MemoryGB'' as REAL),
   ''$VMHost'',''$Folder'',''$ResourcePoolId'',''$ResourcePool'',''$HARestartPriority'',''$HAIsolationResponse'',
   ''$DrsAutomationLevel'',''$VMSwapfilePolicy'',''$VMResourceConfiguration'',''$Version'',''$HardwareVersion'',
   ''$PersistentId'',''$GuestId'',Cast(''$UsedSpaceGB'' as REAL),Cast(''$ProvisionedSpaceGB'' as REAL),''$DatastoreIdList'',''$CreateDate'');"        

   #Executa o comando de insert com os dados
   try{
    $SQLQuery1Output = Invoke-Sqlcmd -query $SQLQuery -ServerInstance $SQLInstance -ErrorAction stop
}catch{
Write-Output $SQLQuery
throw $_
break
}
#Fim do loop da matriz com os usuário
}   
', 
		@database_name=N'master', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Nutanix]    Script Date: 22/11/2023 15:53:18 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Nutanix', 
		@step_id=4, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=3, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'PowerShell', 
		@command=N'pwsh.exe -command "D:\ETL\00_1_vm.ps1"', 
		@database_name=N'master', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [ServerHost]    Script Date: 22/11/2023 15:53:18 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'ServerHost', 
		@step_id=5, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=3, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'DECLARE @RC int

EXECUTE @RC = [dbo].[SP_carga_nx_ServerHost_Servidor] 
EXECUTE @RC = [dbo].[SP_carga_VMware_ServerHost_Servidor] 

/* REMOVER DA TABELA OS SERVIDORES QUE FORAM DELETADOS NA ORIGEM*/

DELETE SH FROM [ServerHost].[Servidor] AS SH
	LEFT JOIN [staging].[sccm_vw_server_host] SC
		ON RTRIM(LTRIM(SH.[HostName])) = RTRIM(LTRIM(SC.[HostName]))
	LEFT JOIN [staging].[VMware] AS VW
		ON RTRIM(LTRIM(SH.[HostName])) = RTRIM(LTRIM(VW.[Name]))
	LEFT JOIN [staging].[NutanixVM] AS NX
		ON RTRIM(LTRIM(SH.[HostName])) = RTRIM(LTRIM(NX.[vmName]))
	LEFT JOIN [staging].[ADComputer] AD
		ON RTRIM(LTRIM(SH.[HostName])) = RTRIM(LTRIM(AD.[Name]))
WHERE SC.HostName IS NULL
AND VW.Name IS NULL
AND NX.vmName IS NULL
AND AD.Name IS NULL', 
		@database_name=N'inventario', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'Diário 23:00', 
		@enabled=1, 
		@freq_type=4, 
		@freq_interval=1, 
		@freq_subday_type=1, 
		@freq_subday_interval=0, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=0, 
		@active_start_date=20230130, 
		@active_end_date=99991231, 
		@active_start_time=230000, 
		@active_end_time=235959, 
		@schedule_uid=N'f878cbc9-690f-41d6-99ff-8ef87c1e7c4e'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:
GO



````