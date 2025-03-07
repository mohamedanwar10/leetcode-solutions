-- Write your PostgreSQL query statement below
WITH requests AS(
    SELECT s.user_id, CASE WHEN c.action ='confirmed' THEN 1
                           ELSE 0
                           END AS request
    FROM Signups s
    LEFT JOIN Confirmations c
    ON s.user_id=c.user_id                       
)
SELECT user_id, ROUND(SUM(request)*1.0/COUNT(request),2) AS confirmation_rate
FROM requests
GROUP BY user_id
ORDER BY confirmation_rate ASC, user_id DESC;
