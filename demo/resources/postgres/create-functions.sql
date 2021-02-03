
create or replace function public.fn_get_product_list_price(
	_product_id int, 
	_order_date date
)
	returns numeric 
	language sql as 
$$
	select  PLPH.list_price
	from    production.product P
		join production.product_list_price_history PLPH
			on PLPH.product_id = P.product_id 
				and P.product_id = _product_id
				and _order_date between PLPH.start_date and coalesce(PLPH.end_date, '9999-12-31');
$$;


create or replace function public.fn_get_stock(
	_product_id int
)
	returns int 
	language sql as	
$$
	-- TODO: planted bug - handle null
	select 	sum(PINV.quantity)
	from 	production.product_inventory PINV
	where 	PINV.product_id = _product_id
		and PINV.location_id = 6; -- Only look at inventory in the misc storage
$$;
