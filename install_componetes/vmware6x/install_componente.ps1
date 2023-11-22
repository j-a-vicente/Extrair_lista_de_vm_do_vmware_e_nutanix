# Verificar se qual versão está disponivel para instalação
#Find-Module -Name VMware.PowerCLI

# Instalar componente.
#Install-Module -Name VMware.PowerCLI -Scope CurrentUser

# Quando o comando acima da erro de instalação
#Install-Module -Name VMware.PowerCLI -AllowClobber


#Connect-VIServer -Server XXX-vcenter1 -User administrator@vsphere.local -Password XXXXXXXXXXXX

Get-VM 