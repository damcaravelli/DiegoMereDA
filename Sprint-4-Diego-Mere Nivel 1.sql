-- Nivell 1
-- Descàrrega els arxius CSV, estudia'ls i dissenya una base de dades amb un esquema d'estrella que contingui, almenys 4 taules de les quals puguis realitzar les següents consultes:

/* Exercici 1
Realitza una subconsulta que mostri tots els usuaris amb més de 30 transaccions utilitzant almenys 2 taules.*/

SELECT name
FROM user
WHERE id IN (SELECT user_id
			FROM transaction
			GROUP BY user_id
			HAVING COUNT(*) > 30
);

/*Exercici 2
Mostra la mitjana d'amount per IBAN de les targetes de crèdit a la companyia Donec Ltd, utilitza almenys 2 taules.*/

SELECT credit_cards.iban, ROUND(AVG(transaction.amount), 2) AS Media
FROM credit_cards 
JOIN transaction ON credit_cards.id = transaction.card_id
JOIN companies ON companies.company_id = transaction.business_id
WHERE companies.company_name = 'Donec Ltd'
GROUP BY credit_cards.iban;

