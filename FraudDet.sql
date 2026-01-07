1. Fraud Count & Ratio

SELECT class, COUNT(*) AS total, 
       ROUND(100.0*COUNT(*)/SUM(COUNT(*)) OVER(), 2) AS percentage
FROM creditcard c 
GROUP BY class;


2. High-Amount Fraudulent Transactions

SELECT *
FROM creditcard c 
WHERE class = 1
ORDER BY amount DESC
LIMIT 10;

3. Average Transaction Amount by Class

SELECT class, AVG(amount) AS avg_amount
FROM creditcard c 
GROUP BY class;

4. Transaction Trend Over Time

SELECT time, COUNT(*) AS total_transactions,
       SUM(class) AS total_frauds
FROM creditcard c 
GROUP BY time
ORDER BY time;

5. Top 5 Suspicious Features (v-columns) in Fraud

SELECT 
    v1, v2, v3, v4, v5,
    SUM(class) AS fraud_count
FROM creditcard c 
GROUP BY v1, v2, v3, v4, v5
ORDER BY fraud_count DESC
LIMIT 5;

6. Fraud Percentage by v1

SELECT v1,
       ROUND(100.0*SUM(class)/COUNT(*), 2) AS fraud_percentage
FROM creditcard c 
GROUP BY v1
ORDER BY fraud_percentage DESC
LIMIT 10;

7. Largest Fraud Amount Difference from Previous Transaction

SELECT time, amount, class,
       amount - LAG(amount) OVER (ORDER BY time) AS diff_from_prev
FROM creditcard c 
WHERE class = 1
ORDER BY diff_from_prev DESC
LIMIT 10;

8. Top 10 Normal Transactions with Highest v5

SELECT *
FROM creditcard c 
WHERE class = 0
ORDER BY v5 DESC
LIMIT 10;

9. Fraud Rank by Amount

SELECT *, RANK() OVER (ORDER BY amount DESC) AS fraud_rank
FROM creditcard c 
WHERE class = 1
ORDER BY fraud_rank
LIMIT 10;

10. Average Amount for Fraud vs Non-Fraud Over Time

SELECT time,
       AVG(CASE WHEN class=0 THEN amount END) AS avg_normal,
       AVG(CASE WHEN class=1 THEN amount END) AS avg_fraud
FROM creditcard c 
GROUP BY time
ORDER BY time;



