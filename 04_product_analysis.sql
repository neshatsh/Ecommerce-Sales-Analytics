
--C. Product Performance Analysis

-- Top 10 best-selling products
SELECT 
    p.product_id,
    COALESCE(pct.product_category_name_english, p.product_category_name) as category,
    COUNT(oi.order_id) as times_sold,
    ROUND(SUM(oi.price)::numeric, 2) as total_revenue,
    ROUND(AVG(oi.price)::numeric, 2) as avg_price
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
LEFT JOIN product_category_translation pct ON p.product_category_name = pct.product_category_name
JOIN orders o ON oi.order_id = o.order_id
WHERE o.order_status = 'delivered'
GROUP BY p.product_id, COALESCE(pct.product_category_name_english, p.product_category_name)
ORDER BY total_revenue DESC
LIMIT 10;

-- Product category performance with review ratings
SELECT 
    COALESCE(pct.product_category_name_english, p.product_category_name, 'Unknown') as category,
    COUNT(DISTINCT oi.order_id) as total_orders,
    ROUND(SUM(oi.price)::numeric, 2) as total_revenue,
    ROUND(AVG(r.review_score)::numeric, 2) as avg_rating,
    COUNT(r.review_id) as review_count
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
LEFT JOIN product_category_translation pct ON p.product_category_name = pct.product_category_name
JOIN orders o ON oi.order_id = o.order_id
LEFT JOIN order_reviews r ON o.order_id = r.order_id
WHERE o.order_status = 'delivered'
GROUP BY COALESCE(pct.product_category_name_english, p.product_category_name, 'Unknown')
HAVING COUNT(DISTINCT oi.order_id) > 100
ORDER BY total_revenue DESC;
