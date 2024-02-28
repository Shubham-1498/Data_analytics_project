CREATE DATABASE HR_Project;
USE HR_Project; 

SHOW TABLES ;
SELECT * FROM `human resources`;

                             -- Data Cleaning and Preprocessing--
                             
-- Changed table name human resources to human_resources-- 
ALTER TABLE `human resources` RENAME TO human_resources;

SELECT * FROM human_resources;

-- Changed Column name to  ï»¿id to emp_id
ALTER TABLE human_resources
CHANGE COLUMN  ï»¿id emp_id VARCHAR(20) NULL;

-- Cheked metadata
DESCRIBE human_resources;

-- Used sql_safe_updates  to make changes in table without where clause
SET sql_safe_updates = 0;

-- Updated data format and datatype of birthdate  column 
UPDATE human_resources
SET birthdate = CASE
		WHEN birthdate LIKE '%/%' THEN date_format(str_to_date(birthdate,'%m/%d/%Y'),'%Y-%m-%d')
        WHEN birthdate LIKE '%-%' THEN date_format(str_to_date(birthdate,'%m-%d-%Y'),'%Y-%m-%d')
        ELSE NULL
		END;

ALTER TABLE human_resources
MODIFY COLUMN birthdate DATE;

SELECT * FROM human_resources; 

-- updated  data format and datatype of hire_date column

UPDATE human_resources
SET hire_date = CASE
		WHEN hire_date LIKE '%/%' THEN date_format(str_to_date(hire_date,'%m/%d/%Y'),'%Y-%m-%d')
        WHEN hire_date LIKE '%-%' THEN date_format(str_to_date(hire_date,'%m-%d-%Y'),'%Y-%m-%d')
        ELSE NULL
		END;
        
ALTER TABLE human_resources
MODIFY COLUMN hire_date DATE;

SELECT * FROM human_resources; 



-- Updated the date format and datatpye of termdate column
UPDATE human_resources
SET termdate = date(str_to_date(termdate, '%Y-%m-%d %H:%i:%s UTC'))
WHERE termdate IS NOT NULL AND termdate !='';

UPDATE human_resources
SET termdate = NULL
WHERE termdate = '';

SELECT * FROM human_resources; 




-- created age column
ALTER TABLE human_resources
ADD column age INT;

-- Calculated age 
UPDATE human_resources
SET age = timestampdiff(YEAR,birthdate,curdate());




-- 1. Write a query to display the names (first_name, last_name) using alias name “First Name", "Last Name" 
SELECT first_name AS First_name, last_name as Last_Name FROM human_resources;


-- 2. Write a query to display the full name of human_resources 

SELECT CONCAT(first_name, ' ', last_name) AS Full_name FROM human_resources;

-- 3.  Write a query to get the number of employees working with the company 
SELECT COUNT(*) FROM human_resources
WHERE termdate IS NULL;

-- 4.  Write a query to get unique department  from human_resources table 

SELECT DISTINCT department FROM human_resources;

-- 5. Write a query to get count of department  from human_resources table 
SELECT COUNT(DISTINCT department) FROM human_resources;

-- 6. Write a query count unique gender appeareances  from human_resources table
SELECT gender, COUNT(*) AS Count FROM human_resources
WHERE termdate IS NULL
GROUP BY gender;

-- 7. Write a query to no. of employee working at remote location from human_resources
SELECT COUNT( emp_id) AS Remote_employees FROM human_resources
WHERE termdate IS NULL AND location LIKE "Remote" ;

-- 8. Write a query to get the number of employees according to job title in descending oder from the human_resources table 
SELECT jobtitle, COUNT(emp_id) AS num_employees_by_job_title
FROM human_resources
WHERE termdate IS NULL
GROUP BY jobtitle
ORDER BY num_employees_by_job_title DESC ;

-- 9.  Write a query get all first name from human_resources table in upper case
 SELECT upper(first_name) AS FIRST_NAME FROM human_resources;

-- 10 Write a query to get the first 3 characters of first_name from human_resources table 
SELECT left(first_name,3) AS first_3_char FROM human_resources;

SELECT substring(first_name,1,3) AS first_3_char FROM human_resources;

SELECT mid(first_name,1,3) AS first_3_char FROM human_resources;

-- 11. Write a query to get first name from human_resources table after removing white spaces from both side 

SELECT TRIM(first_name) FROM human_resources;

-- 12. Write a query to get the length of the employee names (first_name, last_name) from human_resources table 

SELECT first_name, last_name, LENGTH(first_name)+LENGTH(last_name)  AS Total_length FROM human_resources;

-- 13.  Write a query to find  the distribution of employees across location_state

SELECT location_state, COUNT(*) AS count
FROM human_resources
WHERE termdate IS NULL
GROUP BY location_state;


-- 14.  write a query to find min and maximum age of employees

SELECT min(age), max(age) FROM human_resources; 

-- 15. write a query to find the age distribution of employees in the company
SELECT 
	CASE
		WHEN age>=18 AND age<=24 THEN '18-24'
        WHEN age>=25 AND age<=34 THEN '25-34'
        WHEN age>=35 AND age<=44 THEN '35-44'
        WHEN age>=45 AND age<=54 THEN '45-54'
        WHEN age>=55 AND age<=64 THEN '55-64'
        ELSE '65+'
	END AS age_group,
    COUNT(*) AS count
    FROM human_resources
    WHERE termdate IS NULL
    GROUP BY age_group
    ORDER BY age_group;
    
-- 16. How many employees work at HQ vs remote
SELECT location,COUNT(*) AS count
FROm human_resources
WHERE termdate IS NULL
GROUP BY location;

-- 17.  What is the race breakdown of employees in the company
SELECT race , COUNT(*) AS count
FROM human_resources
WHERE termdate IS NULL
GROUP BY race;

-- 18. how many employee left the company 
SELECT COUNT(*)  AS employees_left FROM human_resources
WHERE termdate IS  NOT NULL ;


-- 19 Write a query to display the last name of human_resources table having 'e' as the third character 

SELECT last_name FROM human_resources WHERE  last_name LIKE '__e%';

-- 20  Write a query to display the last name of human_resources whose names have exactly 6 characters

SELECT last_name FROM human_resources WHERE last_name LIKE '______';

-- 21 Write a query to display the first_name of all employees who have both "b" and "c" in their first name 

SELECT first_name FROM human_resources WHERE first_name LIKE '%b%' AND first_name LIKE '%c%';

-- 22 write a query to  find info of employees born between 1996 to 2010

SELECT *  FROM human_resources
WHERE birthdate BETWEEN '1996-01-01' AND '2010-12-31';

SELECT * FROM human_resources
WHERE YEAR(birthdate) BETWEEN 1996 AND 2010;



--  23 write a query to find distubution of employees state wise 
SELECT location_state, COUNT(emp_id) AS num_employees
FROM human_resources
WHERE termdate IS NULL 
GROUP BY location_state;

-- 24 write a query to find top 10 cities with highest no. of employees 
SELECT* FROM human_resources ;
SELECT location_city, COUNT(emp_id) AS num_employees
FROM human_resources
WHERE termdate IS NULL 
GROUP BY location_city
ORDER BY num_employees DESC
LIMIT 10;

-- 25 write a query to find employees higher between 2001 and 2010
SELECT Count(*) AS employees_hired_between2001_2010 FROM human_resources
WHERE YEAR(hire_date) BETWEEN 2001 AND 2010;


