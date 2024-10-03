delimiter $$
CREATE TRIGGER `tri_venda_ai` 
	AFTER INSERT ON `comivenda` FOR EACH ROW BEGIN
	##declarar as variáveis
	DECLARE vtotal_itens FLOAT(10,2) DEFAULT 0;
	DECLARE total_item FLOAT(10,2) DEFAULT 0;
	DECLARE vtotvendas FLOAT(10,2) DEFAULT 0;
	DECLARE totvendas FLOAT(10,2) DEFAULT 0;
	DECLARE fimLoop BOOLEAN DEFAULT FALSE;
	##cursor para buscar os itens já registrados da venda
	DECLARE busca_itens CURSOR FOR 
	SELECT n_valoivenda, 
	(n_valoivenda * n_qtdeivenda) totvenda  
	FROM comivenda WHERE n_numevenda= NEW.n_numevenda;
	#handler para encerrar o loop antes da ultima linha
	DECLARE CONTINUE handler FOR SQLSTATE '02000'
	SET fimLoop= TRUE;
	##abir o cursor
	OPEN busca_itens;
	##declarar e iniciar o loop 
	itens : loop
	fetch busca_itens 
	INTO total_item, totvendas ;
	#encerrar o bloco quando o cursor não retornar mais linhas
	if fimLoop then
		leave itens;
	END if;
	#somar o valor total dos itens(produtos)
	SET vtotal_itens = vtotal_itens + total_item;
	SET vtotvendas = vtotvendas + totvendas;
 END loop itens;
 close busca_itens;
 #atualizar o total da venda
 UPDATE comvenda SET n_totavenda = vtotal_itens, 
 n_valovenda = vtotvendas
 WHERE n_numevenda = NEW.n_numevenda;
END
$$