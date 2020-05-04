
	
WITH Q1(CUSTOMER, MIN_Q, MAX_Q, AVG_Q) AS
	(SELECT cust as CUSTOMER, min(quant) as MIN_Q, max(quant) as MAX_Q, avg(quant) as AVG_Q
		FROM sales
			group by cust
	),
	Q2(CUSTOMER, MIN_Q, MAX_Q, AVG_Q, MIN_PROD, MIN_DATE, ST) AS
	(SELECT Q1.CUSTOMER, Q1.MIN_Q, Q1.MAX_Q, Q1.AVG_Q, prod as MIN_PROD, CONCAT(month,'/',day,'/',year) as MIN_DATE, state as ST
		FROM sales, Q1
	 	where Q1.CUSTOMER = sales.cust and Q1.MIN_Q = sales.quant 
	)
	
	select Q2.CUSTOMER, Q2.MIN_Q, Q2.MAX_Q, Q2.AVG_Q, Q2.MIN_PROD, Q2.MIN_DATE, Q2.ST, sales.prod as MAX_PROD,CONCAT(sales.month,'/',sales.day,'/',sales.year) as MAX_DATE, sales.state as ST
		
		from Q2,sales
			where Q2.CUSTOMER = sales.cust and sales.quant = Q2.MAX_Q;


			
		

