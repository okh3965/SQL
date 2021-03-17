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


--------
--단일행 함수
--------

-- 문자열 단일행 함수
SELECT first_name, last_name,
    CONCAT(first_name, CONCAT(' ', last_name)) name,
    first_name || ' ' || last_name name2,
    INITCAP(first_name || last_name) name2, -- 각 단어의 첫글자를 대문자로
    LOWER(first_name), -- 전부 소문자
    UPPER(first_name), -- 전부 대문자
    LPAD(first_name, 10, '*'), -- 10글자 출력 크기, 빈자리에 * 채움
    RPAD(first_name, 10, '*')
FROM employees;

-- first_name에 am이 포함된 사원의 이름 출력
SELECT first_name FROM employees
WHERE first_name LIKE '%am%';

SELECT first_name FROM employees;

-- Upper, Lower는 대소문자 구분 없이 검색할 때 유용
SELECT first_name FROM employees
WHERE lower(first_name) LIKE '%am%';

-- 정제
SELECT '  Oracle  ', '*****Database*****'
FROM dual;

SELECT LTRIM('  Oracle  '), -- 왼쪽공백 삭제
    RTRIM('  Oracle  '), -- 오른쪽공백 삭제
    TRIM('*' FROM '*****Database*****'), -- 문자열 내에서 특정 문자를 제거
    SUBSTR('Oracle Database', 8, 8), -- 문자열내 8번째 글자부터 8개 추출
    SUBSTR('Oracle Database', -8, 8) -- 뒤에서부터 8번째 글자부터 8개 추출
FROM dual;

-- 수치형 단일행 함수
SELECT ABS(-3.14), --  절댓값  
    CEIL(3.14), -- 올림
    FLOOR(3.14), -- 내림
    MOD(7, 3), -- 나눗셈의 몫
    POWER(2, 4), -- 제곱: 2의 4제곱
    ROUND(3.5), -- 소숫점 첫째자리 반올림
    ROUND(3.5678, 2),  -- 소숫점 둘째자리까지 표시, 셋째 자리에서 반올림
    TRUNC(3.5), -- 소숫점 버림
    TRUNC(3.5678, 2), -- 소숫점 둘째자리까지 표시, 이하 버림 
    SIGN(-10) -- 부호 함수 (음수:-1, 양수:1, 0)
FROM dual;

-- 날짜형 단일행함수
SELECT sysdate FROM dual; -- 시스템 가상 테이블 -> 1개
SELECT sysdate FROM employees; -- 테이블 내 레코드 수 만큼 출력

SELECT sysdate, -- 시스템 날짜
    ADD_MONTHS(sysdate, 2), -- 오늘부터 2개월 후
    MONTHS_BETWEEN(TO_DATE('1999-12-31', 'YYYY-MM-DD'), sysdate), -- 개월 차
    NEXT_DAY(sysdate, 1), -- 오늘이후 첫번째 일요일(일요일 1, 토요일 7)
    ROUND(sysdate, 'MONTH'), -- 날짜 반올림
    TRUNC(sysdate, 'MONTH')
FROM dual;

-- employees 사원들의 재직기간
SELECT first_name, hire_date,
    ROUND(MONTHS_BETWEEN(sysdate, hire_date), 1) months
    
FROM employees;

-------
--변환함수
-------

/*
TO_CHAR(o, fmt) : Number or Date -> Varchar
TO_NUMBER(s, fmt) : Varchar -> Number
TO_DATE(s, fmt) : Varchar -> Date
*/

-- TO_CHAR
SELECT first_name, 
    TO_CHAR(hire_date, 'YYYY-MM-DD HH24:MI:SS') 입사일
FROM employees;

-- 현재 시간을 년-월-일 오전/오후 시:분:초 출력
SELECT
    sysdate,
    TO_CHAR(sysdate, 'YYYY-MM-DD PM HH:MI:SS') 현재시간
FROM dual;

SELECT first_name,
    TO_CHAR(salary * 12, '$999,999.99') 연봉
FROM employees;

-- TO_NUMBER: 문자열 -> 숫자 정보
SELECT 
    TO_NUMBER('$1,500,500.90', '$999,999,999.99')
FROM dual;

-- TO_DATE: 날짜 형태를 지닌 문자열 -> date
SELECT
    '2021-03-16 15:07' 현재시간, 
    TO_DATE('2021-03-16 15:07', 'YYYY-MM-DD HH24:MI') 날짜 
FROM dual;

/*
날짜 연산
-- Date +(-) Number : 날짜에 일수를 더하거나 뺀다 -> Date
-- Date - Date : 두 날짜 사이의 일수
-- Date + Number / 24 : 날짜에 시간을 더하거나 뺄 때는 Number / 24를 더하거나 뺀다.
*/
SELECT TO_CHAR(sysdate, 'YYYY-MM-DD HH24:MI') 현재시간,
    TO_CHAR(sysdate - 8, 'YYYY-MM-DD HH24:MI') _8일_전,
    TO_CHAR(sysdate + 8, 'YYYY-MM-DD HH24:MI') _8일_후,
    sysdate - TO_DATE('1999-12-31', 'YYYY-MM-DD'),
    TO_CHAR(sysdate + 12/24, 'YYYY-MM-DD HH24:MI') _12시간후
FROM dual;

-- NULL 관련
-- NULL이 산술계산에 포함되면 결과는 항상 NULL이다.
-- NULL 처리필요
-- nvl: 첫번째 인자가 null -> 두번째 인자값 사용
SELECT first_name, 
    salary, 
    nvl(salary * commission_pct, 0) commission 
FROM employees;

--nvl2: 첫번째 인자가 not null이면 두번째 인자, null이면 세번째 인자 사용
SELECT first_name,
    salary,
    nvl2(commission_pct, salary * commission_pct, 0) commission 
FROM employees;

-- CASE FUNCTION
-- 보너스를 지급
-- AD관련 직원 -> 20%, SA관련 직원 10%, IT관련 직원 8%, 나머지는 3%를 지급하기로 결정

SELECT first_name, job_id, SUBSTR(job_id, 1, 2) FROM employees; -- JOB_ID 형태 확인

SELECT first_name, job_id, SUBSTR(job_id, 1, 2) 직종, -- CASE WHEN~~ THEN~~ .. END
    CASE SUBSTR(job_id, 1, 2) 
        WHEN 'AD' THEN salary * 0.2 -- IF
        WHEN 'SA' THEN salary * 0.1
        WHEN 'IT' THEN salary * 0.08
        ELSE salary * 0.03
    END commission
FROM employees;
    
-- DECODE
SELECT first_name, job_id, SUBSTR(job_id, 1, 2) 직종, salary,
    DECODE(SUBSTR(job_id, 1, 2),
        'AD', salary * 0.2,
        'SA', salary * 0.1,
        'IT', salary * 0.08,
        salary * 0.03) bonus
FROM employees;

/*
직원이름, 부서, 팀 출력
팀은 코드로 결정
부서코드 10~30 A
40~50 B
60~100 C
나머지 REMAINDER
*/
SELECT first_name, department_id, 
    CASE WHEN department_id >= 10 AND department_id <= 30 THEN 'A-GROUP'
        WHEN department_id <= 50 THEN 'B-GROUP'
        WHEN department_id <= 100 THEN 'C-GROUP'
        ELSE 'REMAINDER'
    END team
FROM employees
ORDER BY team;

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
