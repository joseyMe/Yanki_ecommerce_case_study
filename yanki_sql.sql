--Window Functions:
-- Calculate the total sales amount for each order along with the individual product sales.
SELECT 
	o.order_ID,
	p.Product_ID,
	p.Price,
	o.Quantity,
	o.Total_price,
	SUM(p.Price*o.Quantity) OVER (PARTITION BY o.order_ID) AS total_sales_amount
FROM
	yanki.orders o
JOIN
	yanki.products p ON o.Product_ID=p.Product_ID;

-- Calculate the running total price for each order.

SELECT
	Order_ID,
	Product_ID,
	Quantity,
	Total_price,
	SUM(Total_price) OVER (ORDER BY Order_ID) AS running_total_price
FROM
	yanki.orders;

--Rank products by their price within each category

SELECT
	Product_ID,
	Product_name,
	Brand,
	Price,
	Category,
	RANK() OVER (PARTITION BY category ORDER BY Price DESC) AS price_rank_by_category
FROM
	yanki.products;

--Rankings
--Rank customers by total amount they have spent
SELECT
	c.Customer_ID,
	c.Customer_name,
	SUM(Total_Price) as total_spent,
	RANK() OVER (ORDER BY SUM(Total_Price) DESC) as customer_rank
FROM
	yanki.customers c
JOIN
	yanki.orders o ON c.Customer_ID=o.Customer_ID
GROUP BY
	c.Customer_ID,
	c.Customer_Name;
---Rank products by their total sales amount.
SELECT
	p.Product_ID,
	p.Product_name,
	SUM(o.Quantity) AS total_quantity_sold,
	SUM(o.Total_Price) as total_sales_amount,
	RANK() OVER (ORDER BY SUM(Total_Price) DESC) as product_rank
FROM
	yanki.products p
JOIN
	yanki.orders o ON p.Product_ID=o.Product_ID
GROUP BY
	p.Product_ID,
	p.Product_Name;
---Rank orders by their total price

SELECT
	Order_ID,
	Total_price,
	RANK() OVER (ORDER BY Total_Price DESC) as order_rank
FROM
	yanki.orders;