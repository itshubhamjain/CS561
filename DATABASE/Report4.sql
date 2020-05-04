WITH Q1(CUSTOMER, PRODUCT, COUNT1, Q1_AVG) AS
(select cust, prod, count(cust), avg(quant)
	from sales
	where month in(1,2,3)
	group by cust, prod
	order by cust,prod),
	Q2(CUSTOMER, PRODUCT,COUNT2,Q2_AVG) AS
	( select s1.cust, s1.prod,count(cust), avg(s1.quant)
	from sales s1
	where s1.month in(4,5,6)
	group by s1.cust, s1.prod
	),
	Q3(CUSTOMER, PRODUCT,COUNT3, Q3_AVG) AS
	( select s2.cust, s2.prod,count(cust), avg(s2.quant)
	from sales s2
	where s2.month in(7,8,9)
	group by s2.cust, s2.prod
	),
	Q4(CUSTOMER, PRODUCT,COUNT4, Q4_AVG) AS
	( select s3.cust, s3.prod,count(cust), avg(s3.quant)
	from sales s3
	where s3.month in(10,11,12)
	group by s3.cust, s3.prod
	),
	Q5(CUSTOMER, PRODUCT, AVERAGE, COUNT, TOTAL) AS 
	(select cust, prod, avg(quant), count(*), sum(quant)
	from sales
	group by cust, prod
	)
	
   select Q1.CUSTOMER, Q1.PRODUCT, CAST(Q1_AVG AS INT), CAST(Q2_AVG AS INT),CAST(Q3_AVG AS INT),CAST(Q4_AVG AS INT),CAST(AVERAGE AS INT), TOTAL, COUNT
	from Q1,Q2,Q3,Q4,Q5
	where Q1.CUSTOMER = Q2.CUSTOMER and Q2.CUSTOMER = Q3.CUSTOMER and Q3.CUSTOMER = Q4.CUSTOMER and Q1.PRODUCT = Q2.PRODUCT and Q2.PRODUCT = Q3.PRODUCT and Q3.PRODUCT = Q4.PRODUCT
	and Q1.CUSTOMER = Q5.CUSTOMER and Q1.PRODUCT = Q5.PRODUCT
	order by Q1.CUSTOMER, Q1.PRODUCT
	;	
	