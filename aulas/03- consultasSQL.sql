#geral
select * from comclien;
#consulta alguns campos
select n_numeclien, c_codiclien, c_razaclien from comclien;

$consulta alguns campos com condição
select n_numeclien, c_codiclien, c_razaclien
from comclien
where c_codiclien = '0001';

$consulta alguns campos com condição usando não iguais <>
select n_numeclien, c_codiclien, c_razaclien
from comclien
where c_codiclien <> '0001';

#consulta com filtro like 
select n_numeclien, c_codiclien, c_razaclien
from comclien
where c_razaclien like 'L%';

#Para não selecionar um registro igual ao outro
select DISTINCT n_numeclien from comvenda t;
SELECT * from comvenda t;

select c_codiclien, c_razaclien
from comclien
where n_numeclien in (1,2);

select c_codiclien, c_razaclien
from comclien
where n_numeclien not in (1,2);


select c_razaclien
from comclien
where n_numeclien in (select n_numeclien
from comvenda
where n_numeclien);

select c_razaclien
from comclien
where n_numeclien not in (select n_numeclien
from comvenda);

select c_codivenda Cod_Venda,
(select c_razaclien
from comclien
where n_numeclien = comvenda.n_numeclien) Nome_Cliente
from comvenda;

select c_codiclien CODIGO, c_nomeclien CLIENTE
from comclien
where n_numeclien not in(1,2,3,4);

select c_codivenda,
(select c_razaclien
from comclien
where n_numeclien = comvenda.n_numeclien)
from comvenda;

select c_codivenda,
(select c_razaclien
from comclien
where n_numeclien = comvenda.n_numeclien) Nome_cliente
from comvenda;

select c_codiclien, c_razaclien, c_codivenda Cod_Venda
from comvenda, comclien
where comvenda.n_numeclien = comclien.n_numeclien
order by c_razaclien;

select c_codiclien codigo, c_razaclien razao_social,
c_codivenda codi_venda
from comvenda
join comclien on
comvenda.n_numeclien = comclien.n_numeclien
order by c_razaclien;