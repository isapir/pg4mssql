/**
	Ensure same results for top 10 orders and line items in 2014
 */

SELECT 	TOP 10
		SOH.SalesOrderID, 
		SOH.OrderDate,
		count(SOD.SalesOrderID) AS line_items, 
		sum(SOD.LineTotal) AS total_amount
FROM 	Sales.SalesOrderDetail SOD 
	JOIN Sales.SalesOrderHeader SOH ON SOH.SalesOrderID = SOD.SalesOrderID
WHERE 	year(SOH.OrderDate) = 2014
GROUP BY SOH.SalesOrderID, SOH.OrderDate 
ORDER BY total_amount DESC;

---

SELECT 	SOH.sales_order_id, 
		SOH.order_date,
		count(SOD.sales_order_id) AS line_items, 
		sum(SOD.line_total) AS total_amount
FROM 	sales.sales_order_detail SOD 
	JOIN sales.sales_order_header SOH ON SOH.sales_order_id = SOD.sales_order_id
WHERE 	date_part('year', SOH.order_date) = 2014
GROUP BY SOH.sales_order_id, SOH.order_date 
ORDER BY total_amount DESC 
LIMIT 10;
