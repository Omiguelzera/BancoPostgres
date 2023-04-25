create table cliente( 
 numero integer, 
 nome varchar(100) not null, 
 endereco varchar(200) not null, 
 constraint pk_cli primary key (numero) 
); 
create table carro ( 
 registro integer, 
 marca varchar(50) not null, 
 modelo varchar(50) not null, 
 cor varchar(50) not null, 
 constraint pk_carro primary key (registro) 
); 
create table apolice ( 
 numero integer, 
 valor numeric(10,2) not null check (valor > 0), 
 dt_inicio date not null, 
 dt_fim date not null, 
 num_cliente integer not null, 
 reg_carro integer not null, 
 constraint pk_apolice primary key (numero), 
 constraint fk_apolice_cli foreign key (num_cliente) 
 references cliente(numero), 
 constraint fk_apolice_car foreign key (reg_carro) 
 references carro(registro) 
); 
create table acidente ( 
 codigo integer, 
 data date not null, 
 hora time not null, 
 local varchar(200) not null, 
 constraint pk_acidente primary key (codigo) 
); 
create table apolice_acidente( 
 num_apolice integer, 
 cod_acidente integer, 
 constraint pk_ap_ac primary key (num_apolice,cod_acidente), 
 constraint pk_ac_apolice foreign key (num_apolice) 
 references apolice(numero), 
 constraint pk_ac_acidente foreign key (cod_acidente) 
 references acidente(codigo) 
); 


insert into cliente values (1,'Maria','Rua A'); 
insert into cliente values (2,'Ricardo','Rua B'); 
insert into cliente values (3,'Lucas','Rua C'); 
insert into cliente values (4,'Vanessa','Rua D'); 
insert into cliente values (5,'Aline','Rua E');




insert into carro values (10,'Fiat','Uno','Vermelho'); 
insert into carro values (20,'Fiat','Strada','Prata'); 
insert into carro values (30,'Honda','Civic','Cinza'); 
insert into carro values (40,'Honda','Fit','Branco'); 
insert into carro values (50,'Hyundai','HB20','Grafite'); 

insert into apolice 
 values (1,5000.00,'2023-01-10','2024-01-09',1,50); 
insert into apolice 
 values (2,2500.00,'2023-04-10','2024-04-09',2,20); 
insert into apolice 
 values (3,8750.00,'2023-02-21','2024-02-20',2,30); 
insert into apolice 
 values (4,15789.00,'2023-03-18','2024-03-17',4,10); 
insert into apolice 
 values (5,4580.00,'2023-04-23','2024-04-22',3,50); 
 
insert into acidente 
 values (100,'2023-05-01','10:32:00','Rua Azul'); 
insert into acidente 
 values (200,'2023-04-20','08:30:00','Rua Branca'); 
insert into acidente 
 values (300,'2023-04-11','11:12:00','Rua Rosa'); 
insert into acidente 
 values (400,'2023-05-17','15:00:00','Rua Verde'); 
insert into acidente 
 values (500,'2023-04-25','10:02:00','Rua Amarela'); 
 
 
 
insert into apolice_acidente values (1,100); 
insert into apolice_acidente values (5,100); 
insert into apolice_acidente values (2,500); 
insert into apolice_acidente values (3,300); 
insert into apolice_acidente values (4,200); 
insert into apolice_acidente values (5,400); 

select * from carro;

select* from apolice;


/*Escreva o comando SQL que exiba marca e modelo de todos os carros de cor 
vermelho cadastrados. A lista deve estar ordenada em ordem alfabética pela marca e modelo. */

select marca, modelo
from carro
where cor ilike 'vermelho';



/* Escreva o comando SQl que exiba o local de todos os acidentes ocorridos no mês de 
maio de 2023.*/ 

select local
from acidente 
where data between date '2023-05-01' and date '2023-05-31';


/* Escreva o comando SQl que exiba o número de cada apólice juntamente com o nome 
do cliente que a possui e o valor da mesa. Apresentar as apólices mais caras primeiro. */

select a.numero as apolice, c.nome
from apolice a, cliente c
where c.numero = a.num_cliente
order by valor DESC;


/* Escreva o comando SQL que exiba o número de cada apólice, o nome do cliente e a 
marca do veículo segurado, das apólices com início no mês de abril de 2023. O resultado deve 
estar ordenado em ordem crescente pelo nome do cliente. */
select a.numero, c.nome, r.marca
from apolice a , cliente c , carro r
WHERE c.numero = a.num_cliente and a.reg_carro = r.registro
and dt_inicio between date '2023-04-01' and date '2023-04-30'
Order by c.nome;

/* Escreva o comando SQL que exiba data, horário e local, dos acidentes envolvendo o 
HB20 grafite. A lista deverá estar ordenada pela data e horário do acidente. 
 */
select data, hora, local, car.modelo, car.cor
from acidente a, apolice ap, apolice_acidente ac, carro car
where car.modelo = 'HB20' and car.cor = 'Grafite' and car.registro = ap.reg_carro and a.codigo = ac.cod_acidente
and ap.numero = ac.num_apolice;

/* Escreva o comando SQL que exiba a marca do veículo, o nome do cliente e o número 
das apólices de todos os acidentes ocorridos no mês de maio de 2023.*/
select car.marca, c.nome, a.numero, d.data
from carro car, cliente c, apolice a, acidente d, apolice_acidente ac
where car.registro = a.reg_carro and c.numero = a.num_cliente and a.numero = ac.num_apolice
and d.codigo = ac.cod_acidente
and d.data between date '2023-05-01' and date '2023-05-31';
