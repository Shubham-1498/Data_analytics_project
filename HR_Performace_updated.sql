SHOW DATABASES;
USE hr_performance;
SHOW TABLES ;

SELECT * FROM employee;



-- Q1.  select all employees who left organization 
 SELECT * FROM employee
 WHERE Attrition LIKE 'Yes';
 
-- Q2 How many employees are currently working in company?
SELECT  COUNT(*)  AS Actively_working FROM employee
WHERE Attrition LIKE 'NO';


-- Q3.  What is a average daily rate of employee who frequently travel for business ?
 SELECT AVG(DailyRate) AS Average_daily_rate FROM employee
 WHERE BusinessTravel LIKE  'Travel_Frequently';
 
 
 -- Q4.  How many employees are satisfied with their job involvement?
  SELECT JobInvolvement, COUNT(EmployeeCount) AS Job_Satisfaction FROM employee
  GROUP BY JobInvolvement;
  
  
SELECT COUNT(*) AS JobInvolvement FROM employee
WHERE JobInvolvement >(SELECT AVG(JobInvolvement) FROM employee);


  
    WITH EmployeeSatisfaction AS (SELECT 
    CASE WHEN JobInvolvement >= 3 THEN 'Satisfied' 
		WHEN JobInvolvement <= 2 THEN 'Not Satisfied'
		ELSE 'Unknown' 
        END AS Satisfaction_status
    FROM employee)

SELECT Satisfaction_status,COUNT(*) AS Emp_count
FROM EmployeeSatisfaction
GROUP BY Satisfaction_status;



-- Q6. What is overall performance rating departmentwise for employees currently working in organization?
SELECT AVG(PerformanceRating) AS Avg_performace_rating, Department FROM employee
WHERE Attrition LIKE 'NO'
GROUP BY Department;


