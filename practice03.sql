/*
문제1.
직원들의 사번(employee_id), 이름(firt_name), 성(last_name)과 부서명(department_name)을
조회하여 부서이름(department_name) 오름차순, 사번(employee_id) 내림차순 으로 정렬하세
요.
(106건)
*/
SELECT employee_id, 
    first_name, 
    last_name, 
    department_name,
    emp.department_id
FROM employees emp, departments dept
WHERE emp.department_id = dept.department_id
ORDER BY department_name, employee_id DESC;

/*
문제2.
employees 테이블의 job_id는 현재의 업무아이디를 가지고 있습니다.
직원들의 사번(employee_id), 이름(firt_name), 급여(salary), 부서명(department_name), 현
재업무(job_title)를 사번(employee_id) 오름차순 으로 정렬하세요.
부서가 없는 Kimberely(사번 178)은 표시하지 않습니다.
*/
SELECT employee_id,
    first_name,
    salary,
    department_name,
    job_title,
    emp.job_id
FROM employees emp, jobs j, departments dept
WHERE emp.job_id = j.job_id
    AND emp.department_id = dept.department_id
ORDER BY emp.employee_id;

SELECT employee_id,
    first_name,
    salary,
    department_name,
    job_title,
    emp.job_id
FROM employees emp, jobs j, departments dept
WHERE emp.department_id = dept.department_id(+) AND
    emp.job_id = j.job_id
ORDER BY emp.employee_id;

/*
문제3.
도시별로 위치한 부서들을 파악하려고 합니다.
도시아이디, 도시명, 부서명, 부서아이디를 도시아이디(오름차순)로 정렬하여 출력하세요
부서가 없는 도시는 표시하지 않습니다.
*/
SELECT l.location_id,
    city,
    department_name,
    department_id
FROM locations l, departments d
WHERE l.location_id = d.location_id
ORDER BY l.location_id;

SELECT l.location_id,
    city,
    department_name,
    department_id
FROM locations l, departments d
WHERE l.location_id  = d.location_id (+)
ORDER BY l.location_id;

/*
문제4.
지역(regions)에 속한 나라들을 지역이름(region_name), 나라이름(country_name)으로 출력하
되 지역이름(오름차순), 나라이름(내림차순) 으로 정렬하세요.
*/
SELECT region_name,
    country_name
FROM regions r, countries c
WHERE r.region_id = c.region_id
ORDER BY region_name, country_name DESC;

/*
문제5. 
자신의 매니저보다 채용일(hire_date)이 빠른 사원의
사번(employee_id), 이름(first_name)과 채용일(hire_date), 매니저이름(first_name), 매니저입
사일(hire_date)을 조회하세요.
*/
SELECT e1.employee_id 사번,
    e1.first_name 이름,
    e1.hire_date 채용일,
    e2.first_name 매니저이름,
    e2.hire_date 매니저입사일
FROM employees e1, employees e2
WHERE e1.manager_id = e2.employee_id
    AND e1.hire_date < e2.hire_date
ORDER BY e1.hire_date;

/*
문제6.
나라별로 어떠한 부서들이 위치하고 있는지 파악하려고 합니다.
나라명, 나라아이디, 도시명, 도시아이디, 부서명, 부서아이디를 나라명(오름차순)로 정렬하여
출력하세요.
값이 없는 경우 표시하지 않습니다.
*/
SELECT country_name,
    c.country_id,
    city,
    l.location_id,
    department_name,
    department_id
FROM countries c, locations l, departments d
WHERE l.country_id = c.country_id AND
    l.location_id = d.location_id
ORDER BY country_name;
   
/* 
문제7.
job_history 테이블은 과거의 담당업무의 데이터를 가지고 있다.
과거의 업무아이디(job_id)가 ‘AC_ACCOUNT’로 근무한 사원의 사번, 이름(풀네임), 업무아이
디, 시작일, 종료일을 출력하세요.
이름은 first_name과 last_name을 합쳐 출력합니다.
*/
SELECT e.employee_id,
    first_name || ' ' || last_name 이름,
    e.job_id,
    start_date,
    end_date
FROM employees e, job_history jh
WHERE e.employee_id = jh.employee_id AND
    jh.job_id = 'AC_ACCOUNT';
    
/*
문제8.
각 부서(department)에 대해서 부서번호(department_id), 부서이름(department_name), 
매니저(manager)의 이름(first_name), 위치(locations)한 도시(city), 나라(countries)의 이름
(countries_name) 그리고 지역구분(regions)의 이름(resion_name)까지 전부 출력해 보세요.
*/
SELECT * FROM departments;

SELECT e.department_id,
    department_name,
    e.first_name,
    city,
    country_name,
    region_name
FROM employees e, departments d, locations l, countries c, regions r
WHERE e.department_id = d.department_id AND
    d.location_id = l.location_id AND
    l.country_id = c.country_id AND
    c.region_id = r.region_id AND
    e.employee_id = d.manager_id
GROUP BY e.department_id, 
    department_name,
    e.first_name, 
    city,
    country_name,
    region_name
ORDER BY e.department_id;

/*
문제9.
각 사원(employee)에 대해서 사번(employee_id), 이름(first_name), 부서명
(department_name), 매니저(manager)의 이름(first_name)을 조회하세요.
부서가 없는 직원(Kimberely)도 표시합니다.
*/
SELECT e1.employee_id,
    e1.first_name,
    department_name,
    e2.first_name
FROM employees e1, employees e2, departments d
WHERE e1.department_id = d.department_id (+) AND
    e1.manager_id = e2.employee_id;