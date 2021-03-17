-----------
--연습문제
-----------
--01
SELECT first_name || ' ' || last_name 이름,
    salary 월급,
    phone_number 전화번호,
    hire_date 입사일
FROM employees
ORDER BY hire_date;

--01-1
SELECT CONCAT(first_name, CONCAT(' ',last_name)) 이름,
    salary 월급,
    phone_number 전화번호,
    hire_date 입사일
FROM employees
ORDER BY hire_date;

--02
SELECT job_title,
    max_salary
FROM jobs
ORDER BY max_salary DESC;

--03
SELECT first_name,
    manager_id,
    commission_pct,
    salary
FROM employees
WHERE 
    manager_id is not null AND 
    commission_pct is null AND 
    salary > 3000;
    
--04
SELECT job_title,
    max_salary
FROM jobs
WHERE max_salary > 10000
ORDER BY max_salary DESC;

--05
SELECT first_name,
    salary,
    nvl(commission_pct, 0)
FROM employees
WHERE salary >= 10000 AND 
    salary < 14000
ORDER BY salary DESC;

--06
SELECT first_name,
    salary,
    TO_CHAR(hire_date, 'YYYY-MM') hire_date,
    department_id
FROM employees
WHERE department_id IN(10, 90, 100);

--07
SELECT first_name || ' ' || last_name 이름,
    salary 월급
FROM employees
WHERE LOWER(first_name) LIKE '%s%';

--08
SELECT department_name
FROM departments
ORDER BY LENGTH(department_name) DESC;

--09
SELECT UPPER(country_name) country_name
FROM countries
ORDER BY UPPER(country_name);

--10
SELECT first_name,
    salary,
    replace(phone_number, '.', '-') phone_number,
    hire_date
FROM employees
WHERE hire_date <= '03-12-31'
ORDER BY hire_date DESC;