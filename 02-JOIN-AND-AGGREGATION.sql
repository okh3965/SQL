--------------
-- JOIN
--------------

DESC employees;
DESC departments;

-- 두 테이블로부터 모든 데이터를 불러올 경우
-- CROSS JOIN : 카티전 프로덕트
-- 두 테이블의 조합 가능한 모든 레코드의 쌍
SELECT employees.employee_id, employees.department_id,
    departments.department_id, departments.department_name
FROM employees, departments
ORDER BY employees.employee_id;

-- 일반적으로는 이런 정보를 원하지 않을 것 (중복)
-- 첫 번째 테이블의 department_id 정보와 두 번째 테이블의 department_id 일치
SELECT employees.employee_id, employees.first_name, employees.department_id,
    departments.department_id, departments.department_name
FROM employees, departments
WHERE employees.department_id = departments.department_id; -- 두 테이블 연결 정보 조건 부여
-- INNER JOIN, Equi JOIN

-- 컬럼명의 모호성을 피하기 위해 테이블명.컬럼명
-- 테이블에 별명 붙여주면 편리
SELECT employee_id, -- 컬럼 소속이 명확하면 테이블 명은 명시안해도 된다.
    first_name, 
    dept.department_id,
    department_name
FROM employees emp, departments dept -- 별칭 부여 테이블 목록
WHERE emp.department_id = dept.department_id; -- 두 테이블 연결 정보 조건 부여

----------
-- INNER JOIN: Simple Join
----------
SELECT * FROM employees;    -- 107

SELECT first_name,
    emp.department_id,
    dept.department_id,
    department_name
FROM employees emp, departments dept -- table alias
WHERE emp.department_id = dept.department_id;   -- 106

-- JOIN되지 않은 사원은 누구인가?
SELECT first_name, department_id
FROM employees
WHERE department_id is null;

SELECT first_name,
    department_id,
    department_name
FROM employees JOIN departments
                USING (department_id);  -- JOIN할 컬럼 명시
                
--JOIN ON
SELECT first_name,
    emp.department_id,
    department_name
FROM employees emp JOIN departments dept
                ON (emp.department_id = dept.department_id); --ON -> JOIN문의 WHERE 절
            
-- Natural Join
-- 두 테이블에 조인을 할 수 있는 공통 필드가 있을 경우(공통 필드가 명확할 때)
SELECT first_name, department_id, department_name
FROM employees NATURAL JOIN departments; -- USING, ON x

------------
-- Theta JOIN
------------
-- 임의의 조건을 사용하되 JOIN 조건이 = 조건이 아닌 경우의 조인
SELECT * FROM jobs WHERE job_id = 'AD_ASST';    --min: 3000, max: 6000
SELECT first_name, salary FROM employees emp, jobs j
WHERE j.job_id = 'AD_ASST' AND
    salary BETWEEN j.min_salary AND j.max_salary;

