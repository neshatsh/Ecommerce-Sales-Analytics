--D. Delivery Performance Analysis
-- Average delivery time by state
SELECT 
    c.customer_state,
    COUNT(o.order_id) as total_orders,
    ROUND(AVG(EXTRACT(EPOCH FROM (o.order_delivered_customer_date - o.order_purchase_timestamp))/86400)::numeric, 2) as avg_delivery_days,
    ROUND(AVG(EXTRACT(EPOCH FROM (o.order_estimated_delivery_date - o.order_delivered_customer_date))/86400)::numeric, 2) as avg_delivery_vs_estimate_days
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
WHERE o.order_status = 'delivered'
  AND o.order_delivered_customer_date IS NOT NULL
GROUP BY c.customer_state
ORDER BY avg_delivery_days;