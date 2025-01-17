/*Diego Mere
Sprint 2 / Nivel 2*/

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

-- Exercici 3.1 Mostra el llistat aplicant JOIN i subconsultes.
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
