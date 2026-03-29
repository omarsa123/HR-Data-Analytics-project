--Create Database
create database HRAnalysis

--Create table Education Level
create table Edu_level(
	Edu_id int not null ,
	Edu_level varchar(50),
	constraint pk_Eduid primary key(Edu_Id)
)

--Create table Employee
create table Employee(
	Emp_Id varchar(20) not null,
	FullName varchar(100),
	Gender varchar(20),
	Age int,
	Business_Travel varchar(25),
	Dept varchar(30) ,
	Distance int ,
	State varchar(30) ,
	Ethnicity varchar(50),
	Edu_level_id int not null,
	Edu_Field varchar(50),
	JobRole varchar(50) not null,
	MaritalStatus varchar(50) ,
	Salary float not null,
	over_time varchar(5),
	Hire_Date date ,
	Attrition varchar(5),
	Years_At_Company int ,
	Years_In_Most_RecentRole int ,
	Years_Since_Last_Promotion int ,
	Years_With_Curr_Manager int,
	constraint pk_Empid primary key(Emp_Id),
	constraint fk_Edulevid foreign key (Edu_Level_Id) references Edu_level (Edu_Id)
)
-- Create table Satisfaction level
create table Satisfied_level(
	Satisfy_id int not null ,
	Satisfy_level varchar(50),
	constraint pk_Satisfy_id primary key(Satisfy_Id)
)
-- Create table Rating level
create table Rating_level(
	Rating_id int not null ,
	Rating_level varchar(50),
	constraint pk_rating_id primary key(Rating_Id)
)
--Create table Performance and it's primary key constraint
create table Performance_Rating(
   Perform_Id varchar(25) not null,
   Emp_Id varchar(20),
   Review_date date,
   Environment_Satisfy int,
   Job_Satisfy int,
   Relationship_satisfy int,
   Training_opport_by_year int,
   Training_opport_taken int,
   Work_life_balance int,
   Self_Rating int,
   Manager_Rating int,
   constraint pk_perform_id primary key(Perform_Id)
)
--Adding foreign key constraints to PerformanceRating Table
 alter table Performance_Rating
 add constraint fk_emp_id foreign key (Emp_Id) references Employee(Emp_Id)

 alter table Performance_Rating
 add constraint fk_environ_sat foreign key (Environment_Satisfy) references Satisfied_level(Satisfy_Id)

 alter table Performance_Rating
 add constraint fk_job_sat foreign key (Job_Satisfy) references Satisfied_level(Satisfy_Id)

 alter table Performance_Rating
 add constraint fk_relation_sat foreign key (Relationship_Satisfy) references Satisfied_level(Satisfy_Id)

 
 alter table Performance_Rating
 add constraint fk_worklife_sat foreign key (Work_Life_Balance) references Satisfied_level(Satisfy_Id)

 
 alter table Performance_Rating
 add constraint fk_manager_rat foreign key (Manager_Rating) references Rating_level(Rating_Id)

----------------------------------------------------------------------------------------------
--Inserting values in Education level table  
bulk insert Edu_level
from 'C:\Users\user\Desktop\Data Analysis\Datasets\HR\EducationLevel.csv'
with(
	format = 'csv',
	firstrow = 2,
	FIELDTERMINATOR = ',',
	ROWTERMINATOR = '\n'
)
--Inserting values in Employee table 

bulk insert Employee
from 'C:\Users\user\Desktop\Data Analysis\HR Analysis\HR\Employee -without removing name.csv'
with(
	format = 'CSV',
	firstrow = 2,
	FIELDTERMINATOR = ',',
	ROWTERMINATOR = '\n'
)

--Inserting values in Satisfaction level
bulk insert Satisfied_level
from 'C:\Users\user\Desktop\Data Analysis\Datasets\HR\SatisfiedLevel.csv'
with(
	format = 'csv',
	firstrow = 2,
	FIELDTERMINATOR = ',',
	ROWTERMINATOR = '\n'
)

--Inserting values in Rating level
bulk insert Rating_level
from 'C:\Users\user\Desktop\Data Analysis\Datasets\HR\RatingLevel.csv'
with(
	format = 'csv',
	firstrow = 2,
	FIELDTERMINATOR = ',',
	ROWTERMINATOR = '\n'
)

--Inserting values in Performance Rating
bulk insert Performance_Rating
from 'C:\Users\user\Desktop\Data Analysis\Datasets\HR\PerformanceRating.csv'
with(
	format = 'csv',
	firstrow = 2,
	FIELDTERMINATOR = ',',
	ROWTERMINATOR = '\n'
)

select * from Employee
select * from Edu_level
select * from Satisfied_level
select * from Rating_level
select * from Performance_Rating
--All tables have been created and data has been inserted successfully

--Add a new column to the Employee table that contains age categories
alter table Employee
add Age_Range varchar(25)


Alter Table Employee
drop column Stock_Option_Level

alter table Employee
add CurrentDate date 

update Employee
set CurrentDate = Dateadd (year , Years_At_Company ,Hire_Date )
