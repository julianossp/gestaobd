Avaliação de gestão de Banco de dados. 23/09/2024

Insira todos os comandos sql desta avaliação em um arquivo texto. Ex. avaliacao.sql

- Crie um novo banco de dados com o nome: rh
- Crie um usuário com todos os privilégios para abrir apenas o banco de dados rh
    nome: rhuser, senha: Libert@s
- abra o banco de dados rh.
- insira as tabelas abaixo:

CREATE TABLE funcionarios (
  id_funcionario INT PRIMARY KEY AUTO_INCREMENT,
  nome VARCHAR(50) NOT NULL,
  sobrenome VARCHAR(50) NOT NULL,
  data_nascimento DATE,
  id_cargo VARCHAR(20),
  id_departamento INT,
  salario DECIMAL(10,2)
);

CREATE TABLE departamentos (
  id_departamento INT PRIMARY KEY AUTO_INCREMENT,
  nome_departamento VARCHAR(50) NOT NULL
);

CREATE TABLE cargos (
  id_cargo VARCHAR(20) PRIMARY KEY,
  nome_cargo VARCHAR(50) NOT NULL
);

CREATE TABLE treinamentos (
  id_treinamento INT PRIMARY KEY AUTO_INCREMENT,
  nome_treinamento VARCHAR(100) NOT NULL,
  data_inicio DATE,
  data_fim DATE,
  carga_horaria INT,
  local VARCHAR(100),
  ministrante VARCHAR(100),
  id_funcionario INT
);

- Crie as chaves estrangeiras (foreign key), analise cada tabela e faça os relacionamentos (UPDATE:NO ACTION, DELETE: RESTRICT)
- Popule as tabelas importando os arquivos CSVs.
- Adicione (crie) 1 funcionário no departamento Markenting e mais 1 no financeiro.
- Insira o "insert" abaixo para popular a tabela treinamentos.

INSERT INTO treinamentos (nome_treinamento, data_inicio, data_fim, carga_horaria, `local`, ministrante, id_funcionario)
VALUES
  ('Introdução ao SQL', '2024-01-01', '2024-01-05', 20, 'Sala de treinamento', 'João Silva', 1),
  ('Gestão de Projetos', '2024-03-15', '2024-03-20', 30, 'Auditório', 'Maria Santos', 2),
  ('Desenvolvimento Web', '2024-05-10', '2024-05-25', 40, 'Laboratório', 'Pedro Almeida', 3);

- Adicione pelo menos 1 treinamento para cada funcionário
- Listar todos o registros de cargos, departamentos, funcionários e treinamentos.
- Listar nome, sobrenome, nome do cargo, nome do departamento e salário.
- Listar apenas os funcionários 1,3,5.
- Listar o maior e o menor salário.
- Listar nome e sobrenome concatenados (numa coluna só) e o salário. 
- Listar todos os funcionários do departamento de Tecnologia da Informação:
- Calcular a média salarial
- Listar os funcionários que fazem aniversário em janeiro:
- Calcular a idade média dos funcionários:
- Listar os funcionários que realizaram um determinado treinamento
ex: Introdução ao SQL
- Listar quantos dias faltam para o final do ano (31/12/2024).
- Listar a data e hora atual.
- Exportar banco de dados para um arquivo SQL (estrutura e dados).
- Compacte o arquivo exportado, mais o arquivo texto com todos os comandos e envie para o portal do aluno.




