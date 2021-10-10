select orderdate, sum(totalamount) from orders o join
(
select customerid, 
	10 - mod(
		(case when substring(creditcard, 14, 1)::integer*2 > 9 then substring(creditcard, 14, 1)::integer*2 - 9 else substring(creditcard, 14, 1)::integer*2 end
+ case when substring(creditcard, 12, 1)::integer*2 > 9 then substring(creditcard, 12, 1)::integer*2 - 9 else substring(creditcard, 12, 1)::integer*2 end
+ case when substring(creditcard, 10, 1)::integer*2 > 9 then substring(creditcard, 10, 1)::integer*2 - 9 else substring(creditcard, 10, 1)::integer*2 end
+ case when substring(creditcard, 8, 1)::integer*2 > 9 then substring(creditcard, 8, 1)::integer*2 - 9 else substring(creditcard, 8, 1)::integer*2 end
+ case when substring(creditcard, 6, 1)::integer*2 > 9 then substring(creditcard, 6, 1)::integer*2 - 9 else substring(creditcard, 6, 1)::integer*2 end
+ case when substring(creditcard, 4, 1)::integer*2 > 9 then substring(creditcard, 4, 1)::integer*2 - 9 else substring(creditcard, 4, 1)::integer*2 end
+ case when substring(creditcard, 2, 1)::integer*2 > 9 then substring(creditcard, 2, 1)::integer*2 - 9 else substring(creditcard, 2, 1)::integer*2 end
+ 
	substring(creditcard, 15, 1)::integer
	+ substring(creditcard, 13, 1)::integer
	+ substring(creditcard, 11, 1)::integer
	+ substring(creditcard, 9, 1)::integer
	+ substring(creditcard, 7, 1)::integer
	+ substring(creditcard, 5, 1)::integer
	+ substring(creditcard, 3, 1)::integer
	+ substring(creditcard, 1, 1)::integer)
		, 10) = substring(creditcard, 16, 1)::integer as valid_card
    from customers ) c on c.customerid=o.customerid
	where not c.valid_card
	group by orderdate
