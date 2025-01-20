-- Sprint 3 Diego Mere Nivel 2
                                                           
/*Exercici 1
Elimina de la taula transaction el registre amb ID 02C6201E-D90A-1859-B4EE-88D2986D3B02 de la base de dades.*/

delete from transaction
where ID = "02C6201E-D90A-1859-B4EE-88D2986D3B02";

select *
from transaction
where ID = "02C6201E-D90A-1859-B4EE-88D2986D3B02"; 

/*Exercici 2
La secció de màrqueting desitja tenir accés a informació específica per a realitzar anàlisi i estratègies efectives. 
S'ha sol·licitat crear una vista que proporcioni detalls clau sobre les companyies i les seves transaccions. 
Serà necessària que creïs una vista anomenada VistaMarketing que contingui la següent informació: 
Nom de la companyia. Telèfon de contacte. País de residència. Mitjana de compra realitzat per cada companyia. 
Presenta la vista creada, ordenant les dades de major a menor mitjana de compra.*/

CREATE VIEW VistaMarketing AS
select company.company_name, company.phone, company.country, avg(transaction.amount) as Media_Compras
from company join transaction on company.id = transaction.company_id
where declined = 0
group by company.company_name, company.phone, company.country, transaction.declined;


SELECT * FROM VistaMarketing
ORDER BY Media_Compras DESC;

/*Vista contando solo las transacciones exitosas, en caso de quere obtener todas las transacciones, declinadas y no, podriamos retirar el where 
CREATE VIEW VistaMarketing AS
select company.company_name, company.phone, company.country, avg(transaction.amount) as Media_Compras
from company join transaction on company.id = transaction.company_id
group by company.company_name, company.phone, company.country, transaction.declined; */ 

/*Exercici 3
Filtra la vista VistaMarketing per a mostrar només les companyies que tenen el seu país de residència en "Germany"*/

SELECT * FROM VistaMarketing
where country = "Germany"
ORDER BY Media_Compras DESC;



