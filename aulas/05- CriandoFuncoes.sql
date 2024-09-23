SET GLOBAL log_bin_trust_function_creators = 1;

DROP FUNCTION if EXISTS rt_nome_cliente;
#-------------------------------------------
delimiter $$
create function rt_nome_cliente(vn_numeclien INT)
returns varchar(50)  

begin
	declare nome varchar(50);

	select c_nomeclien  into nome
	  from comclien
	where n_numeclien = vn_numeclien;
 
	return nome;
END $$


#-------------------------------------------

SELECT rt_nome_cliente(2)

SELECT * FROM comclien;

select c_nomeclien
	  from comclien
	where n_numeclien = 2