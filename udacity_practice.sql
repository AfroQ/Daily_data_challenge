-- ORDER BY

-- display the order ID, account ID, and total dollar amount 
-- for all the orders
SELECT id, account_id, total_amt_usd
FROM orders
-- sorted first by the account ID (in ascending order), 
-- and then by the total dollar amount (in descending order).
ORDER BY account_id, total_amt_usd desc;

/* write a query that again displays order ID, account ID, and total dollar amount 
for each order, 
but this time sorted first by total dollar amount (in descending order), 
and then by account ID (in ascending order). 
*/
SELECT id, account_id, total_amt_usd
FROM orders
ORDER BY total_amt_usd desc, account_id

/* WHERE
Commonly when we are using WHERE with non-numeric data fields, 
we use the LIKE, NOT, or IN operators. */
SELECT name, website, primary_poc
FROM accounts
WHERE name = 'Exxon Mobil';