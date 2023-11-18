--Schema padrão do banco, será usuado para armazerna os objetos que serão de uso comum entre os outros schemas
--dbo
    
--O schema será utilizado para agregar os objetos voltados as maquina ou servidores
CREATE SCHEMA [ServerHost]
GO
--O schema será utilizado para agregar os objetos dos Gerenciadores de banco de dados
CREATE SCHEMA [SGBD]
GO

-- O schema de auditoria.
CREATE SCHEMA [auditing]
GO
-- O schema app é para armazenar os objetos de aplicação.
CREATE SCHEMA [app]
GO
-- O schema UserGroup é para armazenar os objetos do usuários e grupos do AD.
CREATE SCHEMA [UserGroup]
GO
-- O schema staging é para armazenar os objetos em transição no banco.
CREATE SCHEMA [staging]
GO


