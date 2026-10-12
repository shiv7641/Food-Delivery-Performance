sql
-- 1. Identifying Overall Delay Metrics
SELECT 
    COUNT(order_id) AS total_orders,
    SUM(CASE WHEN status = 'Late' THEN 1 ELSE 0 END) AS late_orders,
    ROUND(SUM(CASE WHEN status = 'Late' THEN 1 ELSE 0 END) * 100.0 / COUNT(order_id), 2) AS late_delivery_percentage
FROM quick_eats_orders;

-- 2. Analyzing Delay Rates by Time Window
SELECT 
    time_bin,
    COUNT(order_id) AS total_orders,
    ROUND(SUM(CASE WHEN status = 'Late' THEN 1 ELSE 0 END) * 100.0 / COUNT(order_id), 2) AS late_percentage
FROM quick_eats_orders
GROUP BY time_bin
ORDER BY late_percentage DESC;

-- 3. Segmenting Geographic Delay Thresholds
SELECT 
    area_location,
    COUNT(order_id) AS total_orders,
    ROUND(AVG(delivery_time_minutes), 1) AS avg_delivery_time,
    ROUND(SUM(CASE WHEN status = 'Late' THEN 1 ELSE 0 END) * 100.0 / COUNT(order_id), 2) AS late_rate
FROM quick_eats_orders
GROUP BY area_location
ORDER BY late_rate DESC;
