CREATE SCHEMA IF NOT EXISTS raw_data;

CREATE OR REPLACE TABLE raw_data.stores AS
SELECT * FROM UNNEST([
  STRUCT("ST01" AS store_id, "Centro" AS store_name, "CABA" AS city, "Centro" AS region),
  STRUCT("ST02" AS store_id, "Norte" AS store_name, "Córdoba" AS city, "Norte" AS region),
  STRUCT("ST03" AS store_id, "Sur" AS store_name, "Mendoza" AS city, "Sur" AS region),
  STRUCT("ST04" AS store_id, "Este" AS store_name, "Rosario" AS city, "Este" AS region),
  STRUCT("ST05" AS store_id, "Oeste" AS store_name, "San Miguel de Tucumán" AS city, "Noroeste" AS region)
]);

CREATE OR REPLACE TABLE raw_data.products AS
SELECT * FROM UNNEST([
  STRUCT("BK01" AS product_id, "Ridge 2" AS product_name, "Mountain" AS category, "Altura" AS brand, NUMERIC "820.00" AS unit_cost, NUMERIC "1199.00" AS list_price),
  STRUCT("BK02" AS product_id, "Sprint 5" AS product_name, "Road" AS category, "Velora" AS brand, NUMERIC "960.00" AS unit_cost, NUMERIC "1399.00" AS list_price),
  STRUCT("BK03" AS product_id, "City 1" AS product_name, "Urban" AS category, "Altura" AS brand, NUMERIC "340.00" AS unit_cost, NUMERIC "599.00" AS list_price),
  STRUCT("BK04" AS product_id, "Summit 3" AS product_name, "Mountain" AS category, "Northline" AS brand, NUMERIC "900.00" AS unit_cost, NUMERIC "1499.00" AS list_price),
  STRUCT("BK05" AS product_id, "Trail X" AS product_name, "Trail" AS category, "Velora" AS brand, NUMERIC "760.00" AS unit_cost, NUMERIC "1299.00" AS list_price),
  STRUCT("AC01" AS product_id, "Trail Helmet" AS product_name, "Accessories" AS category, "Northline" AS brand, NUMERIC "34.00" AS unit_cost, NUMERIC "69.00" AS list_price),
  STRUCT("AC02" AS product_id, "Commuter Light Set" AS product_name, "Accessories" AS category, "Northline" AS brand, NUMERIC "18.00" AS unit_cost, NUMERIC "39.00" AS list_price),
  STRUCT("AC03" AS product_id, "Hydration Bottle" AS product_name, "Accessories" AS category, "Altura" AS brand, NUMERIC "9.00" AS unit_cost, NUMERIC "24.00" AS list_price)
]);

CREATE OR REPLACE TABLE raw_data.sales AS
SELECT * FROM UNNEST([
  STRUCT(1 AS sale_line_id, "ORD-1001" AS order_id, "ST01" AS store_id, "BK01" AS product_id, 1 AS quantity, NUMERIC "1199.00" AS unit_price, NUMERIC "0.05" AS discount_pct, TIMESTAMP("2026-01-12 10:15:00+00") AS sold_at),
  STRUCT(2 AS sale_line_id, "ORD-1002" AS order_id, "ST02" AS store_id, "BK02" AS product_id, 1 AS quantity, NUMERIC "1399.00" AS unit_price, NUMERIC "0.00" AS discount_pct, TIMESTAMP("2026-01-18 14:30:00+00") AS sold_at),
  STRUCT(3 AS sale_line_id, "ORD-1003" AS order_id, "ST01" AS store_id, "AC01" AS product_id, 2 AS quantity, NUMERIC "69.00" AS unit_price, NUMERIC "0.00" AS discount_pct, TIMESTAMP("2026-02-03 09:20:00+00") AS sold_at),
  STRUCT(4 AS sale_line_id, "ORD-1004" AS order_id, "ST03" AS store_id, "BK03" AS product_id, 1 AS quantity, NUMERIC "599.00" AS unit_price, NUMERIC "0.10" AS discount_pct, TIMESTAMP("2026-02-21 16:05:00+00") AS sold_at),
  STRUCT(5 AS sale_line_id, "ORD-1005" AS order_id, "ST02" AS store_id, "BK01" AS product_id, 1 AS quantity, NUMERIC "1199.00" AS unit_price, NUMERIC "0.00" AS discount_pct, TIMESTAMP("2026-03-02 11:45:00+00") AS sold_at),
  STRUCT(6 AS sale_line_id, "ORD-1006" AS order_id, "ST01" AS store_id, "AC02" AS product_id, 1 AS quantity, NUMERIC "39.00" AS unit_price, NUMERIC "0.00" AS discount_pct, TIMESTAMP("2026-03-11 12:10:00+00") AS sold_at),
  STRUCT(7 AS sale_line_id, "ORD-1007" AS order_id, "ST03" AS store_id, "BK02" AS product_id, 1 AS quantity, NUMERIC "1399.00" AS unit_price, NUMERIC "0.05" AS discount_pct, TIMESTAMP("2026-04-06 15:00:00+00") AS sold_at),
  STRUCT(8 AS sale_line_id, "ORD-1008" AS order_id, "ST02" AS store_id, "AC01" AS product_id, 1 AS quantity, NUMERIC "69.00" AS unit_price, NUMERIC "0.00" AS discount_pct, TIMESTAMP("2026-04-19 10:40:00+00") AS sold_at),
  STRUCT(9 AS sale_line_id, "ORD-1009" AS order_id, "ST04" AS store_id, "BK04" AS product_id, 1 AS quantity, NUMERIC "1499.00" AS unit_price, NUMERIC "0.08" AS discount_pct, TIMESTAMP("2026-01-25 11:10:00+00") AS sold_at),
  STRUCT(10 AS sale_line_id, "ORD-1010" AS order_id, "ST05" AS store_id, "BK05" AS product_id, 2 AS quantity, NUMERIC "1299.00" AS unit_price, NUMERIC "0.00" AS discount_pct, TIMESTAMP("2026-02-14 09:45:00+00") AS sold_at),
  STRUCT(11 AS sale_line_id, "ORD-1011" AS order_id, "ST04" AS store_id, "AC03" AS product_id, 3 AS quantity, NUMERIC "24.00" AS unit_price, NUMERIC "0.00" AS discount_pct, TIMESTAMP("2026-03-04 13:15:00+00") AS sold_at),
  STRUCT(12 AS sale_line_id, "ORD-1012" AS order_id, "ST05" AS store_id, "BK01" AS product_id, 1 AS quantity, NUMERIC "1199.00" AS unit_price, NUMERIC "0.07" AS discount_pct, TIMESTAMP("2026-03-22 15:40:00+00") AS sold_at),
  STRUCT(13 AS sale_line_id, "ORD-1013" AS order_id, "ST03" AS store_id, "AC02" AS product_id, 2 AS quantity, NUMERIC "39.00" AS unit_price, NUMERIC "0.00" AS discount_pct, TIMESTAMP("2026-04-11 12:05:00+00") AS sold_at),
  STRUCT(14 AS sale_line_id, "ORD-1014" AS order_id, "ST02" AS store_id, "BK04" AS product_id, 1 AS quantity, NUMERIC "1499.00" AS unit_price, NUMERIC "0.10" AS discount_pct, TIMESTAMP("2026-04-28 16:20:00+00") AS sold_at),
  STRUCT(15 AS sale_line_id, "ORD-1015" AS order_id, "ST01" AS store_id, "BK03" AS product_id, 2 AS quantity, NUMERIC "599.00" AS unit_price, NUMERIC "0.05" AS discount_pct, TIMESTAMP("2026-05-09 10:00:00+00") AS sold_at),
  STRUCT(16 AS sale_line_id, "ORD-1016" AS order_id, "ST04" AS store_id, "BK02" AS product_id, 1 AS quantity, NUMERIC "1399.00" AS unit_price, NUMERIC "0.00" AS discount_pct, TIMESTAMP("2026-05-18 17:05:00+00") AS sold_at),
  STRUCT(17 AS sale_line_id, "ORD-1017" AS order_id, "ST05" AS store_id, "AC01" AS product_id, 1 AS quantity, NUMERIC "69.00" AS unit_price, NUMERIC "0.00" AS discount_pct, TIMESTAMP("2026-05-27 08:55:00+00") AS sold_at),
  STRUCT(18 AS sale_line_id, "ORD-1018" AS order_id, "ST03" AS store_id, "BK05" AS product_id, 1 AS quantity, NUMERIC "1299.00" AS unit_price, NUMERIC "0.03" AS discount_pct, TIMESTAMP("2026-06-03 11:20:00+00") AS sold_at),
  STRUCT(19 AS sale_line_id, "ORD-1019" AS order_id, "ST02" AS store_id, "AC03" AS product_id, 3 AS quantity, NUMERIC "24.00" AS unit_price, NUMERIC "0.00" AS discount_pct, TIMESTAMP("2026-06-14 14:10:00+00") AS sold_at),
  STRUCT(20 AS sale_line_id, "ORD-1020" AS order_id, "ST01" AS store_id, "BK05" AS product_id, 2 AS quantity, NUMERIC "1299.00" AS unit_price, NUMERIC "0.04" AS discount_pct, TIMESTAMP("2026-06-19 18:30:00+00") AS sold_at),
  STRUCT(21 AS sale_line_id, "ORD-1021" AS order_id, "ST04" AS store_id, "BK01" AS product_id, 1 AS quantity, NUMERIC "1199.00" AS unit_price, NUMERIC "0.00" AS discount_pct, TIMESTAMP("2026-06-24 09:25:00+00") AS sold_at),
  STRUCT(22 AS sale_line_id, "ORD-1022" AS order_id, "ST05" AS store_id, "BK03" AS product_id, 2 AS quantity, NUMERIC "599.00" AS unit_price, NUMERIC "0.06" AS discount_pct, TIMESTAMP("2026-06-26 12:00:00+00") AS sold_at)
]);

CREATE OR REPLACE TABLE raw_data.inventory AS
SELECT * FROM UNNEST([
  STRUCT("ST01" AS store_id, "BK01" AS product_id, 2 AS units_on_hand, 3 AS reorder_point, DATE("2026-06-30") AS snapshot_date),
  STRUCT("ST01" AS store_id, "BK02" AS product_id, 5 AS units_on_hand, 2 AS reorder_point, DATE("2026-06-30") AS snapshot_date),
  STRUCT("ST01" AS store_id, "BK03" AS product_id, 3 AS units_on_hand, 3 AS reorder_point, DATE("2026-06-30") AS snapshot_date),
  STRUCT("ST01" AS store_id, "AC01" AS product_id, 14 AS units_on_hand, 8 AS reorder_point, DATE("2026-06-30") AS snapshot_date),
  STRUCT("ST02" AS store_id, "BK01" AS product_id, 4 AS units_on_hand, 3 AS reorder_point, DATE("2026-06-30") AS snapshot_date),
  STRUCT("ST02" AS store_id, "BK02" AS product_id, 2 AS units_on_hand, 2 AS reorder_point, DATE("2026-06-30") AS snapshot_date),
  STRUCT("ST02" AS store_id, "BK04" AS product_id, 1 AS units_on_hand, 2 AS reorder_point, DATE("2026-06-30") AS snapshot_date),
  STRUCT("ST02" AS store_id, "AC03" AS product_id, 8 AS units_on_hand, 5 AS reorder_point, DATE("2026-06-30") AS snapshot_date),
  STRUCT("ST03" AS store_id, "BK03" AS product_id, 1 AS units_on_hand, 2 AS reorder_point, DATE("2026-06-30") AS snapshot_date),
  STRUCT("ST03" AS store_id, "BK05" AS product_id, 0 AS units_on_hand, 2 AS reorder_point, DATE("2026-06-30") AS snapshot_date),
  STRUCT("ST03" AS store_id, "AC02" AS product_id, 7 AS units_on_hand, 6 AS reorder_point, DATE("2026-06-30") AS snapshot_date),
  STRUCT("ST04" AS store_id, "BK02" AS product_id, 3 AS units_on_hand, 2 AS reorder_point, DATE("2026-06-30") AS snapshot_date),
  STRUCT("ST04" AS store_id, "BK04" AS product_id, 4 AS units_on_hand, 3 AS reorder_point, DATE("2026-06-30") AS snapshot_date),
  STRUCT("ST04" AS store_id, "AC01" AS product_id, 9 AS units_on_hand, 6 AS reorder_point, DATE("2026-06-30") AS snapshot_date),
  STRUCT("ST05" AS store_id, "BK01" AS product_id, 2 AS units_on_hand, 2 AS reorder_point, DATE("2026-06-30") AS snapshot_date),
  STRUCT("ST05" AS store_id, "BK05" AS product_id, 3 AS units_on_hand, 3 AS reorder_point, DATE("2026-06-30") AS snapshot_date),
  STRUCT("ST05" AS store_id, "AC03" AS product_id, 6 AS units_on_hand, 4 AS reorder_point, DATE("2026-06-30") AS snapshot_date)
]);