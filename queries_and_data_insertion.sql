-- inserção de dados e queries
use ecommerce;


SET FOREIGN_KEY_CHECKS = 0;
truncate table productSupplier;
truncate table storageLocation;
truncate table productOrder;
truncate table productSeller;
truncate table seller;
truncate table supplier;
truncate table productStorage;
truncate table payments;
truncate table orders;
truncate table product;
truncate table clients;
SET FOREIGN_KEY_CHECKS = 1;

show tables;

insert into clients (Fname, Minit, Lname, CPF, Address) 
	   values('Maria','M','Silva', '00012346789', 'rua silva de prata 29, Carangola - Cidade das flores'),
		     ('Matheus','O','Pimentel', '00987654321','rua alemeda 289, Centro - Cidade das flores'),
			 ('Ricardo','F','Silva', '00045678913','avenida alemeda vinha 1009, Centro - Cidade das flores'),
			 ('Julia','S','França', '00789123456','rua lareijras 861, Centro - Cidade das flores'),
			 ('Roberta','G','Assis', '00098745631','avenidade koller 19, Centro - Cidade das flores'),
			 ('Isabela','M','Cruz', '00654789123','rua alemeda das flores 28, Centro - Cidade das flores');


-- idProduct, Pname, classification_kids boolean, category('Eletrônico','Vestimenta','Brinquedos','Alimentos','Móveis'), rating, size, price
insert into product (Pname, classification_kids, category, rating, size, price) values
							  ('Fone de ouvido',false,'Eletrônico','4',null,89.90),
                              ('Barbie Elsa',true,'Brinquedos','3',null,79.90),
                              ('Body Carters',true,'Vestimenta','5',null,39.90),
                              ('Microfone Vedo - Youtuber',False,'Eletrônico','4',null,149.90),
                              ('Sofá retrátil',False,'Móveis','3','3x57x80',1899.00),
                              ('Farinha de arroz',False,'Alimentos','2',null,8.50),
                              ('Fire Stick Amazon',False,'Eletrônico','3',null,329.00);

select * from clients;
select * from product;
-- idOrder, idOrderClient, orderStatus, orderDescription, sendValue, paymentCash

delete from orders where idOrderClient in  (1,2,3,4);
insert into orders (idOrderClient, orderStatus, orderDescription, sendValue, paymentCash) values 
							 (1, default,'compra via aplicativo',null,1),
                             (2,default,'compra via aplicativo',50,0),
                             (3,'Confirmado',null,null,1),
                             (4,default,'compra via web site',150,0);

-- idPOproduct, idPOorder, poQuantity
select * from orders;
insert into productOrder (idPOproduct, idPOorder, poQuantity) values
						 (1,1,2),
                         (2,2,1),
                         (3,3,1);

-- storageLocation,quantity
insert into productStorage (storageLocation,quantity) values 
							('Rio de Janeiro',1000),
                            ('Rio de Janeiro',500),
                            ('São Paulo',10),
                            ('São Paulo',100),
                            ('São Paulo',10),
                            ('Brasília',60);

-- idLproduct, idLstorage, location, quantity (quantidade DESSE produto NESSE local)
insert into storageLocation (idLproduct, idLstorage, location, quantity) values
						 (1,2,'RJ',30),
                         (2,6,'GO',15);

-- idSupplier, SocialName, CNPJ, contact
insert into supplier (SocialName, CNPJ, contact) values 
							('Almeida e filhos', '123456789123456','21985474'),
                            ('Eletrônicos Silva','854519649143457','21985484'),
                            ('Eletrônicos Valma', '934567893934695','21975474');
                            
select * from supplier;
-- idPsSupplier, idPsProduct, quantity
insert into productSupplier (idPsSupplier, idPsProduct, quantity) values
						 (1,1,500),
                         (1,2,400),
                         (2,4,633),
                         (3,3,5),
                         (2,5,10);


insert into seller (SocialName, AbstName, CNPJ, CPF, location, contact) values 
						('Tech eletronics', null, '123456789456321', null, 'Rio de Janeiro', '219946287'),
					    ('Botique Durgas',null,null,'123456783','Rio de Janeiro', '219567895'),
						('Kids World',null,'456789123654485',null,'São Paulo', '1198657484');

select * from seller;
-- idPseller, idPproduct, prodQuantity
insert into productSeller (idPseller, idPproduct, prodQuantity) values 
						 (1,6,80),
                         (2,7,10);

select * from productSeller;

select count(*) from clients;
select * from clients c, orders o where c.idClient = idOrderClient;

select Fname,Lname, idOrder, orderStatus from clients c, orders o where c.idClient = idOrderClient;
select concat(Fname,' ',Lname) as Client, idOrder as Request, orderStatus as Status from clients c, orders o where c.idClient = idOrderClient;

insert into orders (idOrderClient, orderStatus, orderDescription, sendValue, paymentCash) values 
							 (2, default,'compra via aplicativo',null,1);
                             
select count(*) from clients c, orders o 
			where c.idClient = idOrderClient;

select * from orders;

-- recuperação de pedido com produto associado
select * from clients c 
				inner join orders o ON c.idClient = o.idOrderClient
                inner join productOrder p on p.idPOorder = o.idOrder;
        
-- Recuperar quantos pedidos foram realizados pelos clientes?
select c.idClient, Fname, count(*) as Number_of_orders from clients c 
				inner join orders o ON c.idClient = o.idOrderClient
		group by idClient;