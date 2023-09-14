SELECT * FROM dbo.IBM_HR;
SELECT COUNT(IBM_HR.EmployeeNumber) AS num_employees
FROM IBM_HR;

-- There are 1,470 employees included in this dataset
-- In this project I will identify and analyze key differences in qualities from employees who are still at IBM and employees who were terminated
SELECT AVG(HourlyRate) as avg_salary_per_hour
FROM IBM_HR;

-- The average hourly salary is $65


WITH terminated AS (SELECT Attrition, Department, Education, EducationField, Gender, HourlyRate, JobInvolvement, JobLevel, JobRole, PerformanceRating, YearsAtCompany FROM IBM_HR
WHERE CAST(Attrition AS varchar(max)) = 'Yes')

SELECT COUNT(JobLevel) FROM terminated;

WITH active AS (SELECT Attrition, Department, Education, EducationField, Gender, HourlyRate, JobInvolvement, JobLevel, JobRole, PerformanceRating, YearsAtCompany FROM IBM_HR
WHERE CAST(Attrition AS varchar(max)) = 'No'
)

SELECT COUNT(JobLevel) FROM active;

-- The following query will tell us the percentage of employees who were terminated

WITH total_num AS (
    SELECT COUNT(JobLevel) as total_count FROM IBM_HR
),
terminated_num AS (
    SELECT COUNT(JobLevel) as terminated_count FROM IBM_HR
    WHERE CAST(Attrition AS varchar(max)) = 'Yes'
)
SELECT CAST(terminated_count AS decimal) / CAST(total_count AS decimal) as termination_rate FROM terminated_num, total_num;

-- 16.1 % were laid off

-- The following query gets the average years at company for terminated, active groups
SELECT AVG(YearsAtCompany) as average_yrs_at_company, CAST(Attrition AS varchar(max)) as terminated
FROM IBM_HR
GROUP BY CAST(Attrition AS varchar(max));

SELECT Attrition, Department, Education, EducationField, Gender, HourlyRate, JobInvolvement, JobLevel, JobRole, PerformanceRating, YearsAtCompany 
FROM IBM_HR;