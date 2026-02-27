#  SQL Sales & Customer Analytics Project

##  Project Overview
This project analyzes sales and customer performance using SQL.
The goal is to extract business insights such as top products, top customers, and revenue trends.

---

##  Database Structure

### Tables Used:
- customers
- products
- orders
- order_details

---

##  Key Business Questions Solved

1. Total revenue per product
2. Top 3 revenue-generating products
3. Total revenue per customer
4. Top 3 customers by revenue
5. Ranking customers using RANK()
6. Monthly revenue analysis

---

##  SQL Skills Demonstrated

- INNER JOIN
- LEFT JOIN
- GROUP BY
- Aggregate Functions (SUM, COUNT)
- Subqueries
- Window Functions (RANK)
- ORDER BY & LIMIT

---

##  Sample Query (Top 3 Customers)

```sql
SELECT c.customer_name,
       SUM(od.quantity * p.price) AS total_revenue
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id
JOIN order_details od
ON o.order_id = od.order_id
JOIN products p
ON od.product_id = p.product_id
GROUP BY c.customer_name
ORDER BY total_revenue DESC
LIMIT 3;

**Key Insights**

Identified highest revenue-generating products

Ranked customers based on spending

Calculated overall business revenue

Built multi-table join logic

**Author**

Krishna Lakke
Aspiring Data Analyst | SQL | Power BI | Excel.
