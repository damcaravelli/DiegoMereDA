-- Agregar OPT_LOCAL_INFILE=1 en connections y SET GLOBAL local_infile = 1;


create database negocio;
use negocio;

create table IF NOT EXISTS companies(
company_id varchar(15) not null primary key, 
company_name varchar(255), 
phone varchar(20), 
email varchar(50), 
country varchar(50), 
website varchar(100)); 


LOAD DATA LOCAL INFILE 'C:/Users/diego/Desktop/Especializacion/SQL/Sprint 4/companies.csv'
INTO TABLE companies 
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES;


create table IF NOT EXISTS credit_cards(
id varchar(15) not null primary key, 
user_id varchar(15), 
iban varchar(50), 
pan varchar(50), 
pin varchar(6), 
cvv varchar(3),
track1 varchar(50), 
track2 varchar(50),
expiring_date varchar(50)); 

LOAD DATA LOCAL INFILE 'C:/Users/diego/Desktop/Especializacion/SQL/Sprint 4/credit_cards.csv'
INTO TABLE credit_cards 
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

create table IF NOT EXISTS products(
id varchar(15) not null primary key, 
product_name varchar(50), 
price varchar(15), 
colour varchar(50), 
weight float, 
warehouse_id varchar(15)); 

LOAD DATA LOCAL INFILE 'C:/Users/diego/Desktop/Especializacion/SQL/Sprint 4/products.csv'
INTO TABLE products FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 LINES;


create table IF NOT EXISTS user(
id varchar(15) not null primary key, 
name varchar(50), 
surname varchar(50),
phone varchar(50),  
email varchar(50), 
birth_date varchar(50), 
country varchar(50),
city varchar(50), 
postal_code varchar(20), 
address varchar(100));
 
 
LOAD DATA LOCAL INFILE 'C:/Users/diego/Desktop/Especializacion/SQL/Sprint 4/users_ca.csv' 
INTO TABLE user 
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES;

LOAD DATA LOCAL INFILE 'C:/Users/diego/Desktop/Especializacion/SQL/Sprint 4/users_uk.csv' 
INTO TABLE user 
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES;

LOAD DATA LOCAL INFILE 'C:/Users/diego/Desktop/Especializacion/SQL/Sprint 4/users_usa.csv' 
INTO TABLE user 
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES;


create table IF NOT EXISTS transaction(
id varchar(50) not null primary key, 
card_id varchar(15) , 
business_id varchar(15), 
timestamp timestamp,
amount float, 
declined varchar(3),
product_ids varchar(15), 
user_id varchar(15), 
lat varchar(20),
longitude varchar(20),
FOREIGN KEY(card_id) REFERENCES credit_cards(id),
FOREIGN KEY(business_id) REFERENCES companies(company_id),
FOREIGN KEY(user_id) REFERENCES user(id)
); 


LOAD DATA LOCAL INFILE 'C:/Users/diego/Desktop/Especializacion/SQL/Sprint 4/transactions.csv' 
INTO TABLE transaction 
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES;
 
-- drop database negocio;




