with q1 (cust, prod, state, avg) as
	(select cust, prod, state, round(avg(quant),0)
		from sales
	 group by cust, prod, state
	),
	
	q2(CUSTOMER, PRODUCT, STATE, PROD_AVG , OTHER_CUST_AVG, OTHER_PROD_AVG) as
	(
		select q1.cust, q1.prod, q1.state, q1.avg, round(avg(others.quant),0), round(avg(others_2.quant),0)
		from q1 left join sales as others 
			on q1.prod = others.prod and q1.state = others.state 
			and others.cust <> q1.cust
		left join sales as others_2	
			on q1.cust = others_2.cust and q1.state = others_2.state 
			and others_2.prod <> q1.prod
		
		group by q1.cust, q1.prod, q1.state, q1.avg
		order by q1.cust, q1.prod, q1.state
	)
	

	select * from q2;