/**
    Ensure same results from UDF ufnGetStock()
 */

SELECT 	v.*, 
        dbo.ufnGetStock(v.product_id) AS func_result
FROM 	(VALUES
    (358),
    (359),
    (360),
    (361),
    (999)
) v(product_id)
ORDER BY product_id;

---

SELECT 	v.*, 
        public.fn_get_stock(v.product_id) AS func_result
FROM 	(VALUES
    (358),
    (359),
    (360),
    (361),
    (999)
) v(product_id)
ORDER BY product_id;
