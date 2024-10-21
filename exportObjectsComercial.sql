
#schedule criando agendamento
set global event_scheduler = on;

SELECT NOW();

#-------------------------------------------
DROP EVENT if EXISTS `processa_comissao`;
#----------------------------------
delimiter $$
create event `processa_comissao`
on schedule every 1 week starts '2024-09-12 20:30:00'
do
begin
  call processa_comissionamento(curdate() - interval 7 DAY, curdate(), @a );
END;
$$
/*
• on schedule every 1 year: uma vez por ano;
• on schedule every 1 month: uma vez por mês;
• on schedule every 1 month: uma vez por mês;
• on schedule every 1 day: uma vez ao dia;
• on schedule every 1 hour: uma vez por hora;
• on schedule every 1 minute: uma vez por minuto;
• on schedule every 1 second: uma vez por segundo.
*/

#-------------------------------------------
DROP FUNCTION if EXISTS `rt_percentual_comissao`;
#-------------------------------------------
/*cria um função para ser usada na trigger*/
delimiter $$
CREATE FUNCTION rt_percentual_comissao(vn_n_numevende INT) 
RETURNS FLOAT  
BEGIN 
	
	DECLARE percentual_comissao FLOAT(10,2);
	SELECT n_porcvende INTO percentual_comissao
	FROM comvende
	WHERE n_numevende = vn_n_numevende; 

	RETURN percentual_comissao;

end;
$$
#-------------------------------------------
SELECT rt_percentual_comissao(1);
SELECT rt_percentual_comissao(2);
#-------------------------------------------

#-------------------------------------------
DROP FUNCTION if EXISTS `rt_nome_cliente`;
#-------------------------------------------
delimiter $$
create function rt_nome_cliente(vn_numeclien INT)
returns varchar(50) DETERMINISTIC 

begin
	declare nome varchar(50);

	select c_nomeclien  into nome
	  from comclien
	where n_numeclien = vn_numeclien;
 
	return nome;
END;  
$$

#-------------------------------------------
drop trigger if EXISTS tri_vendas_bi;
#-------------------------------------------
/*criar a trigger*/
delimiter $$
create trigger tri_vendas_bi
before insert on comvenda 
for each row

begin
  declare percentual_comissao float(10,2);
  declare valor_comissao      float(10,2);
  
  ## busca o percentual de comissão que o vendedor deve
  ## receber
  select rt_percentual_comissao(new.n_numevende)
    into percentual_comissao;
  
  ## calcula a comissão
  set valor_comissao = ((new.n_totavenda * percentual_comissao)  / 100);
  
  ## recebe no novo valor de comissão
  set new.n_vcomvenda = valor_comissao;
	
end;
$$

#----------------------------------------
drop trigger if EXISTS tri_vendas_bu;
#----------------------------------------
/*criar a trigger se houver alteração */
delimiter $$
create trigger tri_vendas_bu
before update on comvenda 
for each row

begin
declare percentual_comissao float(10,2);
declare valor_comissao      float(10,2);
	
  ## No update, verifica se o valor total novo da venda
  ## é diferente do total anterior, pois se forem iguais,
  ## não há necessidade do cálculo
  if (old.n_totavenda <> new.n_totavenda) then
  	select rt_percentual_comissao(new.n_numevende)
  	  into percentual_comissao;
    
  	## cálculo da comissão
  	set 
	valor_comissao = ((new.n_totavenda * percentual_comissao) / 100);

  	## recebo no novo valor de comissão
  	set new.n_vcomvenda = valor_comissao;
  end if;
end;
$$

#----------------------------------------
drop trigger if EXISTS tri_ivendas_ai;
#----------------------------------------
/*
Criar trigger em comivenda, itens da venda.
*/
delimiter $$
create trigger tri_ivendas_ai
after insert on comivenda 
for each row
BEGIN
	##declarar as variáveis
	DECLARE vtotal_itens FLOAT(10,2) DEFAULT 0;
	DECLARE vdesconto FLOAT(10,2) DEFAULT 0;
	DECLARE vtotvendas FLOAT(10,2) DEFAULT 0;
	DECLARE totvendas FLOAT(10,2) DEFAULT 0;
	DECLARE fimLoop BOOLEAN DEFAULT FALSE;
	##cursor para buscar os itens já registrados da venda
	DECLARE busca_itens CURSOR FOR 
	SELECT n_descivenda vdesconto, 
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
	INTO vdesconto, totvendas ;
	#encerrar o bloco quando o cursor não retornar mais linhas
	if fimLoop then
		leave itens;
	END if;
	#somar o valor total dos itens(produtos)
	SET vtotal_itens =vtotal_itens + totvendas - vdesconto ;
	SET vtotvendas = vtotvendas + totvendas;
 END loop itens;
 close busca_itens;
 #atualizar o total da venda
 UPDATE comvenda SET n_totavenda = vtotal_itens, 
 n_valovenda = vtotvendas, n_descvenda = vtotvendas - vtotal_itens
 WHERE n_numevenda = NEW.n_numevenda;
END;
$$


#----------------------------------------
drop trigger if EXISTS tri_ivendas_au;
#----------------------------------------
delimiter $$
CREATE TRIGGER `tri_ivendas_au` 
AFTER UPDATE ON `comivenda` 
FOR EACH ROW 
BEGIN
##declarar as variáveis
	DECLARE vtotal_itens FLOAT(10,2) DEFAULT 0;
	DECLARE vdesconto FLOAT(10,2) DEFAULT 0;
	DECLARE vtotvendas FLOAT(10,2) DEFAULT 0;
	DECLARE totvendas FLOAT(10,2) DEFAULT 0;
	DECLARE fimLoop BOOLEAN DEFAULT FALSE;
	##cursor para buscar os itens já registrados da venda
	DECLARE busca_itens CURSOR FOR 
	SELECT n_descivenda vdesconto, 
	(n_valoivenda * n_qtdeivenda) totvenda  
	FROM comivenda WHERE n_numevenda= OLD.n_numevenda;
	#handler para encerrar o loop antes da ultima linha
	DECLARE CONTINUE handler FOR SQLSTATE '02000'
	SET fimLoop= TRUE;
	
	## verificar se ha necessidade de alteração
	## faz somente se o novo valor for alterado
	if NEW.n_valoivenda <> OLD.n_valoivenda 
	OR NEW.n_qtdeivenda <> OLD.n_qtdeivenda 
	OR NEW.n_descivenda <> OLD.n_descivenda then
	 
	##abrir o cursor
	OPEN busca_itens;
	##declarar e iniciar o loop 
	itens : loop
	fetch busca_itens 
	INTO vdesconto, totvendas ;
	#encerrar o bloco quando o cursor não retornar mais linhas
	if fimLoop then
		leave itens;
	END if;
	#somar o valor total dos itens(produtos)
	SET vtotal_itens = vtotal_itens + totvendas - vdesconto;
	SET vtotvendas = vtotvendas + totvendas;
 END loop itens;
 close busca_itens;
 #atualizar o total da venda
 UPDATE comvenda SET n_totavenda = vtotal_itens, 
 n_valovenda = vtotvendas, n_descvenda =vtotvendas - vtotal_itens
 WHERE n_numevenda = NEW.n_numevenda;
  END if;
 END;
 $$

#----------------------------------------
drop trigger if EXISTS tri_ivendas_ad;
#----------------------------------------
/* Triggers before delete e after delete*/
delimiter $$
create trigger tri_ivendas_ad
after delete on comivenda 
for each row
BEGIN
	##declarar as variáveis
	DECLARE vtotal_itens FLOAT(10,2) DEFAULT 0;
	DECLARE vdesconto FLOAT(10,2) DEFAULT 0;
	DECLARE vtotvendas FLOAT(10,2) DEFAULT 0;
	DECLARE totvendas FLOAT(10,2) DEFAULT 0;
	DECLARE fimLoop BOOLEAN DEFAULT FALSE;
	##cursor para buscar os itens já registrados da venda
	DECLARE busca_itens CURSOR FOR 
	SELECT n_descivenda vdesconto , 
	(n_valoivenda * n_qtdeivenda) totvenda  
	FROM comivenda WHERE n_numevenda= OLD.n_numevenda;
	#handler para encerrar o loop antes da ultima linha
	DECLARE CONTINUE handler FOR SQLSTATE '02000'
	SET fimLoop= TRUE;
	 
	##abrir o cursor
	OPEN busca_itens;
	##declarar e iniciar o loop 
	itens : loop
	fetch busca_itens 
	INTO vdesconto, totvendas ;
	#encerrar o bloco quando o cursor não retornar mais linhas
	if fimLoop then
		leave itens;
	END if;
	#somar o valor total dos itens(produtos)
	SET vtotal_itens = vtotal_itens + totvendas -vdesconto;
	SET vtotvendas = vtotvendas + totvendas;
 END loop itens;
 close busca_itens;
 #atualizar o total da venda
 UPDATE comvenda SET n_totavenda = vtotal_itens, 
 n_valovenda = vtotvendas, n_descvenda =vtotvendas - vtotal_itens
 WHERE n_numevenda = old.n_numevenda;
  	
END;
$$