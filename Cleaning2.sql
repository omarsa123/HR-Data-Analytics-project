--Checking values format,missing values and duplicates in Employee Table
exec sp_rename 'Edu_level.Edu_id' , 'Edu_Id' , 'Column'
exec sp_rename 'Edu_level.Edu_level' , 'Edu_Level' , 'Column'
exec sp_rename 'Edu_level' , 'Edu_Level'
exec sp_rename 'Satisfied_level.Satisfy_id' , 'Satisfy_Id' , 'Column'
exec sp_rename 'Satisfied_level.Satisfy_level' , 'Satisfy_Level' , 'Column'
exec sp_rename 'Satisfied_level' , 'Satisfied_Level'
exec sp_rename 'PerformanceRating.Review_date' , 'Review_Date' , 'Column'
exec sp_rename 'PerformanceRating.Relationship_satisfy' , 'Relationship_Satisfy' , 'Column'
exec sp_rename 'PerformanceRating.Training_opport_by_year' , 'Training_Opport_By_Year' , 'Column'
exec sp_rename 'PerformanceRating.Training_opport_taken' , 'Training_Opport_Taken' , 'Column'
exec sp_rename 'PerformanceRating.Work_life_balance' , 'Work_Life_Balance' , 'Column'
exec sp_rename 'PerformanceRating' , 'Performance_Rating'
exec sp_rename 'Employee.FullName' , 'Full_Name','Column'
exec sp_rename 'Employee.Edu_level_id' , 'Edu_Level_Id','Column'
exec sp_rename 'Employee.JobRole' , 'Jop_Role','Column'
exec sp_rename 'Employee.MaritalStatus' , 'Marital_Status','Column'
exec sp_rename 'Employee.StockOptionLevel' , 'Stock_Option_Level','Column'
exec sp_rename 'Employee.over_time' , 'over_Time','Column'
exec sp_rename 'Employee.Salary' , 'AnnualSalary','Column'
select distinct(Gender)
from Employee
select distinct(Business_Travel)
from Employee
select distinct(Dept)
from Employee
select distinct(State)
from Employee
select distinct(Ethnicity)
from Employee
select distinct(Edu_Field)
from Employee
select distinct(JobRole)
from Employee
select distinct(MaritalStatus)
from Employee
select distinct(over_time)
from Employee
select distinct(Hire_Date)
from Employee
select distinct(Attrition)
from Employee

SELECT Distinct(COUNT(*)) AS DuplicateCount
FROM Employee
group by Emp_Id

select count(*)
from Employee
where Gender is null

select count(*)
from Employee
where Age is null

select count(*)
from Employee
where Business_Travel is null

select count(*)
from Employee
where Dept is null

select count(*)
from Employee
where Distance is null

select count(*)
from Employee
where state is null

select count(*)
from Employee
where Ethnicity is null

select count(*)
from Employee
where Edu_Field is null

select count(*)
from Employee
where MaritalStatus is null

select count(*)
from Employee
where over_time is null

select count(*)
from Employee
where Hire_Date is null

select count(*)
from Employee
where Attrition is null

select count(*)
from Employee
where Years_At_Company is null

select count(*)
from Employee
where Years_In_Most_RecentRole is null

select count(*)
from Employee
where Years_Since_Last_Promotion is null

select count(*)
from Employee
where Years_With_Curr_Manager is null

select count(*)
from Employee
where Age_Range is null
--I have checked the format of the values, missing values, and duplicates, and did not find any problems


--checking for duplicates in performance  table
SELECT Perform_Id, COUNT(*) AS duplicate_count
FROM Performance_Rating
GROUP BY Perform_Id
HAVING COUNT(*) > 1

--checking for nulls in performance table 
select count(*) as nulls_count
from Performance_Rating
where Perform_Id is null

select count(*) as nulls_count
from Performance_Rating
where Emp_Id is null

select count(*) as nulls_count
from Performance_Rating
where Review_date is null

select count(*) as nulls_count
from Performance_Rating
where Environment_Satisfy is null

select count(*) as nulls_count
from Performance_Rating
where Relationship_satisfy is null


select count(*) as nulls_count
from Performance_Rating
where Training_Opport_By_Year is null

select count(*) as nulls_count
from Performance_Rating
where Training_Opport_Taken is null

select count(*) as nulls_count
from Performance_Rating
where Work_Life_Balance is null

select count(*) as nulls_count
from Performance_Rating
where Manager_Rating is null

update Employee
set JobRole = 'Sales Manager'
where Dept = 'Sales' and JobRole = 'Manager'

update Employee
set Dept = 'Sales'
where JobRole = 'Sales Executive'

--Update The values Of State
update Employee
set state = 'California'
where state = 'CA'
update Employee
set state = 'New York'
where state = 'NY'
update Employee
set state = 'Illinois'
where state = 'IL'

update Employee
set Edu_Field = trim (Edu_Field)

update Employee
set AnnualSalary = 115895
where Emp_Id = 'AFC3-E23F'
update Employee
set AnnualSalary = 142075
where Emp_Id = '372C-E204'
update Employee
set AnnualSalary = 89527
where Emp_Id = '801E-9D0E'
update Employee
set AnnualSalary = 63482
where Emp_Id = '5E73-CE19'
select *
from Employee 
delete p
from Performance_Rating as p
join Employee e 
on p.Emp_Id = e.Emp_Id
where (p.Review_Date >= e.CurrentDate and e.Attrition = 'Yes') or (p.Review_Date <= e.Hire_Date)

Select count (*)
from Performance_Rating

--Add a new column called salary level
ALTER TABLE Employee ADD SalaryLevel VARCHAR(20)

--Insert the values in the column 
UPDATE Employee
SET SalaryLevel = CASE 
    WHEN AnnualSalary <= 50000 THEN 'Very Low'
    WHEN AnnualSalary <= 120000 THEN 'Low'
    WHEN AnnualSalary <= 250000 THEN 'Medium'
    WHEN AnnualSalary <= 400000 THEN 'High'
    ELSE 'Very High'
END

--Add a new column called distance level
ALTER TABLE Employee ADD DistanceLevel VARCHAR(20)
--Insert the values in the column
UPDATE Employee
SET DistanceLevel = CASE
    WHEN Distance <= 15 THEN 'Near'
    WHEN Distance <= 25 THEN 'Moderate'
    ELSE 'Far'
END

--Update the values in age range column 
UPDATE Employee
SET Age_Range = CASE 
    WHEN Age >= 18 AND Age <= 30 THEN '18-30'
    WHEN Age >= 31 AND Age <= 40 THEN '31-40'
    WHEN Age >= 41 AND Age <= 50 THEN '41-50'
	 WHEN Age >= 51 AND Age <= 55 THEN 'Above 50'
END




