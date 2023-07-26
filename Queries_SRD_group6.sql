
use jb;

/* 1) List all the customer’s names, dates, and products bought by these customers in a range of two dates
In this Query we start by using CONCAT to get the first name and last name and show it as Customer Name.
Then we select the Date and the Product Name
To get this information we need associate the IDs from the tables Customers, Transactions, Products and Cart
In the end we define a date and we order by the dates. */

SELECT CONCAT(c.`First_Name`, ' ', c.`Last_Name`) AS 'Customer Name',
		t.`Date`,
       p.`Product_Name`	
FROM Customers c, transactions t, products p, Cart ct
WHERE c.`ID_Customer` = t.`ID_Customer`
AND t.`ID_Cart` = ct.`ID_Cart`
AND ct.`ID_Product` = p.`ID_Product`
AND t.`Date` BETWEEN '2020-01-01' AND '2020-06-30'
ORDER BY t.`Date`;


/*We divided the query number 2 in tree parts.
For the first part (2.1) we get the best tree customers by showwing their names.
To get this information we need to do several INNER JOINS witht he tables transaction, cart, customers and products
Then we show the total amount spent by using the SUM function with the product price associated to the customer
At the end we group by Customer Name, we order by Total Amount and we use LIMIT 3 to get the top 3 customers.
2.1) List the best three customers */
SELECT concat(cu.`First_name`, ' ', cu.`Last_name`) as `Customer Name`, SUM(p.`Price`) as `Total Amount` 
FROM transactions T INNER JOIN cart ct ON t.ID_Cart = ct.ID_Cart
					INNER JOIN customers cu  ON t.ID_Customer = cu.ID_Customer
                    INNER JOIN products p ON ct.ID_Product = p.ID_Product
GROUP BY `Customer Name`
ORDER BY `Total Amount` DESC
LIMIT 3;

/*2.2) List the three best selling products
For the 2 part (2.2) we did the same as before but now for the products 
To get this information we need to do several INNER JOINS witht he tables transaction, cart, customers and products
Here we get use the COUNT funciton to get the quantity of products sold by ID
In the end we group by Product Name and order by Quantity*/

SELECT p.`Product_Name` as `Product`, COUNT(ct.`ID_Product`) as `Quantity`  
FROM transactions T INNER JOIN cart ct ON t.ID_Cart = ct.ID_Cart
					INNER JOIN customers cu  ON t.ID_Customer = cu.ID_Customer
                    INNER JOIN products p ON ct.ID_Product = p.ID_Product
GROUP BY `Product_Name`
ORDER BY `Quantity`   DESC
LIMIT 3;

/*2.3) List the best stores 
For the 3 part (2.3) we did the same as before but now for the stores 
Here we get use the SUM funciton to get the Total Amount of sales by store ID
To get this information we need to do several INNER JOINS witht he tables cart, customers, products, employees and stores
So that we can get scan the tables by the diferent IDs
In the end we group by Product Name and order by Quantity**/

SELECT s.`ID_Store` as `Store`,  SUM(p.`Price`) as `Total Amount`  
FROM transactions t INNER JOIN cart ct ON t.ID_Cart = ct.ID_Cart
					INNER JOIN customers cu  ON t.ID_Customer = cu.ID_Customer
                    INNER JOIN products p ON ct.ID_Product = p.ID_Product
                    INNER JOIN employees e ON t.ID_Employee = e.ID_Employee
                    INNER JOIN stores s on e.ID_Store = s.ID_Store
GROUP BY `Store`
ORDER BY `Total Amount` DESC
LIMIT 3;


/*3) Get the average amount of saless for a period that involves 2 or more years
In this Query we start by using CONCAT to define the start and the end of date of salves as 'Period of Sales'
Then e use the SUM function to get the total Sales in that time period
After that we calculate the Yearly and Monthly average by diving the total sales by that time period and 
by 365 for the Yearly Average and 30 for the Monthly Average 
In the end we had to do 2 INNER JOINS so we can also get information from the cart and products table and associate the IDs
*/

SELECT 	CONCAT(min(t.`Date`),'  -  ', max(t.`Date`)) AS 'Period of Sales', 
		SUM(p.`Price`) AS 'Total Sales (euros)',
		round(SUM(p.`Price`)/(datediff(max(t.`Date`), min(t.`Date`))/365), 2) AS 'Yearly Average', 
        round(SUM(p.`Price`)/(datediff(max(t.`Date`), min(t.`Date`))/30), 2) AS 'Monthly Average'
FROM transactions t INNER JOIN cart ct ON t.ID_Cart = ct.ID_Cart
					INNER JOIN products p ON ct.ID_Product = p.ID_Product;


/*4) Get the total sales by geographical location (city/country)
In this Query we start by selecting the city and the total sum of the total price of he products as Total Sales
To associate every store with the location, transaction, employess, cart and products we had to make several INNER JOIN and associate the IDs
In the end we group by City and we roder by Total Sales*/
SELECT l.`city` AS City,  sum(p.`Price`) AS 'Total Sales'
FROM location l INNER JOIN stores s ON l.ID_Location = s.ID_Location
				INNER JOIN employees e ON s.ID_Store = e.ID_Store
                INNER JOIN transactions t ON e.ID_Employee = t.ID_Employee
                INNER JOIN cart ct ON t.ID_Cart = ct.ID_Cart
                INNER JOIN products p ON ct.ID_Product = p.ID_Product
GROUP BY l.`city`
ORDER BY `Total Sales` DESC;


/*5) List all the locations where products/services were sold, 
and the product has customer’s ratings
For this Query we Select the ID_Store as Store, and product name and the average product Rating.
After that we need to make several INNER JOINS so that we can associate the ids from the diferent tables.
In the end we group by Store and Product and we order by Store
*/
SELECT s.`ID_Store` AS Store, p.Product_Name AS Product,  round(AVG(ct.`Product_Rating`),2) AS 'Average Rating'
FROM location l INNER JOIN stores s ON l.ID_Location = s.ID_Location
				INNER JOIN employees e ON s.ID_Store = e.ID_Store
                INNER JOIN transactions t ON e.ID_Employee = t.ID_Employee
                INNER JOIN cart ct ON t.ID_Cart = ct.ID_Cart
                INNER JOIN products p ON ct.ID_Product = p.ID_Product
GROUP BY s.`ID_Store`, p.Product_Name
ORDER BY s.ID_Store;