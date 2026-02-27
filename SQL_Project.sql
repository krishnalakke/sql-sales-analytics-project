use shiva 
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(50),
    city VARCHAR(50)
);
CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(50),
    category VARCHAR(50),
    price DECIMAL(10,2)
);
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);
CREATE TABLE order_details (
    order_id INT,
    product_id INT,
    quantity INT,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

INSERT INTO customers VALUES
(1, 'Ravi', 'Hyderabad'),
(2, 'Sita', 'Bangalore'),
(3, 'Aman', 'Chennai'),
(4, 'Neha', 'Hyderabad'),
(5, 'Kiran', 'Mumbai');

INSERT INTO products VALUES
(101, 'Laptop', 'Electronics', 60000),
(102, 'Mobile', 'Electronics', 20000),
(103, 'Headphones', 'Accessories', 2000),
(104, 'Shoes', 'Fashion', 3000),
(105, 'Watch', 'Fashion', 5000);

INSERT INTO orders VALUES
(1001, 1, '2025-01-10'),
(1002, 2, '2025-01-12'),
(1003, 1, '2025-02-05'),
(1004, 3, '2025-02-15'),
(1005, 4, '2025-03-01'),
(1006, 5, '2025-03-10');

INSERT INTO order_details VALUES
(1001, 101, 1),
(1001, 103, 2),
(1002, 102, 1),
(1003, 104, 2),
(1003, 105, 1),
(1004, 101, 1),
(1005, 103, 3),
(1006, 104, 1),
(1006, 102, 2);

show tables

select * from customers;
select * from products ;
select * from orders;
select * from order_details;


--Show all orders with customer name and order date.

select o.order_id,c.customer_name,o.order_date
from orders o
join customers c
on c.customer_id=o.customer_id;

--Show order details with product name and quantity.

select od.order_id,p.product_name,od.quantity
from order_details od 
join products p
on p.product_id=od.product_id;

--Show total quantity sold per product.

select p.product_name,sum(od.quantity) as Total_Quantity
from products p
join order_details od
on p.product_id = od.product_id
group by product_name;


--Show total number of orders per customer

select c.customer_name , count(o.order_id) as total_orders
from customers c
join orders o
on c.customer_id = o.customer_id
group by c.customer_name;


--Calculate total revenue per product

select p.product_name,sum(od.quantity*p.price) as total_revenue
from order_details od
join products p  on p.product_id= od.product_id
group by p.product_name;

--Sort products by total revenue (highest first)

select p.product_name,sum(od.quantity*p.price) as total_revenue
from order_details od
join products p  on p.product_id= od.product_id
group by p.product_name
order by total_revenue desc;
select * from customers
select * from order_details
select * from orders
select * from products



--Show total revenue per customer

select c.customer_name,
       sum(od.quantity * p.price) as total_revenue
from customers c
join orders o
on c.customer_id = o.customer_id
join order_details od
on o.order_id = od.order_id
join products p
on od.product_id = p.product_id
group by c.customer_name
order by total_revenue desc


--Top 3 revenue products

select p.product_name,
       sum(od.quantity*p.price) as total_revenue
from order_details od
join products p 
on  p.product_id = od.product_id
group by p.product_name
order by total_revenue desc
limit 3;

--Top 3 Customers by Revenue

select c.customer_name,
       sum(od.quantity * p.price) as total_revenue
from customers c
join orders o
on o.customer_id = c.customer_id
join order_details od
on o.order_id = od.order_id
join products p
on od.product_id = p.product_id
group by c.customer_name
order by total_revenue desc
limit 3;

--Rank customers by total revenue (highest first)

select  customer_name,
       total_revenue,
       rank() over (order total_revenue desc) as revenue_rank
from (
    select c.customer_name,
           sum(od.quantity * p.price) as total_revenue
    from customers c
    join orders o
        on c.customer_id = o.customer_id
    join order_details od
        on o.order_id = od.order_id
    join products p
        on od.product_id = p.product_id
    group by c.customer_name
) as revenue_table;

