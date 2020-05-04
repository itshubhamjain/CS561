WITH Q1(MONTH, DAY, TOTALSALES) AS
	(select month,day, sum(quant)
	from sales
	group by day, month

	),
	Q2(MONTH, LEASTPROFIT, MAXPROFIT)AS
	(select Q1.month, min(Q1.TOTALSALES),max(Q1.TOTALSALES)
		from Q1
	 group by Q1.month
	),
	Q3(MONTH,DAY, LEASTPROFIT) AS
	( select Q2.MONTH, Q1.DAY, Q2.LEASTPROFIT
	 from Q1,Q2 
	 where Q1.TOTALSALES = Q2.LEASTPROFIT and Q1.MONTH = Q2.MONTH
	
	)
	select Q3.MONTH, Q1.day AS MOST_PROFIT_DAY,Q2.MAXPROFIT AS MOST_PROFIT_TOTAL_Q, Q3.DAY AS LEAST_PROFIT_DAY, Q3.LEASTPROFIT AS LEAST_PROFIT_TOTAL_Q
		from Q3,Q2,Q1
		where Q3.LEASTPROFIT = Q2.LEASTPROFIT and Q3.MONTH = Q2.MONTH and Q1.MONTH = Q2.MONTH and Q1.TOTALSALES = Q2.MAXPROFIT
		order by Q3.MONTH
		;