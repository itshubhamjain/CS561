WITH Q1(PRODUCT, MONTH, SALES) as 
	 (select prod, month, round(avg(quant), 0)
	  from sales
	  group by prod, month
	  order by prod, month
	 ),
	 
	Q2 ( PRODUCT, MONTH, SALES_COUNT_BETWEEN_AVGS) as
			(select sales.prod, sales.month , count(*)
				from sales 
				left  join Q1 as prev
					on sales.prod = prev.PRODUCT and 
						prev.MONTH = sales.month - 1
				left  join Q1 as next
					on sales.prod = next.PRODUCT and 
						next.MONTH = sales.month + 1
				
		where (sales.month > 1 and sales.month < 12) 
	and (
			(sales.quant >= prev.SALES and sales.quant <= next.SALES)or
			(sales.quant <= prev.SALES and sales.quant >= next.SALES) or
				(prev.SALES is null and sales.quant <= next.SALES ) or
			 (next.SALES is null and sales.quant <= prev.SALES )
			)
			 group by sales.prod, sales.month

)
	select Q1.PRODUCT, Q1. MONTH, Q2.SALES_COUNT_BETWEEN_AVGS
		from Q1 left join Q2
		on Q1.PRODUCT = Q2.PRODUCT and Q1.MONTH = Q2.MONTH