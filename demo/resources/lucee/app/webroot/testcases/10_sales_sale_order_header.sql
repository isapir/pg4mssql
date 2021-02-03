/** 
    Ensure same sum and count from Sales.SalesOrderHeader
 */

SELECT 	sum(S.TotalDue) AS sum, count(*) AS count
FROM 	Sales.SalesOrderHeader S;

---

SELECT 	sum(S.total_due) AS sum, count(*) AS count
FROM 	sales.sales_order_header S;
