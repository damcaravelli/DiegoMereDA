/*Diego Mere
Sprint 2 / Nivel 3*/

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