/*Diego Mere
Sprint 2 / Nivel 1

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
where declined = 0
order by 1; 


-- Nivell 1 Exercici 2.2  Des de quants països es realitzen les compres.

select count(distinct country)
from transaction join company on transaction.company_id = company.id
where declined = 0;
 

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