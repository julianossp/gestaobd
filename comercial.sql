-- --------------------------------------------------------
-- Servidor:                     127.0.0.1
-- Versão do servidor:           10.10.3-MariaDB-1:10.10.3+maria~ubu2204-log - mariadb.org binary distribution
-- OS do Servidor:               debian-linux-gnu
-- HeidiSQL Versão:              11.3.0.6295
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

-- Copiando estrutura para tabela comercial.comclien
DROP TABLE IF EXISTS `comclien`;
CREATE TABLE IF NOT EXISTS `comclien` (
  `n_numeclien` int(11) NOT NULL AUTO_INCREMENT,
  `c_codiclien` varchar(10) DEFAULT NULL,
  `c_nomeclien` varchar(50) DEFAULT NULL,
  `c_razaclien` varchar(50) DEFAULT NULL,
  `d_dataclien` date DEFAULT NULL,
  `c_cnpjclien` varchar(20) DEFAULT NULL,
  `c_foneclien` varchar(15) DEFAULT NULL,
  `c_cidaclien` varchar(50) DEFAULT NULL,
  `c_estaclien` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`n_numeclien`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Copiando dados para a tabela comercial.comclien: ~10 rows (aproximadamente)
/*!40000 ALTER TABLE `comclien` DISABLE KEYS */;
REPLACE INTO `comclien` (`n_numeclien`, `c_codiclien`, `c_nomeclien`, `c_razaclien`, `d_dataclien`, `c_cnpjclien`, `c_foneclien`, `c_cidaclien`, `c_estaclien`) VALUES
	(1, '0001', 'AARONSON FURNITURE', 'AARONSON FURNITURE LTD', '2015-02-17', '17.807.928/0001-85', '(21) 8167-6584', 'QUEIMADOS', 'RJ'),
	(2, '0002', 'LITTLER ', 'LITTLER  LTDA', '2015-02-17', '55.643.605/0001-92', '(27) 7990-9502', 'SERRA', 'ES'),
	(3, '0003', 'KELSEY  NEIGHBOURHOOD', 'KELSEY  NEIGHBOURHOOD', '2015-02-17', '05.202.361/0001-34', '(11) 4206-9703', 'BRAGANÇA PAULISTA', 'SP'),
	(4, '0004', 'GREAT AMERICAN MUSIC', 'GREAT AMERICAN MUSIC', '2015-02-17', '11.880.735/0001-73', '(75) 7815-7801', 'SANTO ANTÔNIO DE JESUS', 'BA'),
	(5, '0005', 'LIFE PLAN COUNSELLING', 'LIFE PLAN COUNSELLING', '2015-02-17', '75.185.467/0001-52', '(17) 4038-9355', 'BEBEDOURO', 'SP'),
	(6, '0006', 'PRACTI-PLAN', 'PRACTI-PLAN LTDA', '2015-02-17', '32.518.106/0001-78', '(28) 2267-6159', 'CACHOEIRO DE ITAPEMIRI', 'ES'),
	(7, '0007', 'SPORTSWEST', 'SPORTSWEST LTDA', '2015-02-17', '83.175.645/0001-92', '(61) 4094-7184', 'TAGUATINGA', 'DF'),
	(8, '0008', 'HUGHES MARKETS', 'HUGHES MARKETS LTDA', '2015-02-17', '04.728.160/0001-02', '(21) 7984-9809', 'RIO DE JANEIRO', 'RJ'),
	(9, '0009', 'AUTO WORKS', 'AUTO WORKS LTDA', '2015-02-17', '08.271.985/0001-00', '(21) 8548-5555', 'RIO DE JANEIRO', 'RJ'),
	(10, '00010', 'DAHLKEMPER ', 'DAHLKEMPER  LTDA', '2015-02-17', '49.815.047/0001-00', '(11) 4519-7670', 'SÃO PAULO', 'SP');
/*!40000 ALTER TABLE `comclien` ENABLE KEYS */;

-- Copiando estrutura para tabela comercial.comforne
DROP TABLE IF EXISTS `comforne`;
CREATE TABLE IF NOT EXISTS `comforne` (
  `n_numeforne` int(11) NOT NULL AUTO_INCREMENT,
  `c_codiforne` varchar(10) DEFAULT NULL,
  `c_nomeforne` varchar(50) DEFAULT NULL,
  `c_razaforne` varchar(50) DEFAULT NULL,
  `c_foneforne` varchar(15) DEFAULT NULL,
  PRIMARY KEY (`n_numeforne`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Copiando dados para a tabela comercial.comforne: ~2 rows (aproximadamente)
/*!40000 ALTER TABLE `comforne` DISABLE KEYS */;
REPLACE INTO `comforne` (`n_numeforne`, `c_codiforne`, `c_nomeforne`, `c_razaforne`, `c_foneforne`) VALUES
	(1, '0001', 'DUN RITE LAWN MAINTENANCE', 'DUN RITE LAWN MAINTENANCE LTDA', '(85) 7886-8837'),
	(2, '0002', 'SEWFRO FABRICS', 'SEWFRO FABRICS LTDA', '(91) 5171-8483');
/*!40000 ALTER TABLE `comforne` ENABLE KEYS */;

-- Copiando estrutura para tabela comercial.comivenda
DROP TABLE IF EXISTS `comivenda`;
CREATE TABLE IF NOT EXISTS `comivenda` (
  `n_numeivenda` int(11) NOT NULL AUTO_INCREMENT,
  `n_numevenda` int(11) NOT NULL,
  `n_numeprodu` int(11) NOT NULL,
  `n_valoivenda` float(10,2) DEFAULT NULL,
  `n_qtdeivenda` int(11) DEFAULT NULL,
  `n_descivenda` float(10,2) DEFAULT NULL,
  PRIMARY KEY (`n_numeivenda`),
  KEY `fk_comivenda_comprodu` (`n_numeprodu`),
  KEY `fk_comivenda_comvenda` (`n_numevenda`),
  CONSTRAINT `fk_comivenda_comprodu` FOREIGN KEY (`n_numeprodu`) REFERENCES `comprodu` (`n_numeprodu`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_comivenda_comvenda` FOREIGN KEY (`n_numevenda`) REFERENCES `comvenda` (`n_numevenda`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Copiando dados para a tabela comercial.comivenda: ~41 rows (aproximadamente)
/*!40000 ALTER TABLE `comivenda` DISABLE KEYS */;
REPLACE INTO `comivenda` (`n_numeivenda`, `n_numevenda`, `n_numeprodu`, `n_valoivenda`, `n_qtdeivenda`, `n_descivenda`) VALUES
	(1, 1, 1, 1251.29, 1, 0.00),
	(2, 1, 2, 1242.21, 2, 0.00),
	(3, 1, 3, 1241.21, 3, 0.00),
	(4, 1, 4, 1513.77, 4, 0.00),
	(5, 1, 5, 2325.32, 5, 0.00),
	(6, 2, 1, 1251.29, 6, 0.00),
	(7, 3, 3, 1241.21, 7, 0.00),
	(8, 4, 1, 1251.29, 1, 0.00),
	(9, 5, 3, 1241.21, 2, 0.00),
	(10, 6, 1, 1251.29, 3, 0.00),
	(11, 7, 2, 1242.21, 4, 0.00),
	(12, 8, 5, 2325.32, 5, 0.00),
	(13, 9, 2, 1242.21, 6, 0.00),
	(14, 10, 3, 1241.21, 7, 0.00),
	(15, 11, 1, 1251.29, 1, 0.00),
	(16, 12, 1, 1251.29, 2, 0.00),
	(17, 13, 2, 1242.21, 3, 0.00),
	(18, 14, 2, 1242.21, 4, 0.00),
	(19, 15, 3, 1241.21, 5, 0.00),
	(20, 16, 3, 1241.21, 6, 0.00),
	(21, 17, 4, 1513.77, 7, 0.00),
	(22, 18, 4, 1513.77, 1, 0.00),
	(23, 19, 5, 2325.32, 2, 0.00),
	(24, 20, 5, 2325.32, 3, 0.00),
	(25, 2, 2, 1242.21, 4, 0.00),
	(26, 3, 4, 1513.77, 5, 0.00),
	(27, 4, 2, 1242.21, 6, 0.00),
	(28, 5, 4, 1513.77, 7, 0.00),
	(29, 6, 5, 2325.32, 1, 0.00),
	(30, 7, 3, 1241.21, 2, 0.00),
	(31, 8, 1, 1251.29, 3, 0.00),
	(32, 9, 4, 1513.77, 4, 0.00),
	(33, 10, 5, 2325.32, 5, 0.00),
	(34, 11, 2, 1242.21, 6, 0.00),
	(35, 12, 2, 1242.21, 7, 0.00),
	(36, 13, 3, 1241.21, 1, 0.00),
	(37, 14, 3, 1241.21, 2, 0.00),
	(38, 15, 4, 1513.77, 3, 0.00),
	(39, 16, 4, 1513.77, 4, 0.00),
	(40, 17, 5, 2325.32, 5, 0.00),
	(41, 18, 5, 2325.32, 6, 0.00);
/*!40000 ALTER TABLE `comivenda` ENABLE KEYS */;

-- Copiando estrutura para tabela comercial.comprodu
DROP TABLE IF EXISTS `comprodu`;
CREATE TABLE IF NOT EXISTS `comprodu` (
  `n_numeprodu` int(11) NOT NULL AUTO_INCREMENT,
  `c_codiprodu` varchar(20) DEFAULT NULL,
  `c_descprodu` varchar(100) DEFAULT NULL,
  `n_valoprodu` float(10,2) DEFAULT NULL,
  `c_situprodu` varchar(1) DEFAULT NULL,
  `n_numeforne` int(11) DEFAULT NULL,
  PRIMARY KEY (`n_numeprodu`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Copiando dados para a tabela comercial.comprodu: ~5 rows (aproximadamente)
/*!40000 ALTER TABLE `comprodu` DISABLE KEYS */;
REPLACE INTO `comprodu` (`n_numeprodu`, `c_codiprodu`, `c_descprodu`, `n_valoprodu`, `c_situprodu`, `n_numeforne`) VALUES
	(1, '123131', 'NOTEBOOK', 1251.29, 'A', 1),
	(2, '123223', 'SMARTPHONE', 1242.21, 'A', 2),
	(3, '1231', 'DESKTOP', 1241.21, 'A', 1),
	(4, '142123', 'TELEVISÃO', 2564.92, 'A', 2),
	(5, '7684', 'DRONE', 2325.32, 'A', 1);
/*!40000 ALTER TABLE `comprodu` ENABLE KEYS */;

-- Copiando estrutura para tabela comercial.comvenda
DROP TABLE IF EXISTS `comvenda`;
CREATE TABLE IF NOT EXISTS `comvenda` (
  `n_numevenda` int(11) NOT NULL AUTO_INCREMENT,
  `c_codivenda` varchar(10) DEFAULT NULL,
  `n_numeclien` int(11) NOT NULL,
  `n_numeforne` int(11) NOT NULL,
  `n_numevende` int(11) NOT NULL,
  `n_valovenda` float(10,2) DEFAULT NULL,
  `n_descvenda` float(10,2) DEFAULT NULL,
  `n_totavenda` float(10,2) DEFAULT NULL,
  `d_datavenda` date DEFAULT NULL,
  `n_vcomvenda` float(10,2) DEFAULT NULL,
  PRIMARY KEY (`n_numevenda`),
  KEY `fk_comprodu_comforne` (`n_numeforne`),
  KEY `fk_comvenda_comclien` (`n_numeclien`),
  KEY `fk_comprodu_comvende` (`n_numevende`),
  CONSTRAINT `fk_comprodu_comforne` FOREIGN KEY (`n_numeforne`) REFERENCES `comforne` (`n_numeforne`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_comprodu_comvende` FOREIGN KEY (`n_numevende`) REFERENCES `comvende` (`n_numevende`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_comvenda_comclien` FOREIGN KEY (`n_numeclien`) REFERENCES `comclien` (`n_numeclien`) ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Copiando dados para a tabela comercial.comvenda: ~20 rows (aproximadamente)
/*!40000 ALTER TABLE `comvenda` DISABLE KEYS */;
REPLACE INTO `comvenda` (`n_numevenda`, `c_codivenda`, `n_numeclien`, `n_numeforne`, `n_numevende`, `n_valovenda`, `n_descvenda`, `n_totavenda`, `d_datavenda`, `n_vcomvenda`) VALUES
	(1, '1', 1, 1, 1, 25141.02, 0.00, 25141.02, '2015-01-01', 3016.92),
	(2, '2', 2, 2, 2, 12476.58, 0.00, 12476.58, '2015-01-02', 3119.15),
	(3, '3', 3, 1, 1, 16257.32, 0.00, 16257.32, '2015-01-03', 1950.88),
	(4, '4', 4, 2, 2, 8704.55, 0.00, 8704.55, '2015-01-04', 2176.14),
	(5, '5', 5, 1, 1, 13078.81, 0.00, 13078.81, '2015-01-01', 1569.46),
	(6, '6', 6, 2, 2, 6079.19, 0.00, 6079.19, '2015-01-02', 1519.80),
	(7, '7', 7, 1, 1, 7451.26, 0.00, 7451.26, '2015-01-03', 894.15),
	(8, '8', 8, 2, 2, 15380.47, 0.00, 15380.47, '2015-01-04', 3845.12),
	(9, '9', 9, 1, 1, 13508.34, 0.00, 13508.34, '2015-01-01', 1621.00),
	(10, '10', 1, 2, 2, 20315.07, 0.00, 20315.07, '2015-01-02', 5078.77),
	(11, '11', 1, 1, 1, 8704.55, 0.00, 8704.55, '2015-01-01', 1044.55),
	(12, '12', 2, 2, 2, 11198.05, 0.00, 11198.05, '2015-01-02', 2799.51),
	(13, '13', 3, 1, 1, 4967.84, 0.00, 4967.84, '2015-01-03', 596.14),
	(14, '14', 3, 2, 2, 7451.26, 0.00, 7451.26, '2015-01-04', 1862.81),
	(15, '15', 5, 1, 1, 10747.36, 0.00, 10747.36, '2015-01-01', 1289.68),
	(16, '16', 6, 2, 2, 13502.34, 0.00, 13502.34, '2015-01-02', 3375.58),
	(17, '17', 7, 1, 1, 22222.99, 0.00, 22222.99, '2015-01-03', 2666.76),
	(18, '18', 8, 2, 2, 15465.69, 0.00, 15465.69, '2015-01-04', 3866.42),
	(19, '19', 9, 1, 1, 4650.64, 0.00, 4650.64, '2015-01-01', 558.08),
	(20, '20', 9, 2, 2, 6975.96, 0.00, 6975.96, '2015-01-02', 1743.99);
/*!40000 ALTER TABLE `comvenda` ENABLE KEYS */;

-- Copiando estrutura para tabela comercial.comvende
DROP TABLE IF EXISTS `comvende`;
CREATE TABLE IF NOT EXISTS `comvende` (
  `n_numevende` int(11) NOT NULL AUTO_INCREMENT,
  `c_codivende` varchar(10) DEFAULT NULL,
  `c_nomevende` varchar(50) DEFAULT NULL,
  `c_razavende` varchar(50) DEFAULT NULL,
  `c_fonevende` varchar(50) DEFAULT NULL,
  `n_porcvende` float(10,2) DEFAULT NULL,
  PRIMARY KEY (`n_numevende`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Copiando dados para a tabela comercial.comvende: ~2 rows (aproximadamente)
/*!40000 ALTER TABLE `comvende` DISABLE KEYS */;
REPLACE INTO `comvende` (`n_numevende`, `c_codivende`, `c_nomevende`, `c_razavende`, `c_fonevende`, `n_porcvende`) VALUES
	(1, '0001', 'CARLOS FERNANDES', 'CARLOS FERNANDES LTDA', '(47) 7535-8144', 12.00),
	(2, '0002', 'JÚLIA	GOMES', 'JÚLIA GOMES LTDA', '(12) 8037-6661', 25.00);
/*!40000 ALTER TABLE `comvende` ENABLE KEYS */;

-- Copiando estrutura para procedure comercial.processa_comissionamento
DROP PROCEDURE IF EXISTS `processa_comissionamento`;
DELIMITER //
CREATE PROCEDURE `processa_comissionamento`(
in  data_inicial     date,
in  data_final       date  ,
out total_processado int )
BEGIN
# Declara as variáveis
declare total_venda    float(10,2) default 0;
declare venda          int         default 0;
declare vendedor       int         default 0;
declare comissao       float(10,2) default 0;
declare valor_comissao float(10,2) default 0;
declare aux            int         default 0;
declare fimloop        int default 0;

## gera o cursor para buscar os registros a serem 
## processados entre a data inicial e data final
## e valor total de venda é maior que zero
declare busca_pedido cursor for 
	select n_numevenda,
	       n_totavenda,
		   n_numevende
	  from comvenda
	 where d_datavenda between data_inicial 
	 	and data_final
	  	and n_totavenda > 0 ;

## rotina para o banco não 
## executar o loop quando ele terminar
## evitando que retorne qualquer erro
declare 
continue handler 
for sqlstate '02000' 
set fimloop  = 1;


## abre o cursor				
open busca_pedido;
	
	## inicia do loop
	vendas: LOOP
	
	## Verifica que se o loop terminou
	## e sai do loop
	if fimloop  = 1 then 
	  leave  vendas;
	end if;
	
	##recebe o resultado da consulta em cada variável
	fetch busca_pedido into venda, total_venda, 
	vendedor;
	
	## busca o valor do percentual de cada vendedor
	select n_porcvende 
      into comissao 
      from comvende
     where n_numevende = vendedor;
	
	## verifica se o percentual do vendedor é maior
	## que zero logo após a condição deve ter o then
	if (comissao > 0 ) then 
	    ## calcular o valor da comissao
		set valor_comissao  = 
			((total_venda * comissao)  / 100);
		
		## faz o update na tabela comvenda com o 
		## valor da comissão
		update comvenda set 
		n_vcomvenda = valor_comissao
		where n_numevenda = venda;
		commit; 
	
	## verifica se o percentual do vendedor é igual 
	## zero na regra do nosso sistema se o vendedor 
	## tem 0 ele ganha 0 porcento de comissão
       elseif(comissao = 0) then
	    
		update comvenda set n_vcomvenda = 0
		where n_numevenda = venda;
		commit;
	
	## se ele não possuir registro no percentual de 
    ## comissão ele irá ganhar 1 de comissão
	## isso pela regra de negócio do nosso sistema
	else 
		set comissao = 1;
		set valor_comissao = 
			((total_venda * comissao)  / 100);
		
		update 
			comvenda set n_vcomvenda = valor_comissao
		where n_numevenda = venda;
		commit;  
	## fecho o if	 
	end if;
	
	set comissao = 0;
	##utiliza a variável aux para contar a quantidade
	set  aux      = aux +1 ;
end loop vendas;
	## atribuir o total de vendas para a variável de
	## saída
set total_processado = aux;
## fecha o cursor
close busca_pedido;

##retorna o total de vendas processadas


END//
DELIMITER ;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
