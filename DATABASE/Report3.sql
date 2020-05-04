WITH Q1(prod, month, TOTALSALES) AS
	(SELECT prod, month,sum(quant) AS TOTALSALES
		from sales
	 		group by prod, month
	),
	
	Q2(prod, MAX_Q, MIN_Q) AS
	(select Q1.prod,max(Q1.TOTALSALES), min(Q1.TOTALSALES)
		from Q1 
	group by Q1.prod
	),
	Q3(prod, LEAST_FAV_MO) AS
	(select Q2.prod, Q1.month
		from Q2, Q1
	 where Q2.MIN_Q = Q1.TOTALSALES
	)
	select Q2.prod, Q1.month AS MOST_FAV_MO, Q3.LEAST_FAV_MO
		from Q3,Q2,Q1
	where Q2.prod = Q3.prod and Q2.MAX_Q = Q1.TOTALSALES;