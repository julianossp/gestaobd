--cria novo usuário
CREATE USER usermysql@'%' IDENTIFIED BY 'cursomysql';
-- lista todos os usuários cadastrados
SELECT user FROM mysql.user;
-- adiciona todos os privilégios para usermysql
GRANT ALL PRIVILEGES ON *.* TO usermysql@'%'
--lista dados dos usuários
SELECT User, Host, PASSWORD, Process_priv FROM mysql.user;
--descreve a tabela
 desc mysql.user;
 --revoga todos os privilégios
 REVOKE ALL ON *.* FROM usermysql;
 --mostra todos os bds 
 SHOW DATABASES 
-- concede privilégios para abrir o BD gestaodb
GRANT ALL PRIVILEGES
  ON gestaodb.`*`
  TO usermysql@'%';
 --revoga os privilégio de abrir gestaodb 
 REVOKE ALL PRIVILEGES
   ON gestaodb.`*`
  FROM  usermysql@'%';
  
  --concede privilegios para abrir apenas AS tabelas especificadas
  GRANT ALL PRIVILEGES 
  ON gestaodb.colaboradores 
  TO usermysql@'%';
-- listar as permissões do usuário
 SHOW GRANTS FOR usermysql@'%'
 
