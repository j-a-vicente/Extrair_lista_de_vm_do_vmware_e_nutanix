# Alterando os scripts de extração.

## Nutanix:
O script <b>[00_vm.ps1](/script_extracao/nutanix/00_vm.ps1)</b> é o responsavel por extrair os dados do servidor e gravar no banco de dados.

Alter os parâmetros:

````
#Variáveis do servido e banco de dados
$SQLInstance = "XXXXXXXXXX" # Nome da estância de banco de dados
$SQLDatabase = "XXXXXXXXXX" # Nome da base de dados
````

````
#Carrega a senha do usuário para conexão.
$pass = ConvertTo-SecureString -string "xxxxxxxx" -force -AsPlainText

# Comando para conectar no servidor Central do Nutanix.
Connect-NTNXPrismCentral -Server 127.0.0.1 -UserName loginNutanix@contoso.com.br -Password $pass -AcceptInvalidSslCerts -ForcedConnection

````

# VMWare5x e VMWare6x:
O script <b>[00_vm.ps1](/script_extracao/vmware_6x/00_vm.ps1)</b> é o responsável por extrair os dados do servidor e gravar no banco de dados.

Alter os parâmetros:

````
#Variáveis do servido e banco de dados
$SQLInstance = "XXXXXXXXXX" # Nome da estância de banco de dados
$SQLDatabase = "XXXXXXXXXX" # Nome da base de dados
````

````
# são varios servidor com isto estamos conectando apenas um nesta linha
Connect-VIServer -Server vm00.aero.vms.contoso.com.br -User svc_usr__ext_vm@contoso.gov.br -Password P@ssw0rd2023 

````
