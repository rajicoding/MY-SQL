USE practicedb;
-- 1. Identify Customers with No Orders in the Last 30 Days.
-- Find customers who have not placed any orders in the last 30 days.
SELECT e.name FROM employees e
JOIN orders o 
ON e.name=o.customer_name
WHERE e.name NOT IN 
(SELECT customer_name FROM orders where order_date<=curdate()-INTERVAL 30 DAY);


-- 2. Find Employees Who Earn Above Department Average.
-- Retrieve employee names and their salaries who earn more than the average salary of their respective department.
SELECT e.name, e.salary FROM employees e
WHERE e.salary > (SELECT avg(salary) FROM employees e2
      WHERE e.department_id=e2.department_id);



-- 3. Identify Products with a Price Above Average.
-- Find products whose price is above the average price of all products.
SELECT product_name FROM products
WHERE price > (SELECT avg(price) FROM products);

-- 4. Find Customers Who Placed Multiple Orders.
-- Identify customers who have placed more than one order
SELECT customer_name, count(order_id) FROM orders
GROUP BY customer_name
HAVING count(order_id)>1;
SELECT customer_name, count(order_id) FROM orders
GROUP BY customer_name;
-- 5. Detect Employees with the Same Salary.
-- Find employees who have the same salary as someone else.
select * from employees;
SELECT e.name, e.salary FROM employees e
WHERE e.salary in (SELECT e1.salary from employees e1 where e.employee_id <> e1.employee_id );
SELECT e.name, e.salary FROM employees e
JOIN employees e1 
ON e.salary=e1.salary
AND e.employee_id<>e1.employee_id;