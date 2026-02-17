# E-Commerce Sales Analytics

**SQL & Power BI Project**


## Project Overview

End-to-end data analytics project analyzing **99,441 Brazilian e-commerce orders** spanning 772 days (September 2016 – October 2018) to uncover sales trends, customer behavior, product performance, and delivery insights using PostgreSQL and Power BI.

**Dataset:** [Brazilian E-Commerce Public Dataset by Olist](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce) (Kaggle)

---

## Dataset Scale

| Table | Row Count |
|---|---|
| order_items | 112,650 |
| order_payments | 103,886 |
| orders | 99,441 |
| customers | 99,441 |
| order_reviews | 98,410 |
| products | 32,951 |
| sellers | 3,095 |

**Date range:** 2016-09-04 → 2018-10-17 (772 days, 20 hours)

---

## Business Questions Answered

- Which states and product categories generate the most revenue?
- What are the monthly sales trends and growth patterns?
- How do customers behave — repeat purchase rate, lifetime value, RFM segments?
- What is the relationship between delivery time and geography?
- Which payment methods are most popular, and how do installments vary?
- What is the customer retention rate over time (cohort analysis)?

---

##  Key Insights

### Order Status
Out of 99,441 total orders:
- **Delivered:** 96,478 (97.02%)
- **Shipped:** 1,107 (1.11%)
- **Canceled:** 625 (0.63%)
- **Unavailable:** 609 (0.61%)
- **Invoiced:** 314 (0.32%)
- **Processing:** 301 (0.30%)

### Sales Performance
- Orders grew from **1 order (Sep 2016)** to **7,289 orders (Nov 2017)** — explosive growth in ~14 months
- Monthly average order value consistently ranged between **R\$109 – R\$133**
- **SP state dominates** with 40,501 orders and R\$5,067,633.16 in revenue (avg order R\$109.10)
- Top 5 states (SP, RJ, MG, RS, PR) account for the vast majority of sales

### Top 10 States by Revenue
| State | Orders | Revenue (R$) | Avg Order (R$) |
|---|---|---|---|
| SP | 40,501 | 5,067,633.16 | 109.10 |
| RJ | 12,350 | 1,759,651.13 | 124.42 |
| MG | 11,354 | 1,552,481.83 | 120.20 |
| RS | 5,345 | 728,897.47 | 118.83 |
| PR | 4,923 | 666,063.51 | 117.91 |
| SC | 3,546 | 507,012.13 | 123.75 |
| BA | 3,256 | 493,584.14 | 134.02 |
| DF | 2,080 | 296,498.41 | 125.90 |
| ES | 1,995 | 268,643.45 | 120.74 |
| GO | 1,957 | 282,836.70 | 124.21 |

### Top 10 Product Categories by Revenue
| Category              | Orders | Revenue (R$) | Avg Price (R$) | Avg Rating |
|-----------------------|--------|--------------|----------------|---|
| health_beauty         | 8,647  | 1,234,195.12 | 130.28         | 4.19 |
| watches_gifts         | 5,495  | 1,166,427.74 | 199.04         | 4.07 |
| bed_bath_table        | 9,272  | 1,031,836.60 | 93.44          | 3.92 |
| sports_leisure        | 7,530  | 957,262.35   | 113.25         | 4.17 |
| computers_accessories | 6,530  | 891,682.66   | 116.26         | 3.99 |
| furniture_decor       | 6,307  | 713,794.42   | 87.25          | 3.96 |
| housewares            | 5,743  | 617,376.49   | 90.60          | 4.11 |
| cool_stuff            | 3,559  | 610,633.89   | 164.12         | 4.20 |
| auto                  | 3,810  | 579,341.70   | 139.85         | 4.12 |
| toys                  | 3,804  | 471,286.48   | 116.94         | 4.08 |

> **bed_bath_table** has the highest order volume (9,272), while **watches_gifts** commands the highest average price (R$199.04).

### Customer Behavior
- **Total unique customers:** 93,358 (delivered orders)
- **Repeat customers:** 2,801 — only **3% repeat purchase rate**, indicating this is primarily a one-time purchase platform
- **Highest CLV recorded:** R$13,440 (single order)
### Delivery Performance (by State)
| State | Orders | Avg Delivery Days | avg_delivery_vs_estimate_days |
|---|---|---|---|
| SP | 40,494 | 8.76 | 10.38 |
| PR | 4,923 | 11.99 | 12.62 |
| MG | 11,354 | 12.01 | 12.54 |
| DF | 2,080 | 12.97 | 11.34 |
| SC | 3,546 | 14.95 | 10.80 |
| RS | 5,344 | 15.30 | 13.21 |
| RJ | 12,350 | 15.31 | 11.05 |
| ... | ... | ... | ... |
| CE | 1,279 | 21.27 | 10.11 |
| AC | 80 | 21.04 | 20.08 |

> All 27 states show **positive avg_delivery_vs_estimate_days**, meaning deliveries consistently arrive **earlier than the estimated date** — a strong operational achievement.

### Payment Methods
| Payment Type | Orders | Total Value (R$) | Avg Value (R$) | Avg Installments |
|---|---|---|---|---|
| credit_card | 76,505 | 12,542,084.19 | 163.32 | 3.51 |
| boleto | 19,784 | 2,869,361.27 | 145.03 | 1.00 |
| voucher | 3,866 | 379,436.87 | 65.70 | 1.00 |
| debit_card | 1,528 | 217,989.79 | 142.57 | 1.00 |

> **Credit card dominates at ~74% of all orders** and is the only payment method used with installments (avg 3.51x), reflecting Brazil's strong *parcelamento* (installment) culture.

### Cohort Analysis
Monthly cohort analysis (Sep 2016 – Aug 2018) confirms the low retention finding: virtually all customers appear only in their acquisition month (month_number = 0, retention_rate = 100%), with near-zero return in subsequent months. This aligns directly with the 3% repeat purchase rate and suggests the platform functions primarily as a **new-customer acquisition engine** rather than a retention-driven business.

---

## Technologies Used

- **Database:** PostgreSQL
- **Database Tool:** DBeaver / PyCharm
- **Language:** SQL
- **Visualization:** Power BI Desktop
- **Version Control:** Git, GitHub

---

## Project Structure

```
├── 00_database_schema.sql     # Database design & table creation
├── 01_data_exploration.sql    # Row counts, date range, order status distribution
├── 02_sales_analysis.sql      # Monthly revenue trends, top categories, geographic analysis
├── 03_customer_analysis.sql   # CLV, RFM segmentation, repeat customer rate
├── 04_product_analysis.sql    # Best-selling products, category performance with ratings
├── 05_delivery_analysis.sql   # Delivery time by state vs. estimated delivery
├── 06_payment_analysis.sql    # Payment method preferences & installment behavior
├── 07_cohort_analysis.sql     # Monthly cohort retention analysis
└── README.md
```

---

## SQL Skills Demonstrated

- **Window Functions:** `NTILE`, `RANK`, `FIRST_VALUE`, `ROW_NUMBER` for customer segmentation and cohort retention
- **CTEs:** Multi-step Common Table Expressions for RFM scoring and cohort analysis
- **Date Functions:** `DATE_TRUNC`, `EXTRACT`, `AGE` for time-series and tenure calculations
- **Complex JOINs:** Multi-table joins across 4–5 tables
- **Aggregations:** `GROUP BY`, `HAVING`, `SUM`, `AVG`, `COUNT(DISTINCT ...)`
- **Conditional Logic:** `CASE WHEN` for RFM segment labeling
- **NULL Handling:** `COALESCE` for product category translation fallbacks
- **Epoch Calculations:** `EXTRACT(EPOCH FROM ...)` for precise day-level delivery calculations

---

## How to Run This Project

### Prerequisites
- PostgreSQL (v12 or higher)
- Power BI Desktop (for viewing the dashboard)

### Setup Instructions

1. **Clone the repository**
```bash
git clone https://github.com/neshatsh/Ecommerce-Sales-Analytics.git
cd Ecommerce-Sales-Analytics
```

2. **Download the dataset**
   - Get the data from [Kaggle – Brazilian E-Commerce](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce)
   - Extract the CSV files

3. **Create the database and tables**
```bash
psql -U postgres
CREATE DATABASE ecommerce_analytics;
\c ecommerce_analytics
\i 00_database_schema.sql
```

4. **Import data**
   - Use DBeaver's CSV import wizard or PostgreSQL `COPY` commands to load each CSV into its table

5. **Run analysis queries**
   - Execute SQL files in order: `01` through `07`

6. **View the Power BI dashboard**
   - Open `ecommerce_dashboard.pbix` in Power BI Desktop

---

## Dashboard Preview

The Power BI dashboard includes:
- **Executive Overview:** KPIs, revenue trends, geographic map
- **Sales Analysis:** Monthly trends, category performance, payment methods
- **Customer Analytics:** RFM segmentation, review scores, state distribution

---

## Sample Queries

### Monthly Revenue Trend
```sql
SELECT
    DATE_TRUNC('month', o.order_purchase_timestamp) as month,
    COUNT(DISTINCT o.order_id) as total_orders,
    ROUND(SUM(oi.price)::numeric, 2) as total_revenue,
    ROUND(AVG(oi.price)::numeric, 2) as avg_order_value
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
WHERE o.order_status = 'delivered'
GROUP BY DATE_TRUNC('month', o.order_purchase_timestamp)
ORDER BY month;
```

### Repeat Customer Rate
```sql
SELECT
    COUNT(DISTINCT CASE WHEN order_count > 1 THEN customer_unique_id END) as repeat_customers,
    COUNT(DISTINCT customer_unique_id) as total_customers,
    ROUND(COUNT(DISTINCT CASE WHEN order_count > 1 THEN customer_unique_id END) * 100.0 /
          COUNT(DISTINCT customer_unique_id), 2) as repeat_rate_percentage
FROM (
    SELECT c.customer_unique_id, COUNT(DISTINCT o.order_id) as order_count
    FROM customers c
    JOIN orders o ON c.customer_id = o.customer_id
    WHERE o.order_status = 'delivered'
    GROUP BY c.customer_unique_id
) customer_orders;
-- Result: 2,801 repeat customers / 93,358 total = 3%
```

---
