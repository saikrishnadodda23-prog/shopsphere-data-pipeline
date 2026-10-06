--CREATING SCHEMAS
CREATE SCHEMA raw;
CREATE SCHEMA staging;
CREATE SCHEMA core;
CREATE SCHEMA analytics;

SET search_path TO raw;

--Create Tables
--Customers
CREATE TABLE customers (
    customer_id       INT,
    first_name        VARCHAR(100),
    last_name         VARCHAR(100),
    email             VARCHAR(255),
    phone             VARCHAR(50),
    signup_date       DATE,
    customer_status   VARCHAR(30),
    updated_at        TIMESTAMP
);

--Customer Addresses
CREATE TABLE customer_addresses (
    address_id        INT,
    customer_id       INT,
    address_type      VARCHAR(30),
    address_line1     VARCHAR(255),
    city              VARCHAR(100),
    state             VARCHAR(100),
    postal_code       VARCHAR(20),
    country           VARCHAR(100),
    is_primary        BOOLEAN,
    updated_at        TIMESTAMP
);
--Categories
CREATE TABLE categories (
    category_id       INT,
    category_name     VARCHAR(100),
    parent_category_id INT
);
--Products
CREATE TABLE products (
    product_id        INT,
    product_name      VARCHAR(255),
    category_id       INT,
    product_price     NUMERIC(12,2),
    product_status    VARCHAR(30),
    created_at        DATE,
    updated_at        TIMESTAMP
);
--Orders
CREATE TABLE orders (
    order_id          INT,
    customer_id       INT,
    order_date        TIMESTAMP,
    order_status      VARCHAR(30),
    shipping_address_id INT,
    order_total       NUMERIC(12,2),
    updated_at        TIMESTAMP
);
--Order Items
CREATE TABLE order_items (
    order_item_id     INT,
    order_id          INT,
    product_id        INT,
    quantity          INT,
    unit_price        NUMERIC(12,2),
    discount_amount   NUMERIC(12,2)
);
--Payments
CREATE TABLE payments (
    payment_id        INT,
    order_id          INT,
    payment_date      TIMESTAMP,
    payment_method    VARCHAR(50),
    payment_status    VARCHAR(30),
    amount            NUMERIC(12,2),
    transaction_id    VARCHAR(100)
);
--Shipments
CREATE TABLE shipments (
    shipment_id       INT,
    order_id          INT,
    shipped_date      TIMESTAMP,
    delivered_date    TIMESTAMP,
    carrier           VARCHAR(50),
    shipping_status   VARCHAR(30)
);


--Insert Categories
INSERT INTO categories
(category_id, category_name, parent_category_id)
VALUES
(1, 'Electronics', NULL),
(2, 'Computers', 1),
(3, 'Mobile Phones', 1),
(4, 'Home & Kitchen', NULL),
(5, 'Furniture', 4),
(6, 'Appliances', 4),
(7, 'Accessories', 1);

--Insert Products
--Notice that some data is intentionally problematic.
INSERT INTO products
(product_id, product_name, category_id, product_price, product_status, created_at, updated_at)
VALUES
(101, 'Laptop Pro 15', 2, 1299.99, 'ACTIVE', '2024-01-10', '2024-03-01'),
(102, 'Laptop Air 13', 2, 999.99, 'ACTIVE', '2024-01-15', '2024-03-01'),
(103, 'Wireless Mouse', 7, 29.99, 'ACTIVE', '2024-01-20', '2024-02-20'),
(104, 'Mechanical Keyboard', 7, 89.99, 'ACTIVE', '2024-01-25', '2024-02-20'),
(105, 'Smartphone X', 3, 799.99, 'ACTIVE', '2024-02-01', '2024-03-10'),
(106, 'Smartphone Y', 3, 599.99, 'ACTIVE', '2024-02-05', '2024-03-10'),
(107, 'Air Fryer', 6, 149.99, 'ACTIVE', '2024-02-10', '2024-03-05'),
(108, 'Coffee Maker', 6, 79.99, 'ACTIVE', '2024-02-15', '2024-03-05'),
(109, 'Office Chair', 5, 249.99, 'ACTIVE', '2024-02-20', '2024-03-15'),
(110, 'Standing Desk', 5, 449.99, 'ACTIVE', '2024-02-25', '2024-03-15'),
(111, 'USB-C Hub', 7, 49.99, 'ACTIVE', '2024-03-01', '2024-03-20'),
(112, 'Monitor 27', 2, 299.99, 'ACTIVE', '2024-03-05', '2024-03-20'),
(113, 'Old Printer', 2, 199.99, 'DISCONTINUED', '2023-01-01', '2024-01-01'),
(114, 'Noise Cancelling Headphones', 7, 199.99, 'ACTIVE', '2024-03-10', '2024-03-25');

/*Insert Customers
There are deliberate anomalies here.*/
INSERT INTO customers
(customer_id, first_name, last_name, email, phone, signup_date, customer_status, updated_at)
VALUES
(1, 'John', 'Smith', 'john.smith@gmail.com', '555-1001', '2024-01-05', 'ACTIVE', '2024-03-01 10:00:00'),
(2, 'Sarah', 'Johnson', 'SARAH.JOHNSON@GMAIL.COM', '555-1002', '2024-01-10', 'ACTIVE', '2024-03-01 11:00:00'),
(3, 'Michael', 'Brown', ' michael.brown@gmail.com ', '555-1003', '2024-01-15', 'ACTIVE', '2024-03-02 09:00:00'),
(4, 'Emily', 'Davis', 'emily.davis@gmail.com', NULL, '2024-01-20', 'ACTIVE', '2024-03-02 10:00:00'),
(5, 'David', 'Wilson', 'david.wilson@gmail.com', '555-1005', '2024-01-25', 'INACTIVE', '2024-03-03 12:00:00'),
(6, 'Jessica', 'Taylor', 'jessica.taylor@gmail.com', '555-1006', '2024-02-01', 'ACTIVE', '2024-03-04 12:00:00'),
(7, 'Daniel', 'Anderson', 'daniel.anderson@gmail.com', '555-1007', '2024-02-05', 'ACTIVE', '2024-03-05 14:00:00'),
(8, 'Ashley', 'Thomas', 'ashley.thomas@gmail.com', '555-1008', '2024-02-10', 'ACTIVE', '2024-03-05 15:00:00'),
(9, 'Christopher', 'Jackson', 'chris.jackson@gmail.com', '555-1009', '2024-02-15', 'ACTIVE', '2024-03-06 09:00:00'),
(10, 'Amanda', 'White', 'amanda.white@gmail.com', '555-1010', '2024-02-20', 'ACTIVE', '2024-03-06 10:00:00'),
(11, 'Robert', 'Harris', 'robert.harris@gmail.com', '555-1011', '2024-02-25', 'ACTIVE', '2024-03-07 10:00:00'),
(12, 'Olivia', 'Martin', 'olivia.martin@gmail.com', '555-1012', '2024-03-01', 'ACTIVE', '2024-03-08 10:00:00');

--Insert Addresses
INSERT INTO customer_addresses
(address_id, customer_id, address_type, address_line1, city, state, postal_code, country, is_primary, updated_at)
VALUES
(1001, 1, 'HOME', '10 Main St', 'New York', 'NY', '10001', 'USA', TRUE, '2024-03-01'),
(1002, 2, 'HOME', '20 Oak St', 'Boston', 'MA', '02108', 'USA', TRUE, '2024-03-01'),
(1003, 3, 'HOME', '30 Pine St', 'Chicago', 'IL', '60601', 'USA', TRUE, '2024-03-02'),
(1004, 4, 'HOME', '40 Maple St', 'Austin', 'TX', '73301', 'USA', TRUE, '2024-03-02'),
(1005, 5, 'HOME', '50 Cedar St', 'Seattle', 'WA', '98101', 'USA', TRUE, '2024-03-03'),
(1006, 6, 'HOME', '60 Birch St', 'Denver', 'CO', '80202', 'USA', TRUE, '2024-03-04'),
(1007, 7, 'HOME', '70 Elm St', 'Miami', 'FL', '33101', 'USA', TRUE, '2024-03-05'),
(1008, 8, 'HOME', '80 Lake St', 'Dallas', 'TX', '75201', 'USA', TRUE, '2024-03-05'),
(1009, 9, 'HOME', '90 River St', 'Portland', 'OR', '97201', 'USA', TRUE, '2024-03-06'),
(1010, 10, 'HOME', '100 Hill St', 'Atlanta', 'GA', '30301', 'USA', TRUE, '2024-03-06'),
(1011, 11, 'HOME', '110 Park St', 'Phoenix', 'AZ', '85001', 'USA', TRUE, '2024-03-07'),
(1012, 12, 'HOME', '120 Market St', 'San Diego', 'CA', '92101', 'USA', TRUE, '2024-03-08');

/*Insert Orders
The order data contains several intentional anomalies.*/
INSERT INTO orders
(order_id, customer_id, order_date, order_status, shipping_address_id, order_total, updated_at)
VALUES
(5001, 1, '2024-03-01 10:15:00', 'COMPLETED', 1001, 1329.98, '2024-03-01 12:00:00'),
(5002, 2, '2024-03-02 11:30:00', 'COMPLETED', 1002, 799.99, '2024-03-02 13:00:00'),
(5003, 3, '2024-03-03 12:00:00', 'SHIPPED', 1003, 599.99, '2024-03-03 14:00:00'),
(5004, 4, '2024-03-04 13:00:00', 'CANCELLED', 1004, 149.99, '2024-03-04 15:00:00'),
(5005, 1, '2024-03-05 14:00:00', 'COMPLETED', 1001, 89.99, '2024-03-05 15:00:00'),
(5006, 5, '2024-03-06 15:00:00', 'COMPLETED', 1005, 249.99, '2024-03-06 16:00:00'),
(5007, 6, '2024-03-07 09:30:00', 'COMPLETED', 1006, 449.99, '2024-03-07 11:00:00'),
(5008, 7, '2024-03-08 10:00:00', 'SHIPPED', 1007, 849.98, '2024-03-08 12:00:00'),
(5009, 8, '2024-03-09 11:00:00', 'COMPLETED', 1008, 79.99, '2024-03-09 12:00:00'),
(5010, 9, '2024-03-10 12:00:00', 'COMPLETED', 1009, 299.99, '2024-03-10 13:00:00'),
(5011, 10, '2024-03-11 13:00:00', 'COMPLETED', 1010, 199.99, '2024-03-11 14:00:00'),
(5012, 11, '2024-03-12 14:00:00', 'SHIPPED', 1011, 1399.98, '2024-03-12 15:00:00'),
(5013, 12, '2024-03-13 15:00:00', 'COMPLETED', 1012, 49.99, '2024-03-13 16:00:00');

--Insert Order Items
INSERT INTO order_items
(order_item_id, order_id, product_id, quantity, unit_price, discount_amount)
VALUES
(1, 5001, 101, 1, 1299.99, 0),
(2, 5001, 103, 1, 29.99, 0),
(3, 5002, 105, 1, 799.99, 0),
(4, 5003, 106, 1, 599.99, 0),
(5, 5004, 107, 1, 149.99, 0),
(6, 5005, 104, 1, 89.99, 0),
(7, 5006, 109, 1, 249.99, 0),
(8, 5007, 110, 1, 449.99, 0),
(9, 5008, 105, 1, 799.99, 50.00),
(10, 5008, 103, 1, 29.99, 0),
(11, 5008, 111, 1, 49.99, 0),
(12, 5009, 108, 1, 79.99, 0),
(13, 5010, 112, 1, 299.99, 0),
(14, 5011, 114, 1, 199.99, 0),
(15, 5012, 101, 1, 1299.99, 0),
(16, 5012, 103, 1, 29.99, 0),
(17, 5012, 104, 1, 89.99, 20.00),
(18, 5013, 111, 1, 49.99, 0),
(19, 5014, 114, 1, 199.99, 0);

--Insert Payments
INSERT INTO payments
(payment_id, order_id, payment_date, payment_method, payment_status, amount, transaction_id)
VALUES
(9001, 5001, '2024-03-01 10:20:00', 'CREDIT_CARD', 'SUCCESS', 1329.98, 'TX10001'),
(9002, 5002, '2024-03-02 11:35:00', 'PAYPAL', 'SUCCESS', 799.99, 'TX10002'),
(9003, 5003, '2024-03-03 12:05:00', 'CREDIT_CARD', 'SUCCESS', 599.99, 'TX10003'),
(9004, 5004, '2024-03-04 13:05:00', 'CREDIT_CARD', 'REFUNDED', 149.99, 'TX10004'),
(9005, 5005, '2024-03-05 14:05:00', 'CREDIT_CARD', 'SUCCESS', 89.99, 'TX10005'),
(9006, 5006, '2024-03-06 15:05:00', 'PAYPAL', 'SUCCESS', 249.99, 'TX10006'),
(9007, 5007, '2024-03-07 09:35:00', 'CREDIT_CARD', 'SUCCESS', 449.99, 'TX10007'),
(9008, 5008, '2024-03-08 10:05:00', 'CREDIT_CARD', 'SUCCESS', 829.98, 'TX10008'),
(9009, 5009, '2024-03-09 11:05:00', 'PAYPAL', 'SUCCESS', 79.99, 'TX10009'),
(9010, 5010, '2024-03-10 12:05:00', 'CREDIT_CARD', 'SUCCESS', 299.99, 'TX10010'),
(9011, 5011, '2024-03-11 13:05:00', 'CREDIT_CARD', 'SUCCESS', 199.99, 'TX10011'),
(9012, 5012, '2024-03-12 14:05:00', 'PAYPAL', 'SUCCESS', 1399.98, 'TX10012');

--Insert Shipments
INSERT INTO shipments
(shipment_id, order_id, shipped_date, delivered_date, carrier, shipping_status)
VALUES
(7001, 5001, '2024-03-02 08:00:00', '2024-03-05 14:00:00', 'UPS', 'DELIVERED'),
(7002, 5002, '2024-03-03 08:00:00', '2024-03-06 14:00:00', 'FEDEX', 'DELIVERED'),
(7003, 5003, '2024-03-04 08:00:00', NULL, 'UPS', 'IN_TRANSIT'),
(7004, 5004, '2024-03-05 08:00:00', NULL, 'USPS', 'CANCELLED'),
(7005, 5005, '2024-03-06 08:00:00', '2024-03-08 14:00:00', 'UPS', 'DELIVERED'),
(7006, 5006, '2024-03-07 08:00:00', '2024-03-10 14:00:00', 'FEDEX', 'DELIVERED'),
(7007, 5007, '2024-03-08 08:00:00', '2024-03-11 14:00:00', 'UPS', 'DELIVERED'),
(7008, 5008, '2024-03-09 08:00:00', NULL, 'FEDEX', 'IN_TRANSIT'),
(7009, 5009, '2024-03-10 08:00:00', '2024-03-12 14:00:00', 'USPS', 'DELIVERED'),
(7010, 5010, '2024-03-11 08:00:00', '2024-03-14 14:00:00', 'UPS', 'DELIVERED'),
(7011, 5011, '2024-03-12 08:00:00', '2024-03-15 14:00:00', 'FEDEX', 'DELIVERED'),
(7012, 5012, '2024-03-13 08:00:00', NULL, 'UPS', 'IN_TRANSIT');

--check the load 
SELECT 'customers' AS table_name, COUNT(*) AS row_count
FROM raw.customers
UNION ALL
SELECT 'addresses', COUNT(*) FROM raw.customer_addresses
UNION ALL
SELECT 'categories', COUNT(*) FROM raw.categories
UNION ALL
SELECT 'products', COUNT(*) FROM raw.products
UNION ALL
SELECT 'orders', COUNT(*) FROM raw.orders
UNION ALL
SELECT 'order_items', COUNT(*) FROM raw.order_items
UNION ALL
SELECT 'payments', COUNT(*) FROM raw.payments
UNION ALL
SELECT 'shipments', COUNT(*) FROM raw.shipments;



--create deduplicates staging views
CREATE VIEW staging.latest_customers AS
WITH ranked AS (
    SELECT *,
        ROW_NUMBER() OVER (
            PARTITION BY customer_id
            ORDER BY updated_at DESC NULLS LAST
        ) AS rn
    FROM raw.customers
    WHERE customer_id IS NOT NULL
)
SELECT *
FROM ranked
WHERE rn = 1;

CREATE VIEW staging.latest_orders AS
WITH ranked AS (
    SELECT *,
        ROW_NUMBER() OVER (
            PARTITION BY order_id
            ORDER BY updated_at DESC NULLS LAST
        ) AS rn
    FROM raw.orders
    WHERE order_id IS NOT NULL
)
SELECT *
FROM ranked
WHERE rn = 1;

CREATE VIEW staging.latest_customer_addresses AS
WITH ranked AS (
    SELECT *,
        ROW_NUMBER() OVER (
            PARTITION BY address_id
            ORDER BY updated_at DESC NULLS LAST
        ) AS rn
    FROM raw.customer_addresses
    WHERE address_id IS NOT NULL
)
SELECT *
FROM ranked
WHERE rn = 1;

CREATE VIEW staging.latest_products AS
WITH ranked AS (
    SELECT *,
        ROW_NUMBER() OVER (
            PARTITION BY product_id
            ORDER BY updated_at DESC NULLS LAST
        ) AS rn
    FROM raw.products
    WHERE product_id IS NOT NULL
)
SELECT *
FROM ranked
WHERE rn = 1;

CREATE VIEW staging.latest_categories AS
WITH ranked AS (
    SELECT *,
        ROW_NUMBER() OVER (
            PARTITION BY category_id
            ORDER BY category_id DESC
        ) AS rn
    FROM raw.categories
    WHERE category_id IS NOT NULL
)
SELECT *
FROM ranked
WHERE rn = 1;

CREATE VIEW staging.latest_order_items AS
WITH ranked AS (
    SELECT *,
        ROW_NUMBER() OVER (
            PARTITION BY order_item_id
            ORDER BY order_item_id DESC
        ) AS rn
    FROM raw.order_items
    WHERE order_item_id IS NOT NULL
)
SELECT *
FROM ranked
WHERE rn = 1;

CREATE VIEW staging.latest_payments AS
WITH ranked AS (
    SELECT *,
        ROW_NUMBER() OVER (
            PARTITION BY payment_id
            ORDER BY payment_id DESC
        ) AS rn
    FROM raw.payments
    WHERE payment_id IS NOT NULL
)
SELECT *
FROM ranked
WHERE rn = 1;

CREATE VIEW staging.latest_shipments AS
WITH ranked AS (
    SELECT *,
        ROW_NUMBER() OVER (
            PARTITION BY shipment_id
            ORDER BY shipment_id DESC
        ) AS rn
    FROM raw.shipments
    WHERE shipment_id IS NOT NULL
)
SELECT *
FROM ranked
WHERE rn = 1;


--Challenge 1 — Create the clean customer dimension
-- PART A: Transformation

CREATE VIEW staging.stg_customers AS
SELECT
    customer_id,
    NULLIF(TRIM(first_name), '') AS first_name,
    NULLIF(TRIM(last_name), '') AS last_name,
    LOWER(NULLIF(TRIM(email), '')) AS email,
    NULLIF(TRIM(phone), '') AS phone,
    signup_date,
    UPPER(NULLIF(TRIM(customer_status), '')) AS customer_status,
    updated_at,

    CASE
        WHEN NULLIF(TRIM(email), '') IS NULL
            THEN 'MISSING'
        WHEN TRIM(email)
             ~* '^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,}$'
            THEN 'VALID'
        ELSE 'INVALID'
    END AS email_quality

FROM staging.latest_customers;


CREATE TABLE core.dim_customer AS
SELECT *
FROM staging.stg_customers;

ALTER TABLE core.dim_customer
ADD PRIMARY KEY (customer_id);

ALTER TABLE core.dim_customer
ADD CHECK (email_quality IN ('VALID', 'INVALID', 'MISSING'));



--Checking data loaded 
-- VIEW RESULT
SELECT *
FROM core.dim_customer
ORDER BY customer_id;

-- PART B: Must return zero rows
SELECT customer_id, COUNT(*) AS record_count
FROM core.dim_customer
GROUP BY customer_id
HAVING COUNT(*) > 1;

--Supporting step — Create category, product and address dimensions

CREATE TABLE core.dim_category AS
SELECT
    c.category_id,
    BTRIM(c.category_name) AS category_name,
    CASE
        WHEN p.category_id IS NOT NULL
            THEN c.parent_category_id
    END AS parent_category_id
FROM staging.latest_categories c
LEFT JOIN staging.latest_categories p
    ON c.parent_category_id = p.category_id;

---select * from staging.latest_categories;

ALTER TABLE core.dim_category
ADD PRIMARY KEY (category_id);

ALTER TABLE core.dim_category
ADD FOREIGN KEY (parent_category_id)
REFERENCES core.dim_category(category_id);


CREATE TABLE core.dim_product AS
SELECT
    p.product_id,
    BTRIM(p.product_name) AS product_name,
    p.category_id,
    p.product_price,
    UPPER(BTRIM(p.product_status)) AS product_status,
    p.created_at,
    p.updated_at
FROM staging.latest_products p
JOIN core.dim_category c
    ON p.category_id = c.category_id
WHERE p.product_price IS NOT NULL
  AND p.product_price >= 0;

ALTER TABLE core.dim_product
ADD PRIMARY KEY (product_id);

ALTER TABLE core.dim_product
ADD FOREIGN KEY (category_id)
REFERENCES core.dim_category(category_id);

ALTER TABLE core.dim_product
ALTER COLUMN product_price SET NOT NULL;

ALTER TABLE core.dim_product
ADD CHECK (product_price >= 0);


CREATE TABLE core.dim_address AS
SELECT
    a.address_id,
    a.customer_id,
    UPPER(BTRIM(a.address_type)) AS address_type,
    BTRIM(a.address_line1) AS address_line1,
    BTRIM(a.city) AS city,

    CASE UPPER(BTRIM(a.state))
        WHEN 'NEW YORK' THEN 'NY'
        WHEN 'TEXAS' THEN 'TX'
        WHEN 'CALIFORNIA' THEN 'CA'
        ELSE UPPER(BTRIM(a.state))
    END AS state,

    BTRIM(a.postal_code) AS postal_code,

    CASE UPPER(BTRIM(a.country))
        WHEN 'US' THEN 'USA'
        WHEN 'UNITED STATES' THEN 'USA'
        WHEN 'UNITED STATES OF AMERICA' THEN 'USA'
        ELSE UPPER(BTRIM(a.country))
    END AS country,

    COALESCE(a.is_primary, FALSE) AS is_primary,
    a.updated_at

FROM staging.latest_customer_addresses a
JOIN core.dim_customer c
    ON a.customer_id = c.customer_id;

ALTER TABLE core.dim_address
ADD PRIMARY KEY (address_id);

ALTER TABLE core.dim_address
ADD FOREIGN KEY (customer_id)
REFERENCES core.dim_customer(customer_id);

-- SUPPORTING STEP: CLEAN ORDER ITEMS

CREATE OR REPLACE VIEW staging.stg_order_items AS

SELECT
    oi.order_item_id,
    oi.order_id,
    oi.product_id,
    oi.quantity,

    -- Keep original price for auditing
    oi.unit_price AS original_unit_price,

    -- Trusted product master price
    p.product_price,

    COALESCE(oi.discount_amount, 0) AS discount_amount,

    -- Identify the issue
    CASE
        WHEN oi.quantity IS NULL OR oi.quantity <= 0
            THEN 'INVALID_QUANTITY'

        WHEN oi.unit_price IS NULL OR oi.unit_price < 0
            THEN 'INVALID_PRICE'

        WHEN COALESCE(oi.discount_amount, 0) < 0
            THEN 'INVALID_DISCOUNT'

        WHEN p.product_id IS NULL
            THEN 'PRODUCT_NOT_FOUND'

        WHEN ABS(oi.unit_price - p.product_price)
             > ABS(p.product_price) * 0.20
            THEN 'PRICE_MISMATCH'

        ELSE 'OK'
    END AS issue_type,

    -- Correct price if difference is greater than 20%
    CASE
        WHEN p.product_price IS NOT NULL
         AND oi.unit_price IS NOT NULL
         AND ABS(oi.unit_price - p.product_price)
             > ABS(p.product_price) * 0.20
        THEN p.product_price

        ELSE oi.unit_price
    END AS corrected_unit_price,

    -- Flag the correction
    CASE
        WHEN p.product_price IS NOT NULL
         AND oi.unit_price IS NOT NULL
         AND ABS(oi.unit_price - p.product_price)
             > ABS(p.product_price) * 0.20
        THEN 'Y'

        ELSE 'N'
    END AS price_correction_flag,

    -- Hard-invalid rows will not contribute to revenue
    CASE
        WHEN oi.quantity IS NULL OR oi.quantity <= 0 THEN 'INVALID'
        WHEN oi.unit_price IS NULL OR oi.unit_price < 0 THEN 'INVALID'
        WHEN COALESCE(oi.discount_amount, 0) < 0 THEN 'INVALID'
        WHEN p.product_id IS NULL THEN 'INVALID'
        ELSE 'VALID'
    END AS item_valid_flag

FROM staging.latest_order_items oi

LEFT JOIN core.dim_product p
    ON oi.product_id = p.product_id;

--Challenge 2 — Detect duplicate customers

SELECT
    customer_id,
    COUNT(*) AS record_count,
    MIN(updated_at) AS first_updated_at,
    MAX(updated_at) AS latest_updated_at
FROM raw.customers
GROUP BY customer_id
HAVING COUNT(*) > 1;

--Challenge 3 — Create the clean order dataset

CREATE VIEW staging.stg_orders AS
WITH ranked AS (
    SELECT *,
        ROW_NUMBER() OVER (
            PARTITION BY order_id
            ORDER BY updated_at DESC NULLS LAST
        ) AS row_num
    FROM raw.orders
    WHERE order_id IS NOT NULL
)
SELECT
    order_id,
    customer_id,
    order_date,
    UPPER(BTRIM(order_status)) AS order_status,
    shipping_address_id,
    order_total,
    updated_at
FROM ranked
WHERE row_num = 1;


SELECT
    order_id,
    customer_id,
    order_date,
    order_status,
    order_total,
    updated_at
FROM staging.stg_orders
ORDER BY order_id;


-- Must return zero rows
SELECT order_id, COUNT(*) AS record_count
FROM staging.stg_orders
GROUP BY order_id
HAVING COUNT(*) > 1;

-- FACT ORDER ITEM

DROP TABLE IF EXISTS core.fact_order_item;

CREATE TABLE core.fact_order_item AS

SELECT
    oi.order_item_id,
    oi.order_id,
    oi.product_id,

    oi.quantity,

    oi.original_unit_price,
    oi.product_price,
    oi.corrected_unit_price,

    oi.discount_amount,

    oi.price_correction_flag,
    oi.issue_type,
    oi.item_valid_flag,

    -- Revenue only for valid items
    CASE
        WHEN oi.item_valid_flag = 'VALID'
        THEN ROUND(
            oi.quantity * oi.corrected_unit_price
            - oi.discount_amount,
            2
        )
        ELSE NULL
    END AS line_revenue

FROM staging.stg_order_items oi;

ALTER TABLE core.fact_order_item
ADD PRIMARY KEY (order_item_id);

ALTER TABLE core.fact_order_item
ADD FOREIGN KEY (product_id)
REFERENCES core.dim_product(product_id);

SELECT *
FROM core.fact_order_item
ORDER BY order_item_id;

SELECT *
FROM core.fact_order_item
WHERE item_valid_flag = 'INVALID'
   OR issue_type <> 'OK';


-- FACT ORDER


DROP TABLE IF EXISTS core.fact_order;

CREATE TABLE core.fact_order AS

WITH item_summary AS (

    SELECT
        order_id,

        COUNT(*) AS total_item_count,

        COUNT(*) FILTER (
            WHERE item_valid_flag = 'VALID'
        ) AS valid_item_count,

        COUNT(*) FILTER (
            WHERE item_valid_flag = 'INVALID'
        ) AS invalid_item_count,

        -- Original item revenue
        ROUND(
            SUM(
                quantity * original_unit_price
                - discount_amount
            ),
            2
        ) AS calculated_order_total,

        -- Trusted revenue after corrections
        ROUND(
            SUM(
                CASE
                    WHEN item_valid_flag = 'VALID'
                    THEN line_revenue
                    ELSE 0
                END
            ),
            2
        ) AS trusted_order_revenue

    FROM core.fact_order_item

    GROUP BY order_id
)

SELECT
    o.order_id,
    o.customer_id,
    o.shipping_address_id,

    o.order_date,
    o.order_status,

    o.order_total
        AS stored_order_total,

    COALESCE(
        i.calculated_order_total,
        0
    ) AS calculated_order_total,

    COALESCE(
        i.trusted_order_revenue,
        0
    ) AS trusted_order_revenue,

    COALESCE(
        i.total_item_count,
        0
    ) AS total_item_count,

    COALESCE(
        i.valid_item_count,
        0
    ) AS valid_item_count,

    COALESCE(
        i.invalid_item_count,
        0
    ) AS invalid_item_count,

    ROUND(
        COALESCE(i.calculated_order_total, 0)
        - o.order_total,
        2
    ) AS revenue_difference,

    CASE
        WHEN ABS(
            COALESCE(i.calculated_order_total, 0)
            - o.order_total
        ) <= 0.01
        THEN 'MATCH'

        ELSE 'MISMATCH'
    END AS revenue_status,

    CASE
        WHEN COALESCE(i.total_item_count, 0) = 0
            THEN 'INVALID'

        WHEN COALESCE(i.invalid_item_count, 0) > 0
            THEN 'INVALID'

        ELSE 'VALID'
    END AS order_valid_flag,

    -- Revenue recognized by analytics
    CASE
        WHEN o.order_status = 'CANCELLED'
            THEN 0

        WHEN COALESCE(i.invalid_item_count, 0) > 0
            THEN 0

        ELSE COALESCE(
            i.trusted_order_revenue,
            0
        )
    END AS recognized_revenue,

    o.updated_at

FROM staging.stg_orders o

LEFT JOIN item_summary i
    ON o.order_id = i.order_id;

ALTER TABLE core.fact_order
ADD PRIMARY KEY (order_id);

ALTER TABLE core.fact_order
ADD FOREIGN KEY (customer_id)
REFERENCES core.dim_customer(customer_id);

ALTER TABLE core.fact_order
ADD FOREIGN KEY (shipping_address_id)
REFERENCES core.dim_address(address_id);

SELECT *
FROM core.fact_order
ORDER BY order_id;

SELECT
    order_id,
    COUNT(*) AS record_count
FROM core.fact_order
GROUP BY order_id
HAVING COUNT(*) > 1;


-- FACT PAYMENT


DROP TABLE IF EXISTS core.fact_payment;

CREATE TABLE core.fact_payment AS

SELECT
    payment_id,
    order_id,
    payment_date,

    UPPER(BTRIM(payment_method))
        AS payment_method,

    UPPER(BTRIM(payment_status))
        AS payment_status,

    amount,

    NULLIF(
        BTRIM(transaction_id),
        ''
    ) AS transaction_id,

    CASE
        WHEN amount IS NULL
            THEN 'INVALID'

        WHEN amount < 0
            THEN 'INVALID'

        WHEN transaction_id IS NULL
            THEN 'INVALID'

        ELSE 'VALID'
    END AS payment_valid_flag

FROM staging.latest_payments;

ALTER TABLE core.fact_payment
ADD PRIMARY KEY (payment_id);

SELECT *
FROM core.fact_payment
ORDER BY payment_id;

-- FACT SHIPMENT

DROP TABLE IF EXISTS core.fact_shipment;

CREATE TABLE core.fact_shipment AS

SELECT
    s.shipment_id,
    s.order_id,

    s.shipped_date,
    s.delivered_date,

    UPPER(BTRIM(s.carrier))
        AS carrier,

    UPPER(BTRIM(s.shipping_status))
        AS shipping_status,

    o.order_date,

    s.shipped_date::DATE
        - o.order_date::DATE
        AS days_to_ship,

    s.delivered_date::DATE
        - s.shipped_date::DATE
        AS days_to_deliver,

    CASE
        WHEN s.shipped_date IS NULL
            THEN 'INVALID'

        WHEN s.shipped_date < o.order_date
            THEN 'INVALID'

        WHEN s.delivered_date IS NOT NULL
         AND s.delivered_date < s.shipped_date
            THEN 'INVALID'

        WHEN s.shipped_date::DATE
             - o.order_date::DATE = 0
            THEN 'SAME_DAY_SHIPMENT'

        WHEN s.shipped_date::DATE
             - o.order_date::DATE
             BETWEEN 1 AND 3
            THEN 'NORMAL'

        WHEN s.shipped_date::DATE
             - o.order_date::DATE > 3
            THEN 'SLOW'

        ELSE 'INVALID'
    END AS shipment_sla_status,

    CASE
        WHEN s.shipped_date < o.order_date
            THEN 'Y'

        WHEN s.delivered_date IS NOT NULL
         AND s.delivered_date < s.shipped_date
            THEN 'Y'

        ELSE 'N'
    END AS shipment_anomaly_flag

FROM staging.latest_shipments s

LEFT JOIN staging.stg_orders o
    ON s.order_id = o.order_id;

ALTER TABLE core.fact_shipment
ADD PRIMARY KEY (shipment_id);

---chalange 4
SELECT
    order_id,

    stored_order_total,

    calculated_order_total,

    revenue_difference
        AS difference,

    revenue_status

FROM core.fact_order

ORDER BY order_id;

--Challenge 5 — Identify Invalid Order Items
SELECT
    order_id,
    order_item_id,
    product_id,
    quantity,
    original_unit_price
        AS unit_price,
    product_price,
    issue_type
FROM core.fact_order_item
WHERE issue_type <> 'OK'
ORDER BY order_id;

--Challenge 6 — Clean Product Prices
SELECT
    order_id,
    order_item_id,
    product_id,

    original_unit_price,

    corrected_unit_price,

    price_correction_flag

FROM core.fact_order_item

ORDER BY order_id;


--Challenge 7 — ANALYTICS VIEW: CUSTOMER LIFETIME VALUE

CREATE OR REPLACE VIEW analytics.customer_lifetime_value AS

SELECT
    c.customer_id,

    CONCAT(
        c.first_name,
        ' ',
        c.last_name
    ) AS customer_name,

    c.email,

    COUNT(f.order_id)
        AS number_of_orders,

    ROUND(
        COALESCE(
            SUM(f.recognized_revenue),
            0
        ),
        2
    ) AS lifetime_revenue,

    ROUND(
        COALESCE(
            AVG(f.recognized_revenue),
            0
        ),
        2
    ) AS average_order_value,

    MIN(f.order_date)
        AS first_order_date,

    MAX(f.order_date)
        AS latest_order_date

FROM core.dim_customer c

LEFT JOIN core.fact_order f
    ON c.customer_id = f.customer_id
   AND f.order_status = 'COMPLETED'
   AND f.order_valid_flag = 'VALID'

GROUP BY
    c.customer_id,
    c.first_name,
    c.last_name,
    c.email;

SELECT *
FROM analytics.customer_lifetime_value
ORDER BY lifetime_revenue DESC;

--- ANALYTICS VIEW: PRODUCT PERFORMANCE
CREATE OR REPLACE VIEW analytics.product_performance AS

SELECT
    p.product_id,

    p.product_name,

    c.category_id,

    c.category_name,

    COUNT(DISTINCT i.order_id)
        AS number_of_orders,

    COALESCE(
        SUM(i.quantity),
        0
    ) AS units_sold,

    ROUND(
        COALESCE(
            SUM(i.line_revenue),
            0
        ),
        2
    ) AS product_revenue,

    ROUND(
        COALESCE(
            AVG(i.corrected_unit_price),
            0
        ),
        2
    ) AS average_selling_price,

    ROUND(
        COALESCE(
            SUM(i.discount_amount),
            0
        ),
        2
    ) AS total_discount,

    COUNT(*) FILTER (
        WHERE i.price_correction_flag = 'Y'
    ) AS corrected_price_count

FROM core.dim_product p

JOIN core.dim_category c
    ON p.category_id = c.category_id

LEFT JOIN core.fact_order_item i
    ON p.product_id = i.product_id

LEFT JOIN core.fact_order o
    ON i.order_id = o.order_id

WHERE
       o.order_id IS NULL
    OR (
        i.item_valid_flag = 'VALID'
        AND o.order_valid_flag = 'VALID'
        AND o.order_status <> 'CANCELLED'
    )

GROUP BY
    p.product_id,
    p.product_name,
    c.category_id,
    c.category_name;

SELECT *
FROM analytics.product_performance
ORDER BY product_revenue DESC;

-- ANALYTICS VIEW: MONTHLY REVENUE

CREATE OR REPLACE VIEW analytics.monthly_revenue AS

WITH monthly AS (

    SELECT
        DATE_TRUNC(
            'month',
            order_date
        )::DATE AS month,

        COUNT(*) AS number_of_orders,

        ROUND(
            SUM(recognized_revenue),
            2
        ) AS revenue

    FROM core.fact_order

    WHERE order_valid_flag = 'VALID'
      AND order_status <> 'CANCELLED'

    GROUP BY
        DATE_TRUNC(
            'month',
            order_date
        )::DATE
),

comparison AS (

    SELECT
        month,
        number_of_orders,
        revenue,

        LAG(revenue) OVER (
            ORDER BY month
        ) AS previous_month_revenue

    FROM monthly
)

SELECT
    month,

    number_of_orders,

    revenue,

    previous_month_revenue,

    ROUND(
        revenue
        - previous_month_revenue,
        2
    ) AS revenue_difference,

    ROUND(
        (
            revenue
            - previous_month_revenue
        )
        / NULLIF(
            previous_month_revenue,
            0
        ) * 100,
        2
    ) AS revenue_growth_percentage

FROM comparison;

SELECT *
FROM analytics.monthly_revenue
ORDER BY month;

-- ANALYTICS VIEW: CUSTOMER RETENTION

CREATE OR REPLACE VIEW analytics.customer_retention AS

WITH valid_orders AS (

    SELECT
        customer_id,
        order_date

    FROM core.fact_order

    WHERE order_valid_flag = 'VALID'
      AND order_status <> 'CANCELLED'
),

-- Find first month each customer ordered
first_orders AS (

    SELECT
        customer_id,

        MIN(
            DATE_TRUNC(
                'month',
                order_date
            )
        )::DATE AS cohort_month

    FROM valid_orders

    GROUP BY customer_id
),

-- Find every month customer was active
customer_activity AS (

    SELECT DISTINCT
        o.customer_id,

        f.cohort_month,

        DATE_TRUNC(
            'month',
            o.order_date
        )::DATE AS activity_month

    FROM valid_orders o

    JOIN first_orders f
        ON o.customer_id = f.customer_id
),

-- Calculate Month 0, Month 1, Month 2...
cohort_activity AS (

    SELECT
        customer_id,
        cohort_month,
        activity_month,

        (
            (
                EXTRACT(
                    YEAR FROM activity_month
                )
                -
                EXTRACT(
                    YEAR FROM cohort_month
                )
            ) * 12

            +

            (
                EXTRACT(
                    MONTH FROM activity_month
                )
                -
                EXTRACT(
                    MONTH FROM cohort_month
                )
            )
        )::INT AS month_number

    FROM customer_activity
),

-- Original cohort size
cohort_sizes AS (

    SELECT
        cohort_month,

        COUNT(DISTINCT customer_id)
            AS cohort_size

    FROM first_orders

    GROUP BY cohort_month
),

-- Customers still active
active_customers AS (

    SELECT
        cohort_month,
        month_number,

        COUNT(DISTINCT customer_id)
            AS active_customers

    FROM cohort_activity

    WHERE month_number BETWEEN 0 AND 3

    GROUP BY
        cohort_month,
        month_number
)

SELECT
    a.cohort_month,

    a.month_number,

    c.cohort_size,

    a.active_customers,

    ROUND(
        a.active_customers::NUMERIC
        / NULLIF(
            c.cohort_size,
            0
        ) * 100,
        2
    ) AS retention_percentage

FROM active_customers a

JOIN cohort_sizes c
    ON a.cohort_month = c.cohort_month;

SELECT *
FROM analytics.customer_retention

ORDER BY
    cohort_month,
    month_number;

-- ANALYTICS VIEW: SHIPMENT SLA

CREATE OR REPLACE VIEW analytics.shipment_sla AS

SELECT
    s.shipment_id,

    s.order_id,

    o.customer_id,

    o.order_date,

    s.shipped_date,

    s.delivered_date,

    s.carrier,

    s.shipping_status,

    s.days_to_ship,

    s.days_to_deliver,

    s.shipment_sla_status,

    s.shipment_anomaly_flag

FROM core.fact_shipment s

LEFT JOIN core.fact_order o
    ON s.order_id = o.order_id;

SELECT *
FROM analytics.shipment_sla
ORDER BY order_id;

--Challenge 8 — Rank Customers by Revenue 
WITH customer_revenue AS (
    SELECT
        c.customer_id,
        CONCAT(
            c.first_name,
            ' ',
            c.last_name
        ) AS customer_name,
        SUM(f.recognized_revenue)
            AS lifetime_revenue
    FROM core.dim_customer c
    JOIN core.fact_order f
        ON c.customer_id = f.customer_id
    WHERE f.order_valid_flag = 'VALID'
    GROUP BY
        c.customer_id,
        c.first_name,
        c.last_name
)
SELECT
    *,
    RANK() OVER (
        ORDER BY lifetime_revenue DESC
    ) AS revenue_rank,
    DENSE_RANK() OVER (
        ORDER BY lifetime_revenue DESC
    ) AS dense_revenue_rank
FROM customer_revenue;

-- Challenge 9 — Rank Customers Within Each State

WITH customer_revenue AS (

    SELECT
        a.state,

        c.customer_id,

        CONCAT(
            c.first_name,
            ' ',
            c.last_name
        ) AS customer_name,

        SUM(f.recognized_revenue)
            AS revenue

    FROM core.fact_order f

    JOIN core.dim_customer c
        ON f.customer_id = c.customer_id

    JOIN core.dim_address a
        ON f.shipping_address_id = a.address_id

    WHERE f.order_valid_flag = 'VALID'

    GROUP BY
        a.state,
        c.customer_id,
        c.first_name,
        c.last_name
)

SELECT
    *,

    RANK() OVER (
        PARTITION BY state
        ORDER BY revenue DESC
    ) AS state_revenue_rank

FROM customer_revenue

ORDER BY
    state,
    state_revenue_rank;

-- Challenge 10 — Find Each Customer's First and Latest Order

SELECT
    c.customer_id,

    MIN(f.order_date::DATE)
        AS first_order_date,

    MAX(f.order_date::DATE)
        AS latest_order_date,

    MAX(f.order_date::DATE)
    - MIN(f.order_date::DATE)
        AS days_between_first_and_latest_order

FROM core.dim_customer c

LEFT JOIN core.fact_order f
    ON c.customer_id = f.customer_id

   AND f.order_valid_flag = 'VALID'
   AND f.order_status <> 'CANCELLED'

GROUP BY c.customer_id

ORDER BY c.customer_id;

-- Challenge 11 — Previous Order Analysis
WITH order_history AS (

    SELECT
        customer_id,
        order_id,
        order_date,

        recognized_revenue
            AS order_total,

        LAG(order_date) OVER (
            PARTITION BY customer_id
            ORDER BY order_date
        ) AS previous_order_date

    FROM core.fact_order

    WHERE order_valid_flag = 'VALID'
      AND order_status <> 'CANCELLED'
)

SELECT
    *,

    order_date::DATE
    - previous_order_date::DATE
        AS days_since_previous_order

FROM order_history

ORDER BY
    customer_id,
    order_date;

-- Challenge 12 — Next Order Prediction Dataset

WITH order_history AS (

    SELECT
        customer_id,
        order_id,
        order_date,

        LEAD(order_date) OVER (
            PARTITION BY customer_id
            ORDER BY order_date
        ) AS next_order_date,

        COUNT(*) OVER (
            PARTITION BY customer_id
        ) AS number_of_orders

    FROM core.fact_order

    WHERE order_valid_flag = 'VALID'
      AND order_status <> 'CANCELLED'
)

SELECT
    customer_id,
    order_id,
    order_date,
    next_order_date,

    next_order_date::DATE
    - order_date::DATE
        AS days_until_next_order,

    CASE
        WHEN number_of_orders = 1
            THEN 'ONE_TIME_BUYER'
        ELSE 'RETURNING_CUSTOMER'
    END AS customer_type

FROM order_history;

-- Challenge 13 — Running Revenue

WITH daily_revenue AS (

    SELECT
        order_date::DATE AS order_date,

        SUM(recognized_revenue)
            AS daily_revenue

    FROM core.fact_order

    WHERE order_valid_flag = 'VALID'

    GROUP BY order_date::DATE
)

SELECT
    order_date,
    daily_revenue,

    SUM(daily_revenue) OVER (
        ORDER BY order_date
    ) AS running_revenue

FROM daily_revenue;

-- Challenge 14 — Seven-Day Rolling Revenue
WITH daily_revenue AS (

    SELECT
        order_date::DATE AS revenue_date,

        SUM(recognized_revenue)
            AS daily_revenue

    FROM core.fact_order

    WHERE order_valid_flag = 'VALID'

    GROUP BY order_date::DATE
)

SELECT
    revenue_date,
    daily_revenue,

    SUM(daily_revenue) OVER (

        ORDER BY revenue_date::TIMESTAMP

        RANGE BETWEEN
            INTERVAL '6 days' PRECEDING
            AND CURRENT ROW

    ) AS seven_day_rolling_revenue

FROM daily_revenue;

-- Challenge 15 — Monthly Revenue and Month-over-Month Growth

WITH monthly_revenue AS (

    SELECT
        DATE_TRUNC(
            'month',
            order_date
        )::DATE AS month,

        SUM(recognized_revenue)
            AS revenue

    FROM core.fact_order

    WHERE order_valid_flag = 'VALID'

    GROUP BY
        DATE_TRUNC(
            'month',
            order_date
        )::DATE
),

comparison AS (

    SELECT
        *,

        LAG(revenue) OVER (
            ORDER BY month
        ) AS previous_month_revenue

    FROM monthly_revenue
)

SELECT
    month,
    revenue,
    previous_month_revenue,

    revenue
    - previous_month_revenue
        AS revenue_difference,

    ROUND(
        (
            revenue
            - previous_month_revenue
        )
        / NULLIF(
            previous_month_revenue,
            0
        ) * 100,
        2
    ) AS revenue_growth_percentage

FROM comparison;

-- Challenge 16 — Top 3 Products per Category

WITH product_revenue AS (

    SELECT
        c.category_name,

        p.product_id,
        p.product_name,

        SUM(i.line_revenue)
            AS revenue

    FROM core.fact_order_item i

    JOIN core.fact_order o
        ON i.order_id = o.order_id

    JOIN core.dim_product p
        ON i.product_id = p.product_id

    JOIN core.dim_category c
        ON p.category_id = c.category_id

    WHERE i.item_valid_flag = 'VALID'
      AND o.order_valid_flag = 'VALID'
      AND o.order_status <> 'CANCELLED'

    GROUP BY
        c.category_name,
        p.product_id,
        p.product_name
),

ranked AS (

    SELECT
        *,

        DENSE_RANK() OVER (
            PARTITION BY category_name
            ORDER BY revenue DESC
        ) AS category_rank

    FROM product_revenue
)

SELECT *
FROM ranked

WHERE category_rank <= 3

ORDER BY
    category_name,
    category_rank;

-- Challenge 17 — Products Making Up 80% Revenue

WITH product_revenue AS (

    SELECT
        p.product_id,
        p.product_name,

        SUM(i.line_revenue)
            AS revenue

    FROM core.fact_order_item i

    JOIN core.fact_order o
        ON i.order_id = o.order_id

    JOIN core.dim_product p
        ON i.product_id = p.product_id

    WHERE i.item_valid_flag = 'VALID'
      AND o.order_valid_flag = 'VALID'
      AND o.order_status <> 'CANCELLED'

    GROUP BY
        p.product_id,
        p.product_name
),

analysis AS (

    SELECT
        *,

        SUM(revenue) OVER (
            ORDER BY revenue DESC
        ) AS cumulative_revenue,

        SUM(revenue) OVER ()
            AS total_revenue

    FROM product_revenue
)

SELECT
    product_id,
    product_name,
    revenue,
    cumulative_revenue,

    ROUND(
        cumulative_revenue
        / NULLIF(total_revenue, 0)
        * 100,
        2
    ) AS cumulative_percentage

FROM analysis

WHERE cumulative_revenue - revenue
      < total_revenue * 0.80

ORDER BY revenue DESC;

-- Challenge 18 — Spending Increased
WITH monthly AS (

    SELECT
        customer_id,

        DATE_TRUNC(
            'month',
            order_date
        )::DATE AS month,

        SUM(recognized_revenue)
            AS current_month_revenue

    FROM core.fact_order

    WHERE order_valid_flag = 'VALID'

    GROUP BY
        customer_id,
        DATE_TRUNC(
            'month',
            order_date
        )::DATE
),

comparison AS (

    SELECT
        *,

        LAG(current_month_revenue) OVER (
            PARTITION BY customer_id
            ORDER BY month
        ) AS previous_month_revenue

    FROM monthly
)

SELECT
    customer_id,
    month,
    current_month_revenue,
    previous_month_revenue,

    ROUND(
        (
            current_month_revenue
            - previous_month_revenue
        )
        / NULLIF(
            previous_month_revenue,
            0
        ) * 100,
        2
    ) AS growth_percentage

FROM comparison

WHERE current_month_revenue
      > previous_month_revenue;

WITH payment_summary AS (

    SELECT
        order_id,

        COUNT(*) AS payment_count,

        SUM(amount) FILTER (
            WHERE payment_status = 'SUCCESS'
        ) AS successful_payment_amount,

        COUNT(*) FILTER (
            WHERE payment_status = 'REFUNDED'
        ) AS refunded_payment_count,

        STRING_AGG(
            DISTINCT payment_status,
            ', '
        ) AS payment_status

    FROM core.fact_payment

    GROUP BY order_id
)

SELECT
    o.order_id,

    o.recognized_revenue
        AS order_total,

    COALESCE(
        p.payment_count,
        0
    ) AS payment_count,

    COALESCE(
        p.successful_payment_amount,
        0
    ) AS successful_payment_amount,

    COALESCE(
        p.payment_status,
        'NO_PAYMENT'
    ) AS payment_status,

    CASE
        WHEN p.order_id IS NULL
            THEN 'NO_PAYMENT'

        WHEN p.refunded_payment_count > 0
            THEN 'REFUNDED'

        WHEN p.payment_count > 1
            THEN 'MULTIPLE_PAYMENTS'

        WHEN ABS(
            COALESCE(
                p.successful_payment_amount,
                0
            )
            - o.recognized_revenue
        ) > 0.01
            THEN 'PAYMENT_MISMATCH'

        ELSE 'RECONCILED'

    END AS reconciliation_status

FROM core.fact_order o

LEFT JOIN payment_summary p
    ON o.order_id = p.order_id;

---Challenge 19 — Payment Reconciliation

WITH payment_summary AS (

    SELECT
        order_id,

        COUNT(*) AS payment_count,

        SUM(amount) FILTER (
            WHERE payment_status = 'SUCCESS'
        ) AS successful_payment_amount,

        COUNT(*) FILTER (
            WHERE payment_status = 'REFUNDED'
        ) AS refunded_payment_count,

        STRING_AGG(
            DISTINCT payment_status,
            ', '
        ) AS payment_status

    FROM core.fact_payment

    GROUP BY order_id
)

SELECT
    o.order_id,

    o.recognized_revenue
        AS order_total,

    COALESCE(
        p.payment_count,
        0
    ) AS payment_count,

    COALESCE(
        p.successful_payment_amount,
        0
    ) AS successful_payment_amount,

    COALESCE(
        p.payment_status,
        'NO_PAYMENT'
    ) AS payment_status,

    CASE
        WHEN p.order_id IS NULL
            THEN 'NO_PAYMENT'

        WHEN p.refunded_payment_count > 0
            THEN 'REFUNDED'

        WHEN p.payment_count > 1
            THEN 'MULTIPLE_PAYMENTS'

        WHEN ABS(
            COALESCE(
                p.successful_payment_amount,
                0
            )
            - o.recognized_revenue
        ) > 0.01
            THEN 'PAYMENT_MISMATCH'

        ELSE 'RECONCILED'

    END AS reconciliation_status

FROM core.fact_order o

LEFT JOIN payment_summary p
    ON o.order_id = p.order_id;

-- Challenge 20 — Duplicate Payments

SELECT
    transaction_id,

    COUNT(*) AS payment_count,

    SUM(amount)
        AS total_amount,

    MIN(payment_date)
        AS first_payment_date,

    MAX(payment_date)
        AS last_payment_date

FROM core.fact_payment

WHERE transaction_id IS NOT NULL

GROUP BY transaction_id

HAVING COUNT(*) > 1;

-- Challenge 21 — Shipment SLA
SELECT
    order_id,
    shipment_id,
    order_date,
    shipped_date,
    delivered_date,

    days_to_ship,
    days_to_deliver,

    shipment_sla_status

FROM core.fact_shipment

ORDER BY order_id;

-- Challenges 22 — Cohorts and Retention

WITH valid_orders AS (

    SELECT
        customer_id,
        order_date

    FROM core.fact_order

    WHERE order_valid_flag = 'VALID'
      AND order_status <> 'CANCELLED'
),

first_orders AS (

    SELECT
        customer_id,

        MIN(
            DATE_TRUNC(
                'month',
                order_date
            )
        )::DATE AS cohort_month

    FROM valid_orders

    GROUP BY customer_id
),

activity AS (

    SELECT
        o.customer_id,

        f.cohort_month,

        DATE_TRUNC(
            'month',
            o.order_date
        )::DATE AS order_month

    FROM valid_orders o

    JOIN first_orders f
        ON o.customer_id = f.customer_id
),

months AS (

    SELECT
        *,

        (
            EXTRACT(
                YEAR FROM order_month
            )
            -
            EXTRACT(
                YEAR FROM cohort_month
            )
        ) * 12

        +

        (
            EXTRACT(
                MONTH FROM order_month
            )
            -
            EXTRACT(
                MONTH FROM cohort_month
            )
        ) AS month_number

    FROM activity
)

SELECT
    cohort_month,

    month_number::INT,

    COUNT(
        DISTINCT customer_id
    ) AS active_customers

FROM months

WHERE month_number BETWEEN 0 AND 3

GROUP BY
    cohort_month,
    month_number

ORDER BY
    cohort_month,
    month_number;

-- Challenge 23
WITH valid_orders AS (

    SELECT
        customer_id,
        order_date

    FROM core.fact_order

    WHERE order_valid_flag = 'VALID'
      AND order_status <> 'CANCELLED'
),

first_orders AS (

    SELECT
        customer_id,

        MIN(
            DATE_TRUNC(
                'month',
                order_date
            )
        )::DATE AS cohort_month

    FROM valid_orders

    GROUP BY customer_id
),

activity AS (

    SELECT
        o.customer_id,
        f.cohort_month,

        DATE_TRUNC(
            'month',
            o.order_date
        )::DATE AS order_month

    FROM valid_orders o

    JOIN first_orders f
        ON o.customer_id = f.customer_id
),

months AS (

    SELECT
        *,

        (
            (
                EXTRACT(YEAR FROM order_month)
                - EXTRACT(YEAR FROM cohort_month)
            ) * 12

            +

            (
                EXTRACT(MONTH FROM order_month)
                - EXTRACT(MONTH FROM cohort_month)
            )
        )::INT AS month_number

    FROM activity
),

cohort_size AS (

    SELECT
        cohort_month,

        COUNT(DISTINCT customer_id)
            AS cohort_size

    FROM first_orders

    GROUP BY cohort_month
),

active AS (

    SELECT
        cohort_month,
        month_number,

        COUNT(DISTINCT customer_id)
            AS active_customers

    FROM months

    WHERE month_number BETWEEN 0 AND 3

    GROUP BY
        cohort_month,
        month_number
)

SELECT
    a.cohort_month,
    a.month_number,

    c.cohort_size,
    a.active_customers,

    ROUND(
        a.active_customers::NUMERIC
        / NULLIF(c.cohort_size, 0)
        * 100,
        2
    ) AS retention_percentage

FROM active a

JOIN cohort_size c
    ON a.cohort_month = c.cohort_month;

-- Challenge 24 — Build a Data Quality Scorecard

WITH metrics AS (

    SELECT
        'Invalid order items'
            AS metric_name,

        COUNT(*) AS total_records,

        COUNT(*) FILTER (
            WHERE item_valid_flag = 'INVALID'
        ) AS bad_records

    FROM core.fact_order_item


    UNION ALL


    SELECT
        'Revenue mismatches',

        COUNT(*),

        COUNT(*) FILTER (
            WHERE revenue_status = 'MISMATCH'
        )

    FROM core.fact_order


    UNION ALL


    SELECT
        'Invalid payments',

        COUNT(*),

        COUNT(*) FILTER (
            WHERE payment_valid_flag = 'INVALID'
        )

    FROM core.fact_payment


    UNION ALL


    SELECT
        'Shipment anomalies',

        COUNT(*),

        COUNT(*) FILTER (
            WHERE shipment_anomaly_flag = 'Y'
        )

    FROM core.fact_shipment
)

SELECT
    metric_name,
    total_records,
    bad_records,

    ROUND(
        bad_records::NUMERIC
        / NULLIF(total_records, 0)
        * 100,
        2
    ) AS bad_record_percentage

FROM metrics;


