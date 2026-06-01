DESCRIBE banking_db.loan_master;
SELECT 
    COUNT(*) AS total_loan_applications,
    ROUND(SUM(loan_amnt), 2) AS total_funded_amount,
    ROUND(SUM(total_pymnt), 2) AS total_amount_collected,
    ROUND(AVG(int_rate), 2) AS average_interest_rate,
    ROUND(AVG(dti), 2) AS average_dti_ratio
FROM banking_db.loan_master;

SELECT
    COUNT(CASE WHEN loan_status IN ('Fully Paid', 'Current') THEN id END) AS good_loan_applications,
    COUNT(CASE WHEN loan_status = 'Charged Off' THEN id END) AS bad_loan_applications
FROM banking_db.loan_master;

SELECT
    ROUND(SUM(CASE WHEN loan_status IN ('Fully Paid', 'Current') THEN loan_amnt ELSE 0 END), 2) AS good_loan_funded_amount,
    ROUND(SUM(CASE WHEN loan_status = 'Charged Off' THEN loan_amnt ELSE 0 END), 2) AS bad_loan_funded_amount
FROM banking_db.loan_master;

SELECT
    ROUND(
        (COUNT(CASE WHEN loan_status = 'Charged Off' THEN id END) * 100.0) / COUNT(*), 
        2
    ) AS default_rate_percentage
FROM banking_db.loan_master;

SELECT 
    addr_state AS borrower_state,
    COUNT(*) AS total_loan_applications,
    ROUND(SUM(loan_amnt), 2) AS total_funded_amount
FROM banking_db.loan_master
GROUP BY addr_state
ORDER BY total_loan_applications DESC;

SELECT 
    home_ownership,
    COUNT(*) AS total_loan_applications,
    ROUND(AVG(loan_amnt), 2) AS avg_loan_amount
FROM banking_db.loan_master
WHERE home_ownership IS NOT NULL
GROUP BY home_ownership
ORDER BY total_loan_applications DESC;

SELECT 
    MONTH(issue_d) AS month_number,
    MONTHNAME(issue_d) AS month_name,
    COUNT(*) AS total_loan_applications,
    ROUND(SUM(loan_amnt), 2) AS total_funded_amount,
    ROUND(SUM(total_pymnt), 2) AS total_cash_collected
FROM banking_db.loan_master
GROUP BY MONTH(issue_d), MONTHNAME(issue_d)
ORDER BY MONTH(issue_d) ASC;

SELECT 
    term,
    COUNT(*) AS total_loan_applications,
    ROUND(SUM(loan_amnt), 2) AS total_funded_amount,
    ROUND(AVG(int_rate), 2) AS avg_interest_rate
FROM banking_db.loan_master
GROUP BY term;

SELECT 
    emp_length AS employment_years,
    COUNT(*) AS total_loan_applications,
    ROUND(AVG(loan_amnt), 2) AS avg_loan_amount
FROM banking_db.loan_master
GROUP BY emp_length
ORDER BY emp_length ASC;

SELECT 
    verification_status,
    COUNT(*) AS total_loan_applications,
    ROUND(SUM(loan_amnt), 2) AS total_funded_amount,
    ROUND(AVG(loan_amnt), 2) AS avg_loan_amount
FROM banking_db.loan_master
GROUP BY verification_status;

SELECT 
    sub_grade,
    COUNT(*) AS total_loan_applications,
    ROUND(AVG(int_rate), 2) AS avg_interest_rate,
    ROUND(SUM(CASE WHEN loan_status = 'Charged Off' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS sub_grade_default_rate
FROM banking_db.loan_master
WHERE grade = 'G'
GROUP BY sub_grade
ORDER BY sub_grade ASC;

WITH ranked_states AS (
    SELECT 
        grade,
        addr_state,
        COUNT(*) AS total_applications,
        DENSE_RANK() OVER(PARTITION BY grade ORDER BY COUNT(*) DESC) AS state_rank
    FROM banking_db.loan_master
    WHERE grade IS NOT NULL
    GROUP BY grade, addr_state
)
SELECT grade, addr_state, total_applications, state_rank
FROM ranked_states
WHERE state_rank <= 3;

SELECT 
    id AS loan_id,
    grade,
    dti,
    pub_rec AS public_records,
    CASE 
        WHEN dti > 30 AND pub_rec > 0 THEN 'CRITICAL RISK'
        WHEN dti > 30 OR pub_rec > 0 THEN 'MEDIUM RISK'
        ELSE 'LOW RISK'
    END AS borrower_risk_flag
FROM banking_db.loan_master
ORDER BY dti DESC
LIMIT 20;

CREATE OR REPLACE VIEW banking_db.vw_executive_loan_summary AS
SELECT 
    grade,
    COUNT(*) AS total_loans,
    ROUND(SUM(loan_amnt), 2) AS total_funded,
    ROUND(SUM(total_pymnt), 2) AS total_recovered,
    ROUND(AVG(int_rate), 2) AS avg_rate
FROM banking_db.loan_master
GROUP BY grade;

-- To read it later, you just run:
-- SELECT * FROM banking_db.vw_executive_loan_summary;