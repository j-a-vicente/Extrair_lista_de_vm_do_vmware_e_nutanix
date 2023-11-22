# Este script foi criado para extrair as VM do virtualizado VMware.

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
   VALUES  ('$Id','$Name','$PowerState','$Notes','$Guest','$NumCpu','$CoresPerSocket',Cast('$MemoryMB' as REAL),Cast('$MemoryGB' as REAL),
   '$VMHost','$Folder','$ResourcePoolId','$ResourcePool','$HARestartPriority','$HAIsolationResponse',
   '$DrsAutomationLevel','$VMSwapfilePolicy','$VMResourceConfiguration','$Version','$HardwareVersion',
   '$PersistentId','$GuestId',Cast('$UsedSpaceGB' as REAL),Cast('$ProvisionedSpaceGB' as REAL),'$DatastoreIdList','$CreateDate');"        

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
