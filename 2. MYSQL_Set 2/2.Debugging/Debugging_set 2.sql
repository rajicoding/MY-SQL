-- 1. Retrieve Employees in Finance Department
select * from employees;
select * from departments;
-- Incorrect Code 
-- Condition criteria is wrongly mentioned. 
SELECT name, salary
FROM employees
WHERE department_id = 'Finance';
-- Correct query
SELECT e.name, e.salary
FROM employees e
JOIN departments d
ON e.department_id=d.department_id
WHERE department_name='Finance';

-- 2. Calculate Total Sales for Each Customer
-- Incorrect Code
-- unknown column customer_name.. customer_name is not available in the sales table
SELECT customer_name, SUM(amount) AS total_sales
FROM sales
GROUP BY customer_name;
-- correct query
SELECT customer_id, SUM(amount) AS total_sales
FROM sales
GROUP BY customer_id;

-- 3. Find Products Priced Over the Average Price
-- Incorrect Code
-- invalid use of group function
SELECT product_name, price
FROM products
WHERE price > AVG(price);
-- correct query
SELECT product_name, price 
FROM products
WHERE price > 
(select avg(price) FROM products);
-- 4. Get Customers Who Have Placed Orders Over 1000
-- Incorrect Code
SELECT DISTINCT customer_name
FROM orders
WHERE order_amount = 1000;
-- correct query 1
SELECT DISTINCT customer_name
FROM orders
WHERE order_amount > 1000;
-- correct query 2
SELECT customer_name, sum(order_amount) as total_amount
FROM Orders 
group by customer_name
HAVING sum(order_amount)>1000;

-- 5. Find Total Sales for Each Customer
-- Incorrect Code
-- missing group by 
SELECT customer_id, SUM(amount) 
FROM sales;  
-- correct query
SELECT customer_id, SUM(amount) 
FROM sales 
GROUP BY customer_id;  


