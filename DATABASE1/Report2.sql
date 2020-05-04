with Q1 (cust, prod, MONTH, AVGMONTH) as
	(	select cust, prod,month, round(avg(quant), 0)
	 	from sales
	 	group by cust, prod, month
	 	
	),
	Q2 (cust, prod, MONTH, BEFORE_AVG,DURING_AVG, AFTER_AVG) as 
	( select Q1.cust, Q1.prod,Q1.MONTH, before.AVGMONTH, Q1.AVGMONTH, next.AVGMONTH
	 	from Q1 left outer join Q1 as before
	 	on Q1.cust = before.cust and Q1.prod = before.prod and before.MONTH = Q1.MONTH -1 
	left outer join Q1 as next
	 	on Q1.cust = next.cust and Q1.prod = next.prod and next.MONTH = Q1.MONTH +1 
	 
	group by Q1.cust, Q1.prod,Q1.MONTH, before.AVGMONTH,Q1.AVGMONTH, next.AVGMONTH
	order by Q1.cust, Q1.prod, Q1.MONTH
	)
	
select Q1. cust, Q1.prod, Q1.month, Q2.BEFORE_AVG, Q2.DURING_AVG, Q2.AFTER_AVG
	from Q1 left outer join Q2
	on Q1.cust = Q2.cust and Q1.prod = Q2.prod and Q1.MONTH = Q2.MONTH