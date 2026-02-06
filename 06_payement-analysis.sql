--E. Payment Analysis

-- Payment method preferences
SELECT 
    payment_type,
    COUNT(DISTINCT order_id) as total_orders,
    ROUND(SUM(payment_value)::numeric, 2) as total_value,
    ROUND(AVG(payment_value)::numeric, 2) as avg_value,
    ROUND(AVG(payment_installments)::numeric, 2) as avg_installments
FROM order_payments
GROUP BY payment_type
ORDER BY total_orders DESC;