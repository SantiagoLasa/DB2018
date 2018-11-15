1---Retrieve Internet Sales Amount As Per Customer. In other words, we can say show the Detail of amount spent by customers during purchase from Internet.

select dimcustomer.firstname, sum (factinternetsales.salesamount) as "monto gastado"
from dimcustomer
inner join factinternetsales using (customerkey)
group by firstname;


2---View Internet Sales amount detail between year 2005 to 2008

select dimdate.calendaryear, factinternetsales.productkey, sum(salesamount) as "monto gastado"
from factinternetsales
inner join dimdate on factinternetsales.duedatekey = dimdate.datekey
where calendaryear between 2005 and 2008
group by 2,1
order by 1;

3---View Internet Sales by product category and sub-category.

select dimproductsubcategory.englishproductsubcategoryname , 
dimproductcategory.englishproductcategoryname ,
sum(salesamount) as "monto gastado"
from factinternetsales
inner join dimproduct using(productkey)
inner join dimproductsubcategory using(productsubcategorykey)
inner join dimproductcategory using(productcategorykey)
group by englishproductsubcategoryname,englishproductcategoryname ;

4---View Internet Sales and Freight Cost by product category, sub-category and product.


select dimproductcategory.englishproductcategoryname ,dimproductsubcategory.englishproductsubcategoryname , 
dimproduct.englishproductname , sum(salesamount) as "monto gastado", sum(freight) as "precio de lo frito"
from factinternetsales 
inner join dimproduct using(productkey)
inner join dimproductsubcategory using(productsubcategorykey)
inner join dimproductcategory using(productcategorykey)
group by englishproductname, englishproductcategoryname, englishproductsubcategoryname;

5---Retrieve only those products whose names begin with “A” and Internet sales amount <5000

select dimproduct.englishproductname, sum(salesamount) as "monto_gastado"
from factinternetsales
inner join dimproduct using(productkey)
where dimproduct.englishproductname like 'A%'
group by englishproductname
having SUM(salesamount::numeric) < 5000
order by monto_gastado


6---What is sales amount in all the countries?? 

select dimsalesterritory.salesterritorycountry as "Pais", sum(salesamount) as "monto gastado"
from factinternetsales
inner join dimsalesterritory using (salesterritorykey)
group by dimsalesterritory.salesterritorycountry
order by dimsalesterritory.salesterritorycountry;

7----Retrieve all the products in descending order of their Internet sales amount of year 2007 

select dimproduct.englishproductname , dimdate.calendaryear , sum(salesamount) as "monto gastado"
from factinternetsales
inner join dimdate on factinternetsales.duedatekey = dimdate.datekey
inner join dimproduct using (productkey)
where dimdate.calendaryear = 2007
group by dimproduct.englishproductname, dimdate.calendaryear
order by 3 desc

8---Generate a report with Internet Sales sub total, grand total per year and month.

select  dimdate.calendaryear, dimdate.monthnumberofyear,  sum(salesamount)
from factinternetsales
inner join dimdate on factinternetsales.orderdatekey = dimdate.datekey
group by rollup(1,2)
order by 1,2;

9---Generate a report with the amount of "Pedals" and "Tires and Tubes" category of products in the inventory.
-- Also with the amount of in and outs of each of them on the second half of the year 2006.

select  dimproductsubcategory.englishproductsubcategoryname, dimproductcategory.englishproductcategoryname, 
dimproduct.englishproductname, count(productkey) as "cantidad " , sum(unitsin) as "in", sum(unitsout) as "out"
from factproductinventory
inner join dimproduct using(productkey)
inner join dimdate using(datekey)
inner join dimproductsubcategory using(productsubcategorykey) 
inner join dimproductcategory using(productcategorykey)
where dimproductsubcategory.englishproductsubcategoryname like '%Pedal%'
or dimproductsubcategory.englishproductsubcategoryname like '%Tire%'
and fiscalyear = 2006 and fiscalsemester = 1
group by (1,2,3)
order by 1

10--- Generate a report with the amount of calls, automatic responses and issues raised by the call center operators.
--- On working days during the morning shift, from the 20th working week until the end of the year 2007.

select count(calls) as "call", count(automaticresponses) as "Automatic responses",
count(issuesraised) as "issues raised"
from factcallcenter
inner join dimdate using(datekey)
where englishdaynameofweek not in ('Sunday', 'Saturday')
and shift like '%AM%'
and weeknumberofyear >= 20 
and fiscalyear = 2007
