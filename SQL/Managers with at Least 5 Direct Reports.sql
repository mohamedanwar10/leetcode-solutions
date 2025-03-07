-- Write your PostgreSQL query statement below
--First solution 
SELECT e.name
FROM employee e JOIN employee em
ON e.id=em.managerId
GROUP BY e.name,em.managerID
-HAVING COUNT(em.managerId) >=5


--Sconed solution
WITH valid_managers AS(
    SELECT managerID AS id, COUNT(managerID) AS total_reports
    FROM employee
    GROUP BY managerID
    HAVING COUNT(managerID) >= 5
)
SELECT e.name
FROM employee e, valid_managers v
WHERE e.id=v.id
