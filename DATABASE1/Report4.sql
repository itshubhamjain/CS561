with custprod (cust, prod, summm) as
	(
		select cust, prod, sum(quant)
			from sales
		group by cust, prod
	),
	
	q1 (cust, prod, month, SUMQUANT) as
	(
		select cust, prod,month, sum(quant)
			from sales
		group by cust, prod, month
		
	),
	q2 (cust, prod, month,CUMULATIVE) as
	(
		select q1.cust, q1.prod, q1.month, sum(calcu.SUMQUANT)
		from q1 left join q1 as calcu
			on calcu.cust = q1.cust and calcu.prod = q1.prod and 
			q1.month >= calcu.month
			group by q1.cust, q1.prod, q1.month
		order by q1.cust, q1.prod, q1.month
	)
	,
	
	q3 (CUSTOMER, PRODUCT, _1_3rd_PURCHASED_BY_MONTH) as
	(	select q2.cust, q2.prod, min(q2.month)
	 	from q2, custprod
	 	where q2.cust = custprod.cust and q2.prod = custprod.prod 
	 and 3*q2.CUMULATIVE > custprod.summm
	 group by q2.cust, q2.prod
	 
	)
select * from q3;

-- 2220
-- 4778
-- 6069
-- 417
-- 1200
-- 1494