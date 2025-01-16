--                                                                  Nivell 1

/*- Exercici 1
A partir dels documents adjunts (estructura_dades i dades_introduir), importa les dues taules.
Mostra les característiques principals de l'esquema creat i explica les diferents taules i variables que existeixen. 
Assegura't d'incloure un diagrama que il·lustri la relació entre les diferents taules i variables.*/

select * 
from company;

select * 
from transaction;

/*- Exercici 2
Utilitzant JOIN realitzaràs les següents consultes:*/ 

-- Nivell 1 Exercici 2.1  Llistat dels països que estan fent compres.

select distinct country
from transaction join company on transaction.company_id = company.id
order by 1; 
-- Entendiendo hacer compras como realizar una transaccion, en caso de solo contar las transacciones finalizadas, 
-- habria que filtrar por declined, quitando con where las transacciones declinadas

-- Nivell 1 Exercici 2.2  Des de quants països es realitzen les compres.

select count(distinct country)
from transaction join company on transaction.company_id = company.id;
 

-- Nivell 1 Exercici 2.3  Identifica la companyia amb la mitjana més gran de vendes.

select company_name, avg(amount) as "Media de ventas"
from transaction join company on transaction.company_id = company.id
where declined = 0
group by company_name
order by 2 desc
limit 1;
-- Usando el promedio solo de las transacciones completadas (o sea, no declinadas, declined = 0)

/*- Exercici 3
Utilitzant només subconsultes (sense utilitzar JOIN):*/

-- Nivell 1 Exercici 3.1 Mostra totes les transaccions realitzades per empreses d'Alemanya.

select *
from transaction
where company_id in (select id 
					from company
					where country = 'Germany');

-- Nivell 1 Exercici 3.2 Llista les empreses que han realitzat transaccions per un amount superior a la mitjana de totes les transaccions.

-- Entendiendo que alguna transaccion de la empresa es mayor a la media global 
                                       
select distinct company_name
from company
where id in (
	select company_id
    from transaction
    where amount > (select avg(amount) 
					from transaction));


/*-- Entendiendo que la suma de transacciones de la empresa es mayor a la media global
select company_name
from company
where id in (select company_id
				from transaction
				where declined = 0
				group by company_id
				having sum(amount) > (select avg(amount)
										from transaction));
                                        */


-- Nivell 1 Exercici 3.3 Eliminaran del sistema les empreses que no tenen transaccions registrades, entrega el llistat d'aquestes empreses.
                       
 select company_name as "Empresas a eliminar"
 from company 
 where id not in (select distinct company_id
					from transaction);


--                                                                  Nivell 2

/*Nivell 2 Exercici 1
Identifica els cinc dies que es va generar la quantitat més gran d'ingressos a l'empresa per vendes.
Mostra la data de cada transacció juntament amb el total de les vendes.*/

SELECT date(timestamp), sum(amount) as "Total de ventas"
FROM transaction 
GROUP BY DATE(timestamp)
order by 2 desc
Limit 5;


/*Nivell 2 Exercici 2
Quina és la mitjana de vendes per país? Presenta els resultats ordenats de major a menor mitjà.*/

select country, avg(amount) as "Media de ventas"
from company join transaction on company.id = transaction.company_id
group by country
order by 2 desc;


/*Exercici 3
En la teva empresa, es planteja un nou projecte per a llançar algunes campanyes publicitàries per a fer competència a la companyia "Non Institute". 
Per a això, et demanen la llista de totes les transaccions realitzades per empreses que estan situades en el mateix país que aquesta companyia.*/

-- Nivell 2 Exercici 3.1 Mostra el llistat aplicant JOIN i subconsultes.
Select *
from transaction join company on transaction.company_id = company.id
where country = (select country 
				from company
				where company_name = 'Non Institute');

-- Nivell 2 Exercici 3.2 Mostra el llistat aplicant solament subconsultes.

select * 
from transaction
where company_id in (Select id
					from company
					where country = (select country 
									from company
									where company_name = 'Non Institute'));
                                    
--                                                                  Nivell 3

/*Exercici 1
Presenta el nom, telèfon, país, data i amount, d'aquelles empreses que van realitzar transaccions 
amb un valor comprès entre 100 i 200 euros i en alguna d'aquestes dates: 29 d'abril del 2021, 20 de juliol del 2021 i 13 de març del 2022. 
Ordena els resultats de major a menor quantitat.*/

select company_name, country, phone, date(timestamp), amount
from transaction join company on transaction.company_id = company.id
where amount between 100 and 200 
and date(timestamp) in ('2021-04-29', '2021-07-20', '2022-03-13')
order by 5 desc;


/*Exercici 2
Necessitem optimitzar l'assignació dels recursos i dependrà de la capacitat operativa que es requereixi, 
per la qual cosa et demanen la informació sobre la quantitat de transaccions que realitzen les empreses,
però el departament de recursos humans és exigent i vol un llistat de les empreses on especifiquis si tenen més de 4 transaccions o menys.*/

 select company_name, Cuentas.Cantidad_Transacciones, 
													case when Cuentas.Cantidad_Transacciones < 4 then "Menos de 4 transacciones"
														when Cuentas.Cantidad_Transacciones > 4 then "Mas de 4 transacciones"
														else "4 transacciones"
														end as "Nivel de transacciones"
 from company join (Select company_id, count(id) as Cantidad_Transacciones 
					from transaction
					group by company_id) as Cuentas on company.id = Cuentas.company_id
Order by 2 desc;
 
 
 
 
 
 
 
 
 
 
 