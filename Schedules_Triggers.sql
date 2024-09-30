set global event_scheduler = on;

SELECT NOW()

DROP EVENT if EXISTS processa_comissao;
#----------------------------------
delimiter $$
create event processa_comissao
on schedule every 1 week starts '2024-09-12 20:30:00'
do
begin
  call processa_comissionamento(curdate() - interval 7 DAY, curdate(), @a );
END
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
----------------------------------------
/*cria um função para ser usada na trigger*/
DROP FUNCTION if EXISTS rt_percentual_comissao;
#-------------------------------------------
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

drop trigger if EXISTS tri_vendas_bi;
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
	
end
$$	

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
end
$$

#--------------------------------------------
/*
Criar trigger em comivenda, itens da venda.
*/
delimiter $$
create trigger tri_vendas_ai
after insert on comivenda 
for each row
begin
  ## declarar as variáveis
  declare vtotal_itens float(10,2) default 0;
  declare total_item   float(10,2) default 0;
 declare fimLoop boolean default false;

 ## cursor para buscar os itens já registrados da venda
 declare busca_itens cursor for
   select n_valoivenda
     from comivenda
    where n_numevenda = new.n_numevenda;
	
 ##Handler para encerrar o loop antes da última linha
 declare continue handler for
	sqlstate '02000' 
	set fimLoop = true;

  ## abrir o cursor
  open busca_itens;
  ## declarar e inicio o loop
  itens : loop
	fetch busca_itens into total_item;
	
	#encerrar o bloco quando o cursor não retornar mais linhas.
	if fimLoop then
		leave itens;
	end if;
  		  	
  	## somar o valor total dos itens(produtos)
  	set vtotal_itens = vtotal_itens + total_item;
    
  end loop itens;
    
  close busca_itens;

  ## atualizar o total da venda
  update comvenda set n_totavenda = vtotal_itens
   where n_numevenda = new.n_numevenda;

END
$$

