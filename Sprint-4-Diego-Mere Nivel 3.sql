-- Nivell 3
-- Crea una taula amb la qual puguem unir les dades del nou arxiu products.csv amb la base de dades creada, 
-- tenint en compte que des de transaction tens product_ids. Genera la següent consulta:

CREATE TABLE Trans_Prod (
    id_Trans_Prod INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    id_transaction VARCHAR(50),
    id_product VARCHAR(15)
);


CREATE TEMPORARY TABLE numbers (
num INT);

INSERT INTO numbers (num) VALUES (1), (2), (3), (4), (5), (6), (7), (8), (9), (10);


INSERT INTO Trans_Prod (id_transaction, id_product)
SELECT t.id AS id_transaction, TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(t.product_ids, ',', n.num), ',', -1)) AS id_product
/* t.id = id de la transaccion. SUBSTRING_INDEX(t.product_ids, ',', n.num) regresa n.num (numero) de products ID, lo llamaremos Resto
SUBSTRING_INDEX(Resto, ',', -1) extrae el ultimo product ID del resto del paso anterior
Trim elimina los espacios necesarios antes o despues de una ,
*/
FROM transaction t JOIN numbers n -- join con la tabla temporal numbers, asumiendo que no haya transaction con mas de 10 productos, si la hay, hay que crear mas numeeros
ON n.num <= LENGTH(t.product_ids) - LENGTH(REPLACE(t.product_ids, ',', '')) + 1; -- LENGTH(t.product_ids) calcula tamano de string con comas; LENGTH(REPLACE(t.product_ids, ',', '') sin comas; sumamos uno para obtener la cantidad de productos en el campo, por ejemplo 2 comas es a 3 productos

 DROP TEMPORARY TABLE numbers;   
 
ALTER TABLE Trans_Prod
ADD CONSTRAINT fk_id_transaction
FOREIGN KEY (id_transaction)
REFERENCES transaction(id)
ON DELETE CASCADE;  -- Esto opcionalmente elimina los registros de Trans_Prod cuando se elimina una transacción

ALTER TABLE Trans_Prod
ADD CONSTRAINT fk_id_product
FOREIGN KEY (id_product)
REFERENCES products(id)
ON DELETE CASCADE;  


-- Exercici 1 Necessitem conèixer el nombre de vegades que s'ha venut cada producte

SELECT p.id, p.product_name, COUNT(tp.id_product) AS sales_count
FROM products p JOIN Trans_Prod tp ON p.id = tp.id_product
GROUP BY p.id, p.product_name
ORDER BY sales_count DESC;
