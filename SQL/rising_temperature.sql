-- Solution for LeetCode: Rising Temperature
SELECT w.id
FROM Weather w
JOIN Weather ww
ON ww.recordDate + INTERVAL 1 day = w.recordDate
WHERE w.temperature > ww.temperature;
