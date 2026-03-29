
--Overview analysis

--What is the total number of employees?
SELECT COUNT(Emp_Id) AS total_employees
FROM employee

---What is the number of active employees?
SELECT count(Emp_Id)
FROM employee
WHERE Attrition = 'No'

--What is the number of rated employees?
SELECT COUNT(DISTINCT Emp_Id) AS 'Rated Employees'
FROM Performance_Rating

--What is the average annual salary?
SELECT ROUND(AVG(AnnualSalary), 0) AS avg_salary_whole
FROM Employee

--What is the attrition rate?
SELECT 
   ROUND ( COUNT(CASE WHEN Attrition = 'Yes' THEN 1 END) * 100.0 / COUNT(*),2) AS 'Attrition Rate'
FROM  Employee

--What is the employees headcount by gender?
select Gender ,  COUNT(Emp_Id) AS 'Number of Employees'
from Employee
group by Gender
order by 'Number of Employees' DESC

--What is the count of Employees hired per year?
SELECT 
    YEAR(Hire_Date) AS HireYear,
    COUNT(Emp_Id) AS employee_count
FROM Employee
GROUP BY YEAR(Hire_Date)
ORDER BY HireYear

--What is the count of Employees attirated per year?
SELECT 
    YEAR(CurrentDate) AS Year,
    COUNT(Emp_Id) AS employee_count
FROM Employee
WHERE Attrition ='Yes'
GROUP BY YEAR(CurrentDate)
ORDER BY Year

--What is the number of employees per satisfaction level?
SELECT 
    'Job Satisfaction' AS Category,
    s.Satisfy_Level,
    COUNT(e.Emp_Id) AS employee_count,
    ROUND(100.0 * COUNT(e.Emp_Id) / (SELECT COUNT(Perform_Id) FROM Performance_Rating), 2) AS percentage
FROM Employee e
JOIN Performance_Rating p ON e.Emp_Id = p.Emp_Id
JOIN Satisfied_level s ON p.Job_Satisfy= s.Satisfy_Id
GROUP BY s.Satisfy_Level

UNION ALL

SELECT 
    'Relationship Satisfaction' AS Category,
    s.Satisfy_Level,
    COUNT(e.Emp_Id) AS employee_count,
    ROUND(100.0 * COUNT(e.Emp_Id) / (SELECT COUNT(Perform_Id) FROM Performance_Rating), 2) AS percentage
FROM Employee e
JOIN Performance_Rating p ON e.Emp_Id = p.Emp_Id
JOIN Satisfied_level s ON p.Relationship_satisfy = s.Satisfy_Id
GROUP BY s.Satisfy_Level

UNION ALL

SELECT 
    'Work-Life Balance' AS Category,
    s.Satisfy_level,
    COUNT(e.Emp_Id) AS employee_count,
    ROUND(100.0 * COUNT(e.Emp_Id) / (SELECT COUNT(Perform_Id) FROM Performance_Rating), 2) AS percentage
FROM Employee e
JOIN Performance_Rating p ON e.Emp_Id = p.Emp_Id
JOIN Satisfied_level s ON p.Work_life_balance= s.Satisfy_Id
GROUP BY s.Satisfy_Level

UNION ALL

SELECT 
    'Environment Satisfaction' AS Category,
    s.Satisfy_Level,
    COUNT(e.Emp_Id) AS employee_count,
    ROUND(100.0 * COUNT(e.Emp_Id) / (SELECT COUNT(Perform_Id) FROM Performance_Rating), 2) AS percentage
FROM Employee e
JOIN Performance_Rating p ON e.Emp_Id = p.Emp_Id
JOIN Satisfied_level s ON p.Environment_Satisfy = s.Satisfy_Id
GROUP BY s.Satisfy_Level
ORDER BY Category, s.Satisfy_level


----------------------------------------------------------------------------------------------------------------------------------
--Employee Analysis

--What is the  employee headcount by department?
select Dept as 'Department' ,  COUNT(Emp_Id) AS 'Number of Employees'
from Employee
group by Dept
order by 'Number of Employees' DESC

--What is the employee headcount by jobrole?
select JobRole as 'Job Role' ,  COUNT(Emp_Id) AS 'Number of Employees'
from Employee
group by JobRole
order by 'Number of Employees' DESC

--What are employees headcount by education level?
select Edu_level as 'Education Level' ,  COUNT(Emp_Id) AS 'Number of Employees'
from Employee e join Edu_level edu
on e.Edu_level_id =edu.Edu_id
group by Edu_level
order by 'Number of Employees' DESC

--What is the employees headcount by education field?
select Edu_Field as 'Education Field' ,  COUNT(Emp_Id) AS 'Number of Employees'
from Employee
group by Edu_Field
order by 'Number of Employees' DESC

--What is the headcount of employees by age group?
select Age_Range as 'Age Group' ,  COUNT(Emp_Id) AS 'Number of Employees'
from Employee
group by Age_Range
order by 'Number of Employees' DESC

--What is the headcount of employees by state?
select State ,  COUNT(Emp_Id) AS 'Number of Employees'
from Employee
group by State
order by 'Number of Employees' DESC

--What is the headcount of  employees by  ethincity groups?
select Ethnicity ,  COUNT(Emp_Id) AS 'Number of Employees'
from Employee
group by Ethnicity
order by 'Number of Employees' DESC

--What is the  employees headcount by  marital status?
select MaritalStatus ,  COUNT(Emp_Id) AS 'Number of Employees'
from Employee
group by MaritalStatus
order by 'Number of Employees' DESC

--What is the  employees  headcount by distance from home?
select DistanceLevel ,  COUNT(Emp_Id) AS 'Number of Employees'
from Employee
group by DistanceLevel
order by 'Number of Employees' DESC

-------------------------------------------------------------------------------------------------------------------------------

--Salary Analysis

--Are there demographic factors influencing salary?
SELECT
    Gender,
    ROUND(AVG(AnnualSalary), 2) AS AvgAnnualSalary

FROM Employee
GROUP BY
    Gender
ORDER BY
    AvgAnnualSalary DESC

-- How does education level impact salary?
SELECT
    Edu_level,
    ROUND(AVG(AnnualSalary), 2) AS AvgAnnualSalary,
    COUNT(*) AS EmployeeCount
FROM Employee e JOIN Edu_level edu
ON e.Edu_level_id=edu.Edu_id
GROUP BY
 Edu_level
ORDER BY
 AvgAnnualSalary DESC

 --What is the average salary for each age group?
SELECT [Age_Range],
    ROUND(AVG(AnnualSalary), 2) AS AvgAnnualSalary,
    COUNT(*) AS EmployeeCount
FROM Employee
GROUP BY
    Age_Range
ORDER BY
    Age_Range

-- What is the relationship between manager rating and salary, and how strong is the correlation?
SELECT Manager_Rating,
    ROUND(AVG(AnnualSalary), 2) AS AvgAnnualSalary,
    COUNT(*) AS EmployeeCount
FROM Employee e JOIN Performance_Rating pr
ON  e.Emp_Id = pr.Emp_Id
GROUP BY
    Manager_Rating
ORDER BY
    Manager_Rating

--Is there a link between salary and distance from home?
SELECT  DistanceLevel AS DistanceKM,
    ROUND(AVG(AnnualSalary), 2) AS AvgAnnualSalary,
    COUNT(*) AS EmployeeCount
FROM Employee
GROUP BY
    DistanceLevel
ORDER BY
    DistanceLevel

-- What is the highest job in the company?
SELECT  JobRole,
    ROUND(AVG(AnnualSalary), 2) AS AvgAnnualSalary,
    COUNT(*) AS EmployeeCount
FROM Employee
GROUP BY
    JobRole
ORDER BY
    AvgAnnualSalary DESC


--What is the effect of years of experience on salary?
SELECT Years_At_Company,
    ROUND(AVG(AnnualSalary), 2) AS AvgAnnualSalary,
    COUNT(*) AS EmployeeCount
FROM Employee
GROUP BY
    Years_At_Company
ORDER BY
    Years_At_Company

--What is the effect of salary on the last promotion?
SELECT Years_Since_Last_Promotion,
    ROUND(AVG(AnnualSalary), 2) AS AvgAnnualSalary,
    COUNT(*) AS EmployeeCount
FROM Employee
GROUP BY
    Years_Since_Last_Promotion
ORDER BY
    Years_Since_Last_Promotion

--What is Salaries for regions?
SELECT State,
    ROUND(AVG(AnnualSalary), 2) AS AvgAnnualSalary,
    SUM(AnnualSalary) AS TotalAnnualSalary,
    COUNT(*) AS EmployeeCount
FROM Employee
GROUP BY
    State
ORDER BY
    AvgAnnualSalary DESC

--What is the impact of Job Satisfaction on salary?
SELECT Job_Satisfy,
    ROUND(AVG(AnnualSalary), 2) AS AvgAnnualSalary,
    COUNT(*) AS EmployeeCount
FROM Employee e JOIN Performance_Rating pr
ON  e.Emp_Id=pr.Emp_Id
GROUP BY
    Job_Satisfy
ORDER BY
    Job_Satisfy

--How does ethnicity affect salary?
SELECT Ethnicity,
    ROUND(AVG(AnnualSalary), 2) AS AvgAnnualSalary,
    COUNT(*) AS EmployeeCount
FROM Employee
GROUP BY
    Ethnicity
ORDER BY
    AvgAnnualSalary DESC

----------------------------------------------------------------------------------------
--Overtime Analysis

--What is the overtime percentage for every job role?
SELECT 
    JobRole,
    SUM(CASE WHEN over_time = 'Yes' THEN 1 ELSE 0 END) AS OvertimeEmployees,
    CAST(SUM(CASE WHEN over_time = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS DECIMAL(5,2)) AS OvertimePercentage
FROM Employee
GROUP BY JobRole
ORDER BY OvertimePercentage DESC

--What is the percentage of overtime for every business travel?
SELECT 
    Business_Travel,
    SUM(CASE WHEN over_time = 'Yes' THEN 1 ELSE 0 END) AS OvertimeEmployees,
    CAST(SUM(CASE WHEN over_time = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS DECIMAL(5,2)) AS OvertimePercentage
FROM Employee
GROUP BY Business_Travel
ORDER BY OvertimePercentage DESC

--------------------------------------------------------------------------------------------------------------------------------

--Performance Analysis

--What is the performance for every job role?
SELECT 
    e.JobRole,
    rl.Rating_level,
    COUNT(*) AS RatingCount,
    CAST(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (PARTITION BY e.JobRole) AS DECIMAL(5,2)) AS RatingPercentage
FROM Employee e
JOIN Performance_Rating p 
    ON e.Emp_Id = p.Emp_Id
JOIN Rating_level rl 
    ON p.Manager_Rating = rl.Rating_id
GROUP BY e.JobRole, rl.Rating_level
ORDER BY e.JobRole, RatingPercentage DESC


--What is the count and percentage of training taken and the count of training opportunities for every job role?
SELECT 
    e.JobRole,
    SUM(p.Training_opport_taken) AS TrainingTakenCount,
    SUM(p.Training_opport_by_year) AS TrainingOpportunitiesCount,
    CAST(
        SUM(p.Training_opport_taken) * 100.0 / NULLIF(SUM(p.Training_opport_by_year), 0) 
        AS DECIMAL(5,2)
    ) AS TrainingTakenPercentage
FROM Employee e
JOIN Performance_Rating p 
    ON e.Emp_Id = p.Emp_Id
GROUP BY e.JobRole
ORDER BY TrainingTakenPercentage DESC


---------------------------------------------------------------------------------------------------------------------------

--Attrition Analysis

--What is the total number of employees who left the company
SELECT 
   COUNT(CASE WHEN Attrition = 'Yes' THEN 1 END)  AS 'Attrition Rate'
FROM  Employee

--What is the attrition rate?
SELECT 
   ROUND ( COUNT(CASE WHEN Attrition = 'Yes' THEN 1 END) * 100.0 / COUNT(*),2) AS 'Attrition Rate'
FROM  Employee

--Which is the attrition rate by department?
SELECT Dept AS 'Department',ROUND(COUNT(CASE WHEN Attrition = 'Yes' THEN 1 END) * 100.0 / COUNT(*),2) AS 'Attriton rate by Department'
FROM 
    Employee
GROUP BY 
    Dept

--Which is the attrition rate by job role?
SELECT JobRole AS 'Job Role',ROUND(COUNT(CASE WHEN Attrition = 'Yes' THEN 1 END) * 100.0 / COUNT(*),2) AS 'Attriton rate by Job Role'
FROM 
    Employee
GROUP BY 
   JobRole
ORDER BY 'Attriton rate by Job Role' DESC

--What is the attritoon rate by salary level?
SELECT SalaryLevel AS 'Salary Level',ROUND(COUNT(CASE WHEN Attrition = 'Yes' THEN 1 END) * 100.0 / COUNT(*),2) AS 'Attriton rate by Salary Level'
FROM 
    Employee
GROUP BY 
   Salarylevel

--Does Overtime impact attrition?
SELECT over_time AS 'Over time',ROUND(COUNT(CASE WHEN Attrition = 'Yes' THEN 1 END) * 100.0 / COUNT(*),2) AS 'Attriton rate by Overtime'
FROM 
    Employee
GROUP BY 
   over_time

--Does business travel impact attrition?
SELECT Business_Travel AS 'Business Travel',ROUND(COUNT(CASE WHEN Attrition = 'Yes' THEN 1 END) * 100.0 / COUNT(*),2) AS 'Attriton rate by Business Travel'
FROM 
    Employee
GROUP BY 
   Business_Travel

--Which State has the hoghest attriton rate?
SELECT State ,ROUND(COUNT(CASE WHEN Attrition = 'Yes' THEN 1 END) * 100.0 / COUNT(*),2) AS 'Attriton rate by State'
FROM 
    Employee
GROUP BY 
   State
ORDER BY 
   'Attriton rate by State' DESC

--Which ethnicity group have the highest attrition rate?
SELECT 
    Ethnicity,
    ROUND(COUNT(CASE WHEN Attrition = 'Yes' THEN 1 END) * 100.0 / COUNT(*), 2) AS 'Attrition Rate by ehtnicity'
FROM 
    Employee
GROUP BY 
    Ethnicity
ORDER BY 
    'Attrition Rate by ehtnicity' DESC

--Which gender has the highest attrition rate?
SELECT 
    Gender,
    ROUND(COUNT(CASE WHEN Attrition = 'Yes' THEN 1 END) * 100.0 / COUNT(*), 2) AS 'Attrition Rate by Gender'
FROM 
    Employee
GROUP BY 
    Gender
ORDER BY 
    'Attrition Rate by Gender' DESC

--Which age group has the highest attrition rate?
SELECT 
    Age_Range as 'Age Group',
    ROUND(COUNT(CASE WHEN Attrition = 'Yes' THEN 1 END) * 100.0 / COUNT(*), 2) AS 'Attrition Rate by Age Group'
FROM 
    Employee
GROUP BY 
    Age_Range
ORDER BY 
    'Attrition Rate by Age Group' DESC

--Which marital status has the highest attrition rate?
SELECT 
    MaritalStatus as 'Marital Status',
    ROUND(COUNT(CASE WHEN Attrition = 'Yes' THEN 1 END) * 100.0 / COUNT(*), 2) AS 'Attrition Rate by Marital Status'
FROM 
    Employee
GROUP BY 
    MaritalStatus
ORDER BY 
    'Attrition Rate by Marital Status' DESC

--Which education level has the highest attrition rate?
SELECT 
    Edu_level  as 'Education level',
    ROUND(COUNT(CASE WHEN Attrition = 'Yes' THEN 1 END) * 100.0 / COUNT(*), 2) AS 'Attrition Rate by Education level'
FROM Employee e JOIN Edu_level edu
ON e.Edu_level_id = edu.Edu_id
GROUP BY 
     Edu_level
ORDER BY 
    'Attrition Rate by Education level' DESC

--Does distance from home impact attrition?
SELECT 
    DistanceLevel as 'Distance Level',
    ROUND(COUNT(CASE WHEN Attrition = 'Yes' THEN 1 END) * 100.0 / COUNT(*), 2) AS 'Attrition Rate by Distance Level'
FROM 
    Employee
GROUP BY 
     DistanceLevel
ORDER BY 
    'Attrition Rate by Distance Level' DESC

--Does years at company relate to attrition?
SELECT 
    Years_At_Company as 'Years at Company',
    ROUND(COUNT(CASE WHEN Attrition = 'Yes' THEN 1 END) * 100.0 / COUNT(*), 2) AS 'Attrition Rate by years at Company'
FROM 
    Employee
GROUP BY 
     Years_At_Company
ORDER BY 
    'Attrition Rate by years at Company' DESC

--Which Year have the highest attrition rate?
SELECT 
    YEAR(Hire_Date) AS Year,
    ROUND(COUNT(CASE WHEN Attrition = 'Yes' THEN 1 END) * 100.0 / COUNT(*), 2) AS 'Attrition Rate by Year'
FROM 
    Employee
GROUP BY 
    YEAR(Hire_Date)
ORDER BY 
    'Attrition Rate by Year' DESC

-------------------------------------------------------------------------------------------------------------------------------------