USE classicmodels;

SELECT CONCAT(contactLastName, ", ", contactFirstName) AS 'Customer Name'
FROM customers
ORDER BY 'Customer Name';

SELECT p.productName AS 'Product Name', SUM(o.quantityOrdered) AS 'Total # Ordered', SUM(o.quantityOrdered * priceEach) AS 'Total Sale'
FROM products p JOIN orderdetails o ON p.productCode = o.productCode
GROUP BY p.productName
ORDER BY SUM(o.quantityOrdered * priceEach) DESC;

SELECT UNIQUE(status) AS 'Order Status', COUNT(*) AS '# Orders'
FROM orders
GROUP BY status
ORDER BY STATUS;

SELECT p.productLine AS 'Product Line', SUM(o.quantityOrdered) AS '# Sold'
FROM products p JOIN orderdetails o ON p.productCode = o.productCode
GROUP BY p.productLine
ORDER BY SUM(o.quantityOrdered) DESC;

SELECT CONCAT(e.lastName, ', ', e.firstName) AS 'Sales Rep', COUNT(*) AS '# Orders', CAST(IFNULL(SUM(od.quantityOrdered * od.priceEach), 0) AS DECIMAL(18, 2)) AS 'Total Sales'
FROM employees e 
LEFT JOIN customers c ON e.employeeNumber = c.salesRepEmployeeNumber
LEFT JOIN orders o ON c.customerNumber = o.customerNumber
LEFT JOIN orderdetails od ON o.orderNumber = od.orderNumber
WHERE e.jobTitle = 'Sales Rep'
GROUP BY CONCAT(e.lastName, ', ', e.firstName)
ORDER BY SUM(od.quantityOrdered * od.priceEach) DESC;

SELECT MONTHNAME(paymentDate) AS 'Month', REPLACE(YEAR(paymentDate), ',', '') AS 'Year', CAST(IFNULL(SUM(amount), 0) AS DECIMAL(18, 2)) AS 'Payments Received'
FROM payments
GROUP BY MONTH(paymentDate), YEAR(paymentDate)
ORDER BY YEAR(paymentDate), MONTH(paymentDate);
