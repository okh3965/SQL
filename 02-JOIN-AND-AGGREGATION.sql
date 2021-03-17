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