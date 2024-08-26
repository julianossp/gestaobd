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
CREATE TABLE IF NOT EXISTS `comclien` (
  `n_numeclien` int(11) NOT NULL AUTO_INCREMENT,
  `c_codiclien` varchar(10) DEFAULT NULL,
  `c_nomeclien` varchar(50) DEFAULT NULL,
  `c_razaclien` varchar(50) DEFAULT NULL,
  `d_dataclien` date DEFAULT NULL,
  `c_cnpjclien` varchar(15) DEFAULT NULL,
  `c_foneclien` varchar(15) DEFAULT NULL
  PRIMARY KEY (`n_numeclien`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Copiando dados para a tabela comercial.comclien: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `comclien` DISABLE KEYS */;
/*!40000 ALTER TABLE `comclien` ENABLE KEYS */;

-- Copiando estrutura para tabela comercial.comforne
CREATE TABLE IF NOT EXISTS `comforne` (
  `n_numeforne` int(11) NOT NULL AUTO_INCREMENT,
  `c_codiforne` varchar(10) DEFAULT NULL,
  `c_nomeforne` varchar(50) DEFAULT NULL,
  `c_razaforne` varchar(50) DEFAULT NULL,
  `c_foneforne` varchar(15) DEFAULT NULL,
  PRIMARY KEY (`n_numeforne`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Copiando dados para a tabela comercial.comforne: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `comforne` DISABLE KEYS */;
/*!40000 ALTER TABLE `comforne` ENABLE KEYS */;

-- Copiando estrutura para tabela comercial.comivenda
CREATE TABLE IF NOT EXISTS `comivenda` (
  `n_numeivenda` int(11) NOT NULL AUTO_INCREMENT,
  `n_numevenda` int(11) NOT NULL,
  `n_numeprodu` int(11) NOT NULL,
  `n_valoivenda` float(10,2) DEFAULT NULL,
  `n_qtdeivenda` int(11) DEFAULT NULL,
  `n_descivenda` float(10,2) DEFAULT NULL,
  PRIMARY KEY (`n_numeivenda`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Copiando dados para a tabela comercial.comivenda: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `comivenda` DISABLE KEYS */;
/*!40000 ALTER TABLE `comivenda` ENABLE KEYS */;

-- Copiando estrutura para tabela comercial.comprodu
CREATE TABLE IF NOT EXISTS `comprodu` (
  `n_numeprodu` int(11) NOT NULL AUTO_INCREMENT,
  `c_codiprodu` varchar(20) DEFAULT NULL,
  `c_descprodu` varchar(100) DEFAULT NULL,
  `n_valoprodu` float(10,2) DEFAULT NULL,
  `c_situprodu` varchar(1) DEFAULT NULL,
  `n_numeforne` int(11) DEFAULT NULL,
  PRIMARY KEY (`n_numeprodu`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Copiando dados para a tabela comercial.comprodu: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `comprodu` DISABLE KEYS */;
/*!40000 ALTER TABLE `comprodu` ENABLE KEYS */;

-- Copiando estrutura para tabela comercial.comvenda
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
  PRIMARY KEY (`n_numevenda`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Copiando dados para a tabela comercial.comvenda: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `comvenda` DISABLE KEYS */;
/*!40000 ALTER TABLE `comvenda` ENABLE KEYS */;

-- Copiando estrutura para tabela comercial.comvende
CREATE TABLE IF NOT EXISTS `comvende` (
  `n_numevende` int(11) NOT NULL AUTO_INCREMENT,
  `c_codivende` varchar(10) DEFAULT NULL,
  `c_nomevende` varchar(50) DEFAULT NULL,
  `c_razavende` varchar(50) DEFAULT NULL,
  `c_fonevende` varchar(50) DEFAULT NULL,
  `n_porcvende` float(10,2) DEFAULT NULL,
  PRIMARY KEY (`n_numevende`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Copiando dados para a tabela comercial.comvende: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `comvende` DISABLE KEYS */;
/*!40000 ALTER TABLE `comvende` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
