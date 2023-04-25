create table cargo (
codigo integer,
nome varchar (50) not null,
salario_base numeric (10,2) not null,
constraint pk_cod_cargo primary key (codigo)
);
create table cidade (
codigo integer,
nome varchar (50) not null,
constraint pk_cod_cid primary key (codigo)
);
create table departamento (
codigo integer,
nome_depto varchar (50) not null,
constraint pk_codigo primary key (codigo)
);
create table funcionario(
codigo integer,
nome_func varchar(100) not null,
telefone varchar (12) null,
salario numeric (10,2) not null,
cod_cargo integer not null,
cod_cid integer not null,
cod_depto integer not null,
gerente integer,
constraint pk_func_cod primary key(codigo),
constraint fk_func_cargo foreign key (cod_cargo) references cargo (codigo),	
constraint fk_func_cid foreign key (cod_cid) references cidade (codigo),
constraint fk_func_depto foreign key (cod_depto) references departamento (codigo),	
constraint fk_func_gerente foreign key  (gerente) references funcionario (codigo)
);

insert into cargo (codigo, nome, salario_base) values (1, 'estagiario', 800);
insert into cargo (codigo, nome, salario_base) values (2, 'gerente', 2000.00);
insert into cargo (codigo, nome, salario_base) values (3, 'supervisor', 1800.00);
insert into cargo (codigo, nome, salario_base) values (4, 'encarregado', 1500.00);
insert into cargo (codigo, nome, salario_base) values (5, 'auxiliar', 1000.00);



insert into cidade (codigo, nome) values (1, 'Mogi das Cruzes');
insert into cidade (codigo, nome) values (2, 'Sao paulo');
insert into cidade (codigo, nome) values (3, 'Campinas');
insert into cidade (codigo, nome) values (4, 'Sao Jose dos Campos');



insert into departamento (codigo, nome_depto) values (1,'Vendas');
insert into departamento (codigo, nome_depto) values (2,'Compras');
insert into departamento (codigo, nome_depto) values (3,'PCP');
insert into departamento (codigo, nome_depto) values (4,'Produção');




insert into funcionario (codigo, nome_func, telefone, salario, cod_cargo, cod_cid, cod_depto, gerente)
values (1, 'Antonio Leite', '11 933847583', 10000.00,2,3,2, NULL );
insert into funcionario (codigo, nome_func, telefone, salario, cod_cargo, cod_cid, cod_depto, gerente)
values (2,'Lucas Silva', '11 988745672', 7000.00,2,1,1,1);
insert into funcionario(codigo, nome_func, telefone, salario, cod_cargo, cod_cid, cod_depto, gerente)
values (3,'Bruna Santos', '11 983745048', 2000.98,3,3,4,2);
insert into funcionario(codigo, nome_func, telefone, salario, cod_cargo, cod_cid, cod_depto, gerente)
values (4, 'Camila Rocha', '11983749827', 4000.98,4,2,1,1);
insert into funcionario (codigo, nome_func, telefone, salario, cod_cargo, cod_cid, cod_depto, gerente)
values (5, 'Dayne Santos', '11 999845712',600.00,1,4,3,1);
insert into funcionario (codigo, nome_func, telefone, salario, cod_cargo, cod_cid, cod_depto, gerente)
values (6, 'Emerson Santos', '11 922387463', 6000.98,2,3,4,2);

select * from funcionario;

select nome_func, salario
from funcionario
where salario between 6000.00 and 8000.00;

select nome_func as funcionario , nome as cargo
from funcionario f, cargo c
where c.codigo = f.cod_cargo 
order by nome_func;

select nome_func as funcionario, nome_depto as departamento
from funcionario f, departamento d
where d.codigo = f.cod_depto
order by nome_depto, nome_func;

select nome_func as funcionario, nome_depto as departamento
from funcionario f, departamento d
where d.codigo = f.cod_depto
and d.nome_depto ilike 'Compras';


select nome_func as funcionario, nome as cidade
from funcionario f, cidade c
where c.codigo = f.cod_cid 
and c.nome ilike '%sao%';


select nome_func as funcionario, c.nome as cargo, salario, cid.nome
from funcionario f, cargo c, cidade cid
where c.codigo = f.cod_cargo and cid.codigo = f.cod_cid 
and cid.nome ilike 'campinas';


select nome_func as funcionario, cid.nome as cidade
from funcionario f, cidade cid
where cid.codigo = f.cod_cid;


select nome_func as funcionario, cid.nome as cidade, d.nome_depto, c.nome as cargo
from funcionario f, cidade cid, departamento d, cargo c
where cid.codigo = f.cod_cid and d.codigo = f.cod_depto and c.codigo = f.cod_cargo
and c.nome ilike 'estagiario';

select nome_func as funcionario 
from funcionario 
where gerente = 1
order by nome_func;
