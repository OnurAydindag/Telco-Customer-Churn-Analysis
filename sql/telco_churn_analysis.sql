-- Create customer_churn table
CREATE TABLE customer_churn (
    customer_id VARCHAR(50) PRIMARY KEY,
    gender VARCHAR(10),
    senior_citizen INTEGER,
    partner VARCHAR(5),
    dependents VARCHAR(5),
    tenure INTEGER,
    phone_service VARCHAR(5),
    multiple_lines VARCHAR(50),
    internet_service VARCHAR(50),
    online_security VARCHAR(50),
    online_backup VARCHAR(50),
    device_protection VARCHAR(50),
    tech_support VARCHAR(50),
    streaming_tv VARCHAR(50),
    streaming_movies VARCHAR(50),
    contract VARCHAR(50),
    paperless_billing VARCHAR(5),
    payment_method VARCHAR(50),
    monthly_charges DECIMAL(10,2),
    total_charges DECIMAL(10,2),
    churn VARCHAR(5)
);

-- Check if data loaded successfully
SELECT COUNT(*) as total_records FROM customer_churn;

-- View first 10 rows
SELECT * FROM customer_churn LIMIT 10;




-- ===== CHURN ANALYSIS =====

-- 1. Overall churn statistics
SELECT 
    churn,
    COUNT(*) as customer_count,
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER(), 2) as percentage
FROM customer_churn
GROUP BY churn
ORDER BY churn DESC;

-- 2. Churn rate summary
SELECT 
    COUNT(*) as total_customers,
    SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END) as churned_customers,
    SUM(CASE WHEN churn = 'No' THEN 1 ELSE 0 END) as retained_customers,
    ROUND(SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) as churn_rate_percent
FROM customer_churn;



-- ===== DEMOGRAPHIC ANALYSIS =====

-- 3. Churn by Gender
SELECT 
    gender,
    COUNT(*) as total_customers,
    SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END) as churned,
    ROUND(SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) as churn_rate
FROM customer_churn
GROUP BY gender
ORDER BY churn_rate DESC;

-- 4. Churn by Senior Citizen
SELECT 
    CASE 
        WHEN senior_citizen = 1 THEN 'Senior'
        ELSE 'Not Senior'
    END as customer_type,
    COUNT(*) as total_customers,
    SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END) as churned,
    ROUND(SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) as churn_rate
FROM customer_churn
GROUP BY senior_citizen
ORDER BY churn_rate DESC;

-- 5. Churn by Partner Status
SELECT 
    partner,
    COUNT(*) as total_customers,
    SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END) as churned,
    ROUND(SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) as churn_rate
FROM customer_churn
GROUP BY partner
ORDER BY churn_rate DESC;

-- 6. Churn by Dependents
SELECT 
    dependents,
    COUNT(*) as total_customers,
    SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END) as churned,
    ROUND(SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) as churn_rate
FROM customer_churn
GROUP BY dependents
ORDER BY churn_rate DESC;



-- ===== SERVICE USAGE ANALYSIS =====

-- 7. Churn by Internet Service Type
SELECT 
    internet_service,
    COUNT(*) as total_customers,
    SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END) as churned,
    ROUND(SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) as churn_rate
FROM customer_churn
GROUP BY internet_service
ORDER BY churn_rate DESC;

-- 8. Churn by Phone Service
SELECT 
    phone_service,
    COUNT(*) as total_customers,
    SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END) as churned,
    ROUND(SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) as churn_rate
FROM customer_churn
GROUP BY phone_service
ORDER BY churn_rate DESC;

-- 9. Churn by Online Security
SELECT 
    online_security,
    COUNT(*) as total_customers,
    SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END) as churned,
    ROUND(SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) as churn_rate
FROM customer_churn
GROUP BY online_security
ORDER BY churn_rate DESC;

-- 10. Churn by Tech Support
SELECT 
    tech_support,
    COUNT(*) as total_customers,
    SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END) as churned,
    ROUND(SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) as churn_rate
FROM customer_churn
GROUP BY tech_support
ORDER BY churn_rate DESC;



-- ===== CONTRACT AND PAYMENT ANALYSIS =====

-- 11. Churn by Contract Type
SELECT 
    contract,
    COUNT(*) as total_customers,
    SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END) as churned,
    ROUND(SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) as churn_rate
FROM customer_churn
GROUP BY contract
ORDER BY churn_rate DESC;

-- 12. Churn by Payment Method
SELECT 
    payment_method,
    COUNT(*) as total_customers,
    SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END) as churned,
    ROUND(SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) as churn_rate
FROM customer_churn
GROUP BY payment_method
ORDER BY churn_rate DESC;

-- 13. Churn by Paperless Billing
SELECT 
    paperless_billing,
    COUNT(*) as total_customers,
    SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END) as churned,
    ROUND(SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) as churn_rate
FROM customer_churn
GROUP BY paperless_billing
ORDER BY churn_rate DESC;



-- ===== FINANCIAL AND TENURE ANALYSIS =====

-- 14. Average tenure by churn status
SELECT 
    churn,
    COUNT(*) as total_customers,
    ROUND(AVG(tenure), 2) as avg_tenure_months,
    MIN(tenure) as min_tenure,
    MAX(tenure) as max_tenure
FROM customer_churn
GROUP BY churn
ORDER BY churn DESC;

-- 15. Average monthly charges by churn status
SELECT 
    churn,
    COUNT(*) as total_customers,
    ROUND(AVG(monthly_charges), 2) as avg_monthly_charges,
    ROUND(MIN(monthly_charges), 2) as min_monthly_charges,
    ROUND(MAX(monthly_charges), 2) as max_monthly_charges
FROM customer_churn
GROUP BY churn
ORDER BY churn DESC;

-- 16. Average total charges by churn status
SELECT 
    churn,
    COUNT(*) as total_customers,
    ROUND(AVG(total_charges), 2) as avg_total_charges,
    ROUND(MIN(total_charges), 2) as min_total_charges,
    ROUND(MAX(total_charges), 2) as max_total_charges
FROM customer_churn
GROUP BY churn
ORDER BY churn DESC;

-- 17. Tenure segments and churn
SELECT 
    CASE 
        WHEN tenure <= 12 THEN '0-12 months'
        WHEN tenure <= 24 THEN '13-24 months'
        WHEN tenure <= 48 THEN '25-48 months'
        ELSE '49+ months'
    END as tenure_segment,
    COUNT(*) as total_customers,
    SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END) as churned,
    ROUND(SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) as churn_rate
FROM customer_churn
GROUP BY tenure_segment
ORDER BY churn_rate DESC;



-- ===== ADVANCED BUSINESS INSIGHTS =====

-- 18. High-risk customer profile (multiple risk factors)
SELECT 
    COUNT(*) as high_risk_customers,
    SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END) as churned,
    ROUND(SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) as churn_rate
FROM customer_churn
WHERE 
    contract = 'Month-to-month'
    AND tenure <= 12
    AND tech_support = 'No'
    AND online_security = 'No';

-- 19. Revenue impact analysis
SELECT 
    churn,
    COUNT(*) as customers,
    ROUND(SUM(monthly_charges), 2) as total_monthly_revenue,
    ROUND(AVG(monthly_charges), 2) as avg_monthly_revenue_per_customer,
    ROUND(SUM(total_charges), 2) as total_lifetime_revenue
FROM customer_churn
GROUP BY churn
ORDER BY churn DESC;

-- 20. Most profitable customer segments (low churn, high revenue)
SELECT 
    contract,
    internet_service,
    COUNT(*) as customers,
    ROUND(AVG(monthly_charges), 2) as avg_monthly_charges,
    ROUND(SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) as churn_rate
FROM customer_churn
GROUP BY contract, internet_service
HAVING COUNT(*) >= 100
ORDER BY churn_rate ASC, avg_monthly_charges DESC
LIMIT 10;

-- 21. Customer lifetime value by segment
SELECT 
    contract,
    ROUND(AVG(tenure), 2) as avg_tenure,
    ROUND(AVG(monthly_charges), 2) as avg_monthly_charges,
    ROUND(AVG(total_charges), 2) as avg_lifetime_value,
    ROUND(SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) as churn_rate
FROM customer_churn
GROUP BY contract
ORDER BY avg_lifetime_value DESC;