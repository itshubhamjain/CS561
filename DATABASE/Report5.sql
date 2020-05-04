

WITH Q1(CUSTOMER, PRODUCT, MAXQUANT, STATE) AS
	(select cust, prod,max(quant) ,state
	from sales
	where state in('NY','CT', 'NJ')
	group by state,cust, prod
	order by cust),
	
	Q2(CUSTOMER, PRODUCT, DATENJ, NJ_MAX) AS
	(select Q1.CUSTOMER,Q1.PRODUCT,CONCAT(month,'/',day,'/',year) as DATE,Q1.MAXQUANT
		from Q1, sales
	 where Q1.state = 'NJ' and sales.quant = Q1.MAXQUANT and sales.prod = Q1.PRODUCT and sales.cust = Q1.CUSTOMER
	),
	Q3(CUSTOMER, PRODUCT, DATENY, NY_MAX) AS
	(select Q1.CUSTOMER,Q1.PRODUCT,CONCAT(month,'/',day,'/',year) as DATE,Q1.MAXQUANT
		from Q1, sales
	 where Q1.state = 'NY' and sales.quant = Q1.MAXQUANT and sales.prod = Q1.PRODUCT and sales.cust = Q1.CUSTOMER
	),
	
	Q4(CUSTOMER, PRODUCT, DATECT, CT_MAX) AS
	(select Q1.CUSTOMER,Q1.PRODUCT,CONCAT(month,'/',day,'/',year) as DATE,Q1.MAXQUANT
		from Q1, sales
	 where Q1.state = 'CT' and sales.quant = Q1.MAXQUANT and sales.prod = Q1.PRODUCT and sales.cust = Q1.CUSTOMER
	)
	
	select q2.CUSTOMER, q2.PRODUCT, q2.NJ_MAX, q2.DATENJ AS DATE,  q3.NY_MAX,q3.DATENY AS DATE, q4.CT_MAX,  q4.DATECT AS DATE
	from Q2 q2
	inner join Q3 q3 on q2.CUSTOMER = q3.CUSTOMER and q2.PRODUCT = q3.PRODUCT 
	inner join Q4 q4 on q4.CUSTOMER = q3.CUSTOMER and q4.PRODUCT = q3.PRODUCT and (q3.NY_MAX > q2.NJ_MAX or q3.NY_MAX > q4.CT_MAX);