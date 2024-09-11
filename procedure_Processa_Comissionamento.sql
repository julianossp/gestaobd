CREATE DEFINER=`root`@`%` PROCEDURE `processa_comissionamento`(
	IN data_inicial DATE,
	IN data_final DATE,
	OUT total_processado INT)
BEGIN
		DECLARE total_venda FLOAT(10,2) DEFAULT 0;
		DECLARE venda INT DEFAULT 0;
		DECLARE vendedor INT DEFAULT 0;
		DECLARE comissao FLOAT(10,2) DEFAULT 0;
		DECLARE valor_comissao FLOAT(10,2) DEFAULT 0;
		DECLARE aux INT DEFAULT 0;
		DECLARE fimloop INT DEFAULT 0;
/*
cursor para buscar os registros a serem processados entre a data inicial e data final e valor total de venda é maior que zero.
*/		
		DECLARE busca_pedido CURSOR FOR
			SELECT n_numevenda, n_totavenda, n_numevende
			FROM comvenda
			WHERE d_datavenda BETWEEN data_inicial 
			AND data_final AND n_totavenda > 0;
	/* rotina de tratamento para o banco de dados não executar o loop quando ele terminar, evitando que retorne erro.
*/
		DECLARE CONTINUE handler FOR SQLSTATE '02000' SET fimloop = 1;
# Inicio do loop
	 	vendas: LOOP
		#verifica se o loop terminou e saio do loop
		if fimloop = 1 then 
			leave vendas;
		END if;	
		#recebe o resultado da consulta em cada variável
		fetch busca_pedido INTO venda, total_venda, vendedor;
		#busca o valor do percentual de cada vendedor
		SELECT n_porcvende INTO comissao
		FROM comvende
		WHERE n_numevende = vendedor;
		#verifica se o percentual do vendedor é maior
		#que zero logo após a condição deve ter o then
		if (comissao > 0) then
			##calcula o valor da comissão
			SET valor_comissao =  ((total_venda * comissao) /100);
			#atualiza (update) a tabela comvenda com o valor da comissão
			UPDATE comvenda SET n_vcomvenda = valor_comissao WHERE n_numevenda = venda;
			COMMIT;
			
/*verifica se o percentual do vendedor é igual a zero na regra do nosso sistema se o vendedor tem 0 ele ganha 0 porcento de comissão 
*/
		ELSEIF (comissao= 0) then
			UPDATE comvenda SET n_vcomvenda = 0 
			WHERE n_numevenda = venda;
			COMMIT;
/* se o vendedor nao possuir registro no percentual de comissao ele irá ganhar 1 de comissao isso pela regra de negocio do sistema.
*/
	ELSE 
		SET comissao = 1;
		SET valor_comissao = ((total_venda * comissao) /100);
		UPDATE comvenda SET n_vcomvenda = valor_comissao WHERE n_numevenda = venda;
		COMMIT;
		#encerra o if
	END if;
	
				set comissao = 0;
				##utilizo a variável aux para contar a quantidade
				set  aux = aux +1 ;
			end loop vendas;
				## atribuo o total de vendas para a variável de
				## saída
			set total_processado = aux;
			## fecho o cursor
			close busca_pedido;
		
			##retorno o total de vendas processadas
 	END