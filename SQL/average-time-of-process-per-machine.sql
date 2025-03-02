-- LeetCode Problem: Average Time of Process per Machine
-- Link: https://leetcode.com/problems/average-time-of-process-per-machine/?envType=study-plan-v2&envId=top-sql-50

WITH previous AS (
    SELECT a.*, 
           COALESCE(LAG(a.timestamp,1) OVER (PARTITION BY machine_id, process_id ORDER BY timestamp), 0) AS last_time,
           COALESCE(LAG(a.activity_type,1) OVER (PARTITION BY machine_id, process_id ORDER BY timestamp), 'start') AS last_type
    FROM Activity a
),
difference AS (
    SELECT p.*, 
           CASE 
               WHEN p.activity_type = 'end' AND p.last_type = 'start'
               THEN p.timestamp - p.last_time
               ELSE 0
           END AS difference_col
    FROM previous p
)
SELECT machine_id, ROUND(AVG(difference_col), 3) AS processing_time
FROM difference
WHERE difference_col <> 0
GROUP BY machine_id;
