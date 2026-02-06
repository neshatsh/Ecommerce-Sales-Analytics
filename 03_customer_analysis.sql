--B. Customer Analysis

-- Customer Lifetime Value (CLV)
SELECT 
    c.customer_unique_id,
    COUNT(DISTINCT o.order_id) as total_orders,
    ROUND(SUM(oi.price)::numeric, 2) as lifetime_value,
    ROUND(AVG(oi.price)::numeric, 2) as avg_order_value,
    MIN(o.order_purchase_timestamp) as first_purchase,
    MAX(o.order_purchase_timestamp) as last_purchase
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
WHERE o.order_status = 'delivered'
GROUP BY c.customer_unique_id
ORDER BY lifetime_value DESC
LIMIT 100;

-- RFM Analysis (Recency, Frequency, Monetary)
WITH customer_metrics AS (
    SELECT 
        c.customer_unique_id,
        MAX(o.order_purchase_timestamp) as last_purchase_date,
        COUNT(DISTINCT o.order_id) as frequency,
        SUM(oi.price) as monetary_value
    FROM customers c
    JOIN orders o ON c.customer_id = o.customer_id
    JOIN order_items oi ON o.order_id = oi.order_id
    WHERE o.order_status = 'delivered'
    GROUP BY c.customer_unique_id
),
rfm_scores AS (
    SELECT 
        customer_unique_id,
        CURRENT_DATE - last_purchase_date::date as recency_days,
        frequency,
        monetary_value,
        NTILE(5) OVER (ORDER BY CURRENT_DATE - last_purchase_date::date DESC) as recency_score,
        NTILE(5) OVER (ORDER BY frequency) as frequency_score,
        NTILE(5) OVER (ORDER BY monetary_value) as monetary_score
    FROM customer_metrics
)
SELECT 
    customer_unique_id,
    recency_days,
    frequency,
    ROUND(monetary_value::numeric, 2) as monetary_value,
    recency_score,
    frequency_score,
    monetary_score,
    (recency_score + frequency_score + monetary_score) as rfm_total_score,
    CASE 
        WHEN (recency_score + frequency_score + monetary_score) >= 13 THEN 'Champions'
        WHEN (recency_score + frequency_score + monetary_score) >= 10 THEN 'Loyal Customers'
        WHEN (recency_score + frequency_score + monetary_score) >= 7 THEN 'Potential Loyalists'
        WHEN recency_score >= 4 THEN 'New Customers'
        ELSE 'At Risk'
    END as customer_segment
FROM rfm_scores
ORDER BY rfm_total_score DESC
LIMIT 100;

-- Repeat customer rate
SELECT 
    COUNT(DISTINCT CASE WHEN order_count > 1 THEN customer_unique_id END) as repeat_customers,
    COUNT(DISTINCT customer_unique_id) as total_customers,
    ROUND(COUNT(DISTINCT CASE WHEN order_count > 1 THEN customer_unique_id END) * 100.0 / 
          COUNT(DISTINCT customer_unique_id), 2) as repeat_rate_percentage
FROM (
    SELECT 
        c.customer_unique_id,
        COUNT(DISTINCT o.order_id) as order_count
    FROM customers c
    JOIN orders o ON c.customer_id = o.customer_id
    WHERE o.order_status = 'delivered'
    GROUP BY c.customer_unique_id
) customer_orders;
