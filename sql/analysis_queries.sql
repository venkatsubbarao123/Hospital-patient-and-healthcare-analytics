USE healthcare_analytics;

-- 1. Total admissions
SELECT COUNT(*) AS total_admissions
FROM admissions;

-- 2. Unique patients
SELECT COUNT(DISTINCT patient_id) AS unique_patients
FROM admissions;

-- 3. Total revenue
SELECT ROUND(SUM(billing_amount), 2) AS total_revenue
FROM admissions;

-- 4. Average billing amount
SELECT ROUND(AVG(billing_amount), 2) AS average_bill
FROM admissions;

-- 5. Average length of stay
SELECT ROUND(AVG(length_of_stay_days), 2) AS average_los
FROM admissions;

-- 6. Department performance
SELECT
    department,
    COUNT(*) AS admissions,
    ROUND(AVG(length_of_stay_days), 2) AS avg_los,
    ROUND(SUM(billing_amount), 2) AS revenue
FROM admissions
GROUP BY department
ORDER BY revenue DESC;

-- 7. Diagnosis volume
SELECT
    diagnosis,
    COUNT(*) AS admissions
FROM admissions
GROUP BY diagnosis
ORDER BY admissions DESC;

-- 8. Top diagnoses by revenue
SELECT
    diagnosis,
    COUNT(*) AS admissions,
    ROUND(SUM(billing_amount), 2) AS revenue
FROM admissions
GROUP BY diagnosis
ORDER BY revenue DESC
LIMIT 10;

-- 9. Gender distribution
SELECT
    gender,
    COUNT(*) AS patients
FROM admissions
GROUP BY gender;

-- 10. Insurance analysis
SELECT
    insurance_type,
    COUNT(*) AS admissions,
    ROUND(SUM(billing_amount), 2) AS revenue
FROM admissions
GROUP BY insurance_type
ORDER BY revenue DESC;

-- 11. Admission type analysis
SELECT
    admission_type,
    COUNT(*) AS admissions,
    ROUND(AVG(billing_amount), 2) AS avg_bill
FROM admissions
GROUP BY admission_type
ORDER BY admissions DESC;

-- 12. Discharge status
SELECT
    discharge_status,
    COUNT(*) AS admissions
FROM admissions
GROUP BY discharge_status
ORDER BY admissions DESC;

-- 13. Readmission rate
SELECT
    ROUND(AVG(is_readmission_30d) * 100, 2) AS readmission_rate_percent
FROM admissions;

-- 14. Readmission by department
SELECT
    department,
    COUNT(*) AS admissions,
    ROUND(AVG(is_readmission_30d) * 100, 2) AS readmission_rate
FROM admissions
GROUP BY department
ORDER BY readmission_rate DESC;

-- 15. Satisfaction by department
SELECT
    department,
    ROUND(AVG(patient_satisfaction), 2) AS avg_satisfaction
FROM admissions
GROUP BY department
ORDER BY avg_satisfaction DESC;

-- 16. Age group analysis
SELECT
    CASE
        WHEN age < 18 THEN 'Under 18'
        WHEN age BETWEEN 18 AND 35 THEN '18-35'
        WHEN age BETWEEN 36 AND 50 THEN '36-50'
        WHEN age BETWEEN 51 AND 65 THEN '51-65'
        ELSE '66+'
    END AS age_group,
    COUNT(*) AS admissions,
    ROUND(AVG(billing_amount), 2) AS avg_bill
FROM admissions
GROUP BY age_group
ORDER BY admissions DESC;

-- 17. Monthly admissions
SELECT
    DATE_FORMAT(admission_date, '%Y-%m') AS month,
    COUNT(*) AS admissions,
    ROUND(SUM(billing_amount), 2) AS revenue
FROM admissions
GROUP BY month
ORDER BY month;

-- 18. Monthly revenue
SELECT
    YEAR(admission_date) AS year,
    MONTH(admission_date) AS month,
    ROUND(SUM(billing_amount), 2) AS revenue
FROM admissions
GROUP BY year, month
ORDER BY year, month;

-- 19. High-value admissions
SELECT
    admission_id,
    patient_id,
    department,
    diagnosis,
    billing_amount,
    length_of_stay_days
FROM admissions
ORDER BY billing_amount DESC
LIMIT 20;

-- 20. Readmitted patients
SELECT
    patient_id,
    COUNT(*) AS admissions,
    ROUND(AVG(length_of_stay_days), 2) AS avg_los,
    ROUND(SUM(billing_amount), 2) AS total_billing
FROM admissions
WHERE is_readmission_30d = 1
GROUP BY patient_id
ORDER BY admissions DESC;