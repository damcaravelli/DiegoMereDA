-- Nivell 2
-- Crea una nova taula que reflecteixi l'estat de les targetes de crèdit basat en si les últimes tres transaccions van ser declinades i genera la següent consulta:

create table Estado_Tarjetas
SELECT card_id, CASE 
					WHEN SUM(declined) = 3 THEN 'Desactivada'
					ELSE 'Activa'
					END AS Estado
FROM (SELECT card_id, declined
		FROM (SELECT card_id, declined, ROW_NUMBER() OVER (PARTITION BY card_id ORDER BY timestamp DESC) AS Ultimas
        FROM transaction) t
    WHERE t.Ultimas <= 3
) X
GROUP BY card_id;

-- Exercici 1. Quantes targetes estan actives?

select count(Estado) Tarjetas_Activas
from Estado_Tarjetas
where Estado = "Activa";

           

                        