-- 현재 계정 내에 어떤 테이블이 있는가?
SELECT * FROM tab;

-- 테이블의 구조 확인 DESC
DESC employees;

-- 모든 컬럼 확인
-- 테이블에 정의된 컬럼 순서대로 출력
SELECT * FROM employees;

DESC departments;

SELECT * FROM departments;

-- first name, 전화번호, 입사일, 급여
--SELECT employee_id, phone_number, hire_date, salary FROM employees;
SELECT first_name,
    last_name,
    phone_number,
    hire_date,
    salary
FROM employees;

-- first_name, last_name, salary, 전화번호, 입사일    

-- 산술 연산: 기본적인 산술 연산을 사용
SELECT 3.14159 * 3 * 3 FROM employees;  -- 모든 레코드를 불러와서 산술연산을 수행
SELECT 3.14159 * 3 * 3 FROM dual; -- 단순 계산식은 dual(가상테이블)을 이용

SELECT first_name, 
    salary, 
    salary * 12 -- 레코드 내 모든 salary 컬럼에 동일 산술연산을 수행, 
FROM employees;

--SELECT job_id * 12
--FROM employees;

-- 사원의 이름, salary, commision_pct 출력
SELECT first_name, salary, commission_pct
FROM employees;

-- 계산식에 null포함 시, 결과는 항상 null
SELECT first_name,
    salary,
    salary + (salary * commission_pct)
FROM employees;

-- nvl함수: null -> 다른 기본값으로 치환
-- null 처리 시 항상 유의
SELECT first_name,
    salary + (salary * nvl(commission_pct, 0)) -- commission_pct null -> 0
FROM employees;

-- 문자열의 연결 (||)
-- 별칭(Alias)
-- as 없어도 된다
-- 공백, 특수문자가 포함되어 있으면 별칭을 "로 묶음
SELECT first_name || ' ' || last_name as "FULL NAME"
FROM employees;

/*
이름 : first_name last_name
입사일 : hire_date
전화번호 : phone_number
급여 : salary
연봉 : salary * 12
*/

SELECT first_name || ' ' || last_name as "이름",
    hire_date 입사일,
    phone_number 전화번호,
    salary 급여,
    salary * 12 연봉
FROM employees;

--------
-- WHERE : 조건에 맞는 레코드 추출을 위한 조건 비교
--------

--급여가 15000 이상인 사원들의 이름과 연봉 출력
SELECT first_name || last_name 이름,
    salary * 12 연봉
FROM employees
WHERE salary > 15000;

-- 07/01/01일 이후 입사자들의 이름과 입사일 출력
SELECT first_name || last_name 이름,
    hire_date 입사일
FROM employees
WHERE hire_date >= '07/01/01';

-- 이름이 Lex인 사원의 연봉과 입사일 부서 ID 출력
SELECT first_name 이름,
    salary * 12,
    hire_date,
    department_id
FROM employees
WHERE first_name = 'Lex';

-- 부서 id가 10인 사람의 명단
SELECT * FROM employees
WHERE department_id = 10;

-- Like 연산
-- % 임의의 길이 (0일 수 있다)의 문자열
-- _ 1개의 임의 문자

-- 이름의 am을 포함한 모든 사원들 (%검색)
SELECT first_name, salary
FROM employees
WHERE first_name LIKE '%am%';

-- 이름의 두 번째 글자가 a인 사원의 목록
SELECT first_name, salary 
FROM employees
WHERE first_name LIKE '_a%';

-- 급여가 14000 이하이거나 17000 이상인 사원의 이름과 급여 출력
/*SELECT first_name,
    salary
FROM employees
WHERE salary <= 14000 OR salary >= 17000;*/
SELECT first_name, salary
FROM employees
WHERE salary BETWEEN 14000 AND 17000;

-- 부서 아이디가 90인 사원 중에서 급여가 20000 이상인 사원
SELECT * FROM employees
WHERE department_id = 90 AND salary >= 20000;

-- 입사일이 07/01/01 ~ 07/12/31 인 사람
SELECT * FROM employees
WHERE hire_date BETWEEN '07/01/01' AND '07/12/31';

-- 부서 ID가 10, 20, 40인 사원의 명단
SELECT * FROM employees
/*
WHERE department_id = 10 OR
    department_id = 20 OR
    department_id = 40;
*/
WHERE department_id IN (10, 20, 40);

-- MANAGER ID가 100, 120, 147인 사원 명단
SELECT * FROM employees
WHERE manager_id IN(100, 120, 147);

-- 커미션을 받지 않는 사원의 목록 -> commission_pct가 null
-- is null 사용
SELECT first_name, commission_pct FROM employees
WHERE commission_pct is null;

-- 커미션을 받는 사원의 목록
SELECT first_name, commission_pct FROM employees
WHERE commission_pct is not null;

--부서번호를 오름차순으로 정렬하고 부서번호, 급여, 이름 출력
--급여가 10000이상인 직원의 이름을 급여 내림차순 출력
--부서번호, 급여, 이름 순으로 출력, 부서번호는 오름차순, 급여는 내림차순
SELECT department_id, salary, first_name
FROM employees
WHERE salary >= 10000
ORDER BY department_id, 
    salary DESC; -- 복수 정렬 기준
