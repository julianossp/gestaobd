DROP PROCEDURE if EXISTS processa_comissionamento;
# --------------------------------------------------
delimiter $$
create procedure processa_comissionamento(
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


END
$$

#--------------------------------------

call processa_comissionamento('2015-01-01','2015-05-30' ,@a);
select @a;