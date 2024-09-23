select c_codiclien, c_razaclien
from comvenda, comclien
where comvenda.n_numeclien = comclien.n_numeclien
order by c_razaclien;


/*
Funções de agregação
Group by
O comando SQL para fazer essa operação de agregação é o group by.
Ele deverá ser utilizado logo após as cláusulas de condições where ou and,
e antes do order by, se a sua consulta possuí-lo.
*/

select c_codiclien, c_razaclien
from comclien, comvenda
where comvenda.n_numeclien = comclien.n_numeclien
group by c_codiclien, c_razaclien
order by c_razaclien;

#função de agregação chamada count()
select c_codiclien, c_razaclien, count(n_numevenda) Qtde
from comclien, comvenda
where comvenda.n_numeclien = comclien.n_numeclien
group by c_codiclien, c_razaclien
order by c_razaclien;

#Having count() resultado os clientes que tiveram mais do que duas vendas
select c_razaclien, count(n_numevenda)
from comclien, comvenda
where comvenda.n_numeclien = comclien.n_numeclien
group by c_razaclien
having count(n_numevenda) > 1;

#max() e min()
SELECT MAX(n_totavenda) maior_venda FROM comvenda;
SELECT MIN(n_totavenda) menor_venda FROM comvenda;
select min(n_totavenda) menor_venda, max(n_totavenda)
maior_venda from comvenda;

#Sum()
SELECT * FROM comvenda;
SELECT SUM(n_valovenda) valor_venda, SUM(n_descvenda) descontos, SUM(n_totavenda) total_venda FROM comvenda WHERE d_datavenda BETWEEN '2015-01-01'AND '2015-01-01';

#avg
select format(avg(n_totavenda),2) from comvenda;

#substr() e length()
select c_codiprodu, c_descprodu from comprodu
where substr(c_codiprodu,1,3) = '123' 
and length(c_codiprodu) > 4;


SELECT * FROM comclien;

select substr(c_razaclien,1,5) Razao_Social,
length(c_codiclien) Tamanho_Cod
from comclien
where n_numeclien = 1;

#Concat() e concat_ws()
select concat(c_razaforne,' - fone: ', c_foneforne)
from comforne
order by c_razaforne;

SELECT * from comforne;

select
concat(c_codiclien,' ',c_razaclien, ' ', c_nomeclien)
from comclien
where c_razaclien like 'GREA%';

select
concat_ws(';',c_codiclien, c_razaclien, c_nomeclien)
from comclien
where c_razaclien like 'GREA%';

#Lcase() e lower()
select lcase(c_razaclien) from comclien;
#Ucase
SELECT UCASE('banco de dados mysql') FROM DUAL;

#Funções de cálculos e operadores aritméticos
#Round()
select round('21123.146',2) from DUAL;
#Format
select format('21123.146',2) from DUAL;

#Truncate
select TRUNCATE('21123.146',2) from DUAL;
select TRUNCATE(max(n_totavenda),0) maior_venda from comvenda;
select truncate(min(n_totavenda),1) menor_venda from comvenda;

#Sqrt()
select SQRT(25);
#Pi
select PI();
select sin(PI());
select cos(PI());
select tan(pi()+1);
#erro copiar codigo de erro
select tan(pi()+(A));

#Operadores aritméticos
SELECT * from comivenda

select (n_qtdeivenda * n_valoivenda) multiplicação
from comivenda
where n_numeivenda = 4;

select truncate((sum(n_valoivenda) /
count(n_numeivenda)),2) divisão
from comivenda;


select (n_valoivenda + n_descivenda) adição
from comivenda
where n_numeivenda = 4;

SELECT  FROM comivenda i, comprodu p, comforne f

SELECT * from comivenda

#Funções de data
SELECT CURDATE();
SELECT NOW();
SELECT SYSDATE();
select CURTIME();
select datediff('2015-02-01 23:59:59','2015-01-01');
select datediff(SYSDATE(),'2024-01-01');
select date_add('2013-01-01', interval 31 DAY);
select date_add(CURDATE(), interval 31 DAY);
select dayname('2015-01-01');
select dayname(SYSDATE());
select MONTHNAME(SYSDATE());
select dayofmonth('2015-01-01');
select dayofmonth(SYSDATE());
select extract(year from SYSDATE());
select last_day('2015-02-01');
select date_format('2015-01-10',get_format(date,'EUR'));
select str_to_date('01.01.2015',get_format(date,'USA'));

#Como configurar o MySQL para exibir datas em português 
SELECT @@lc_time_names;
SET lc_time_names = 'pt_BR';
SELECT DATE_FORMAT('2020-08-06', '%d de %M de %Y');
#para fixar no mysql
SET GLOBAL lc_time_names=pt_BR;

_
