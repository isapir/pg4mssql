/**
    Ensure same results from UDF ufnGetProductListPrice()
 */

SELECT 	v.*, 
        dbo.ufnGetProductListPrice(v.product_id, v.order_date) AS func_result
FROM 	(VALUES
    (712, '2013-01-01'),
    (712, '2014-01-01'),
    (724, '2012-01-01'),
    (724, '2013-05-01'),
    (724, '2013-06-01')
) v(product_id, order_date)
ORDER BY product_id, order_date;

---

SELECT 	v.*, 
        public.fn_get_product_list_price(v.product_id, v.order_date::date) AS func_result
FROM 	(VALUES
    (712, '2013-01-01'),
    (712, '2014-01-01'),
    (724, '2012-01-01'),
    (724, '2013-05-01'),
    (724, '2013-06-01')
) v(product_id, order_date)
ORDER BY product_id, order_date;
