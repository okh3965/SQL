/* 
문제1
01 평균 급여보다 적은 급여을 받는 직원은 몇명인지 구하시요.(56건)

*/
SELECT COUNT(salary)
FROM employees
WHERE salary < (SELECT AVG(salary)
                    FROM employees);
/*
문제2
평균급여 이상, 최대급여 이하의 월급을 받는 사원의
직원번호(employee_id), 이름(first_name), 급여(salary), 평균급여, 최대급여를 급여의 오름차
순으로 정렬하여 출력하세요(51건)

*/

SELECT employee_id, first_name, salary
FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees) AND
        salary <= (SELECT MAX(salary) FROM employees)
ORDER BY salary;

SELECT ROUND(AVG(salary), 0) avgSalary,
    MAX(salary) maxSalary
FROM employees;

SELECT employee_id, first_name, salary, avgSalary, maxSalary
FROM employees emp, (SELECT ROUND(AVG(salary), 0) avgSalary,
                            MAX(salary) maxSalary
                        FROM employees) t
WHERE emp.salary BETWEEN t.avgSalary AND t.maxSalary
ORDER BY emp.salary;
/*
문제3.
직원중 Steven(first_name) king(last_name)이 소속된 부서(departments)가 있는 곳의 주소
를 알아보려고 한다.
도시아이디(location_id), 거리명(street_address), 우편번호(postal_code), 도시명(city), 주
(state_province), 나라아이디(country_id) 를 출력하세요(1건)

*/
SELECT *
FROM locations loc
WHERE loc.location_id = (SELECT location_id
                            FROM departments
                            WHERE department_id = (SELECT department_id
                                                        FROM employees
                                                        WHERE first_name = 'Steven' AND last_name = 'King'));
/*                
문제4.
job_id 가 'ST_MAN' 인 직원의 급여보다 작은 직원의 사번,이름,급여를 급여의 내림차순으로
출력하세요 -ANY연산자 사용(74건)
*/
SELECT employee_id, first_name, salary
FROM employees
WHERE salary < ANY (SELECT salary FROM employees WHERE job_id = 'ST_MAN')
ORDER BY salary DESC;

/*
문제5. 
각 부서별로 최고의 급여를 받는 사원의 직원번호(employee_id), 이름(first_name)과 급여
(salary) 부서번호(department_id)를 조회하세요
단 조회결과는 급여의 내림차순으로 정렬되어 나타나야 합니다. 
조건절비교, 테이블조인 2가지 방법으로 작성하세요(11건)
*/
SELECT employee_id, first_name, salary, department_id
FROM employees
WHERE (department_id,salary) IN (SELECT department_id, MAX(salary)
                                    FROM employees
                                    GROUP BY department_id)
ORDER BY salary DESC;

SELECT e.employee_id, e.first_name, e.salary, e.department_id
FROM employees e, (SELECT department_id, MAX(salary) salary
                    FROM employees
                    GROUP BY department_id) s
WHERE e.department_id = s.department_id AND
    e.salary = s.salary;

/*
문제6.
각 업무(job) 별로 연봉(salary)의 총합을 구하고자 합니다. 
연봉 총합이 가장 높은 업무부터 업무명(job_title)과 연봉 총합을 조회하시오
(19건)
*/
SELECT job_title, s.sum
FROM jobs j, (SELECT job_id, SUM(salary) sum
                FROM employees
                GROUP BY job_id) s
WHERE j.job_id = s.job_id
ORDER BY s.sum DESC;

/*
문제7.
자신의 부서 평균 급여보다 연봉(salary)이 많은 직원의 직원번호(employee_id), 이름
(first_name)과 급여(salary)을 조회하세요
(38건)
*/
SELECT employee_id, first_name, salary
FROM employees outer
WHERE salary > (SELECT AVG(salary)
                FROM employees
                GROUP BY department_id
                    HAVING department_id = outer.department_id);
                    
SELECT employee_id, first_name, emp.salary
FROM employees emp, (SELECT department_id, AVG(salary) salary
                        FROM employees
                        GROUP BY department_id) t
WHERE emp.department_id = t.department_id AND
    emp.salary > t.salary;
/*
문제8.
직원 입사일이 11번째에서 15번째의 직원의 사번, 이름, 급여, 입사일을 입사일 순서로 출력
하세요
*/
SELECT employee_id, first_name, salary, hire_date
FROM 
    (
        SELECT employee_id, first_name, salary, hire_date,
            ROW_NUMBER() OVER(ORDER BY hire_date) hr
        FROM employees
    ) e
WHERE e.hr > 10 AND e.hr < 16;

SELECT employee_id, first_name, salary, hire_date FROM employees ORDER BY hire_date;
SELECT rownum, employee_id, first_name, salary, hire_date FROM (
    SELECT employee_id, first_name, salary, hire_date FROM employees ORDER BY hire_date
);

SELECT rn, employee_id, first_name, salary, hire_date FROM (
    SELECT rownum rn, employee_id, first_name, salary, hire_date FROM (
    SELECT employee_id, first_name, salary, hire_date FROM employees ORDER BY hire_date
    )
)
WHERE rn >= 11 AND rn <= 15;
--WHERE rn BETWEEN 11 AND 15;