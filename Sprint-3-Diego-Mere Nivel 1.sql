-- Sprint 3 Diego Mere Nivel 1
--                                                                 Nivell 1

/*Exercici 1
La teva tasca és dissenyar i crear una taula anomenada "credit_card" que emmagatzemi detalls crucials sobre les targetes de crèdit. 
La nova taula ha de ser capaç d'identificar de manera única cada targeta i establir una relació adequada amb les altres dues taules ("transaction" i "company").
Després de crear la taula serà necessari que ingressis la informació del document denominat "dades_introduir_credit". 
Recorda mostrar el diagrama i realitzar una breu descripció d'aquest.*/

create table IF NOT EXISTS credit_card (
ID varchar(15) not null primary key, -- tamaño al que hace referencia la FK de transaction
iban varchar(50), -- El tamano estandar permitido para el iban son de 34 caracteres 
pan varchar(20), -- Estandar de longitud de TdC 16 digitos, añadido espacio extra para poder manejar longitudes de " " "-" etc 
pin varchar(4), -- Guardado como char para evitar calculos numericos (o eliminacion de 0), de longitud fija en 4 
cvv char(3), -- Guardado como char para evitar calculos numericos (o eliminacion de 0), de longitud fija en 3 
expiring_date varchar(100)); -- En este caso, el formato de la fecha no es compatible con "date", se almacenan como varchar en caso de no poder cambiar formato


-- Creo la FK en transaction con la PK de ID en la tabla credit_card
ALTER TABLE transaction
ADD CONSTRAINT fk_credit_card_id FOREIGN KEY (credit_card_id) REFERENCES credit_card(ID);

/*Exercici 2
El departament de Recursos Humans ha identificat un error en el número de compte de l'usuari amb ID CcU-2938. 
La informació que ha de mostrar-se per a aquest registre és: R323456312213576817699999. Recorda mostrar que el canvi es va realitzar.*/

update credit_card
set iban = "R323456312213576817699999"
where ID = "CcU-2938";

select *
from credit_card
where ID = "CcU-2938";

/*Exercici 3
En la taula "transaction" ingressa un nou usuari amb la següent informació:
Id	108B1D1D-5B23-A76C-55EF-C568E49A99DD
credit_card_id	CcU-9999
company_id	b-9999
user_id	9999
lat	829.999
longitude	-117.999
amount	111.11
declined	0*/


insert into company(id) -- Creo el company ID en la tabla company para evitar errores al ser una FK de transactions 
values ("b-9999"); 

insert into credit_card(id) -- Creo el credit card ID en la tabla credit card para evitar errores al ser una FK de transactions 
values ("CcU-9999");

INSERT INTO transaction (id,credit_card_id, company_id, user_id, lat, longitude, timestamp, amount, declined)
VALUES ("108B1D1D-5B23-A76C-55EF-C568E49A99DD", "CcU-9999", "b-9999", 9999, 829.999, -117.999, now(), 111.11, 0);

select *
from transaction
where id = "108B1D1D-5B23-A76C-55EF-C568E49A99DD";

-- En este caso, tuve que crear las entradas en las tablas de company y credit card para poder anadir la transaction, ademas set la hora a la actual con now()

/*Exercici 4
Des de recursos humans et sol·liciten eliminar la columna "pan" de la taula credit_*card. Recorda mostrar el canvi realitzat.*/

SELECT * FROM transactions.credit_card;

alter table credit_card
drop column pan;

SELECT * FROM transactions.credit_card;





