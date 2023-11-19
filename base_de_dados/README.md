# Estrutura de dados.

Como os dados são carregados totalmente a cada carraga, as tabelas não são normatizadas e não exites chave extrangeira entre elas.

### Tabelas
|Schemas  |Tabelas   |Descrição  |
|---|----|-----|
|dbo | trilha | As trilhas dos ambientes "Produção","Homologação"....|
|ServerHost | Servidor | A relação consolidade das VM. |
|staging | NutanixVM | Carga temporaria Nutanix |  
|staging | VMware    | Carga temporaria VMware |

<p></p>
<p></p>

![Alt text](../imagens/db_inventario.PNG)

### Consolidando os dados
A consolidação das duas origens VMware e Nutanix são executadas atravez das Stored Procedures:

|Schema  |Stored Procedure                     | Descrição    |
|--------|-------------------------------------|--------------|
|staging |SP_carga_nx_ServerHost_Servidor      | Executar carga de dados na tabelas <b>ServerHost.Servidor</b> |
|staging |SP_carga_VMware_ServerHost_Servidor  | Executar carga de dados na tabelas <b>ServerHost.Servidor</b> |