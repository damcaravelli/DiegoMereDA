-- Sprint 3 Diego Mere Nivel 3

/*Exercici 1
La setmana vinent tindràs una nova reunió amb els gerents de màrqueting. 
Un company del teu equip va realitzar modificacions en la base de dades, però no recorda com les va realitzar. 
Et demana que l'ajudis a deixar els comandos executats per a obtenir el següent diagrama:*/

-- Primero se crea la tabla user y se le insertan los datos 

-- Al crear la tabla user, se creo una relacion automatica incorecta, eliminamos esta relacion para poder crearla de nuevo con los requisitos correctos
ALTER TABLE user
DROP FOREIGN KEY user_ibfk_1;

-- Insertamos en la tabla user el ID de la transaction extra, ya que de no hacerlo, al crear la nueva FK, nos impediria la creacion a no existir esta entrada
insert into user(ID)
values ("9999");

-- Creo la relacion de FK en transaction con el ID en la tabla user 
ALTER TABLE transaction
ADD CONSTRAINT fk_user_id FOREIGN KEY (user_id) REFERENCES user(ID);

-- Renonmbro la tabla de user a data_user
RENAME TABLE user TO data_user;

-- Elimino la columna de website 
ALTER TABLE company
DROP COLUMN website;

-- Edito el nombre del email a personal_email
ALTER TABLE data_user
RENAME COLUMN email to personal_email;

-- cambio tipo de dato de ID a varchar(20)
ALTER TABLE credit_card
MODIFY COLUMN ID varchar(20);

-- Cambio de tipo de dato de cvv a int
ALTER TABLE credit_card
MODIFY COLUMN cvv int;

-- creo una nueva columna con la fecha actual 
ALTER TABLE credit_card
ADD COLUMN fecha_actual DATE;

-- modo seguro no permite actualizar la tabla creditcard sin una condicion
SET SQL_SAFE_UPDATES = 0;
-- 
-- Actualizo la columna nueva de la fecha con la funcion de curdate que asigna la fecha actual a los campos ya creados
UPDATE credit_card
SET fecha_actual = CURDATE();

-- Pongo por default la fecha actual cada vez que crea una columna nueva

ALTER TABLE credit_card
MODIFY COLUMN fecha_actual DATE DEFAULT (CURDATE());

SET SQL_SAFE_UPDATES = 1;


/*Exercici 2
L'empresa també et sol·licita crear una vista anomenada "InformeTecnico" que contingui la següent informació:

ID de la transacció
Nom de l'usuari/ària
Cognom de l'usuari/ària
IBAN de la targeta de crèdit usada.
Nom de la companyia de la transacció realitzada.
Assegura't d'incloure informació rellevant de totes dues taules i utilitza àlies per a canviar de nom columnes segons sigui necessari.
Mostra els resultats de la vista, ordena els resultats de manera descendent en funció de la variable ID de transaction.*/

CREATE VIEW InformeTecnico AS
select transaction.ID ID_Transaccion, data_user.name Nombre_Usuario, data_user.surname Apellido_Usuario, 
credit_card.iban IBAN_Tarjeta, company.company_name Nombre_Compañia
from credit_card join transaction on credit_card.id = transaction.credit_card_id
				join data_user on transaction.user_id = data_user.id
                join company on transaction.company_id = company.id;

Select * from InformeTecnico
order by ID_Transaccion desc;







