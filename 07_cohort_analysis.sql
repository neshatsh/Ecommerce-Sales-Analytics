--F. Cohort Analysis (Advanced)

-- Monthly cohort retention analysis
WITH customer_cohorts AS (
    SELECT 
        c.customer_unique_id,
        DATE_TRUNC('month', MIN(o.order_purchase_timestamp)) as cohort_month,
        DATE_TRUNC('month', o.order_purchase_timestamp) as order_month
    FROM customers c
    JOIN orders o ON c.customer_id = o.customer_id
    WHERE o.order_status = 'delivered'
    GROUP BY c.customer_unique_id, DATE_TRUNC('month', o.order_purchase_timestamp)
),
cohort_data AS (
    SELECT 
        cohort_month,
        order_month,
        EXTRACT(YEAR FROM AGE(order_month, cohort_month)) * 12 + 
        EXTRACT(MONTH FROM AGE(order_month, cohort_month)) as month_number,
        COUNT(DISTINCT customer_unique_id) as customers
    FROM customer_cohorts
    GROUP BY cohort_month, order_month
)
SELECT 
    cohort_month,
    month_number,
    customers,
    FIRST_VALUE(customers) OVER (PARTITION BY cohort_month ORDER BY month_number) as cohort_size,
    ROUND(customers * 100.0 / FIRST_VALUE(customers) OVER (PARTITION BY cohort_month ORDER BY month_number), 2) as retention_rate
FROM cohort_data
ORDER BY cohort_month, month_number;



