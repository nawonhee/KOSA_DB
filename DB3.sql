SELECT employee_id, first_name, department_id
FROM employees; --107명

SELECT department_id, department_name
FROM departments; --27건

--카티션곱
--사원의 사번, 이름, 부서번호, 부서명을 출력하시오
SELECT employee_id, first_name, e.department_id, d.department_id, department_name
FROM employees e, departments d; --107명*27건

--사원의 사번, 이름, 부서번호, 부서명을 출력하시오(106명)
SELECT employee_id, first_name, e.department_id, d.department_id, department_name
FROM employees e, departments d
WHERE e.department_id = d.department_id;

--표준화된 ANSI JOIN법
SELECT employee_id, first_name, e.department_id, d.department_id, department_name
FROM employees e JOIN departments d
ON (e.department_id=d.department_id);

--사원의 사번, 이름, 부서번호, 부서명, 부서가 속한 도시명을 출력하시오
SELECT * FROM departments;
SELECT * FROM locations WHERE location_id=1700;

SELECT employee_id, first_name, e.department_id, d.department_id, department_name, city
FROM employees e
JOIN departments d ON (e.department_id=d.department_id) 
JOIN locations l ON (d.location_id = l.location_id );

--NATURAL JOIN
--사원의 사번, 이름, 직무번호, 직무명을 출력하시오
SELECT employee_id, first_name, job_id, job_title
FROM employees
NATURAL JOIN jobs;
--JOIN jobs j ON (e.job_id = j.job_id);

--JOIN USING
--사원의 사번, 이름, 부서번호, 부서명을 출력하시오
SELECT employee_id, first_name, department_id, department_name
FROM employees
JOIN departments USING (department_id);

--OUTER JOIN
--사원의 사번, 이름, 부서번호, 부서명을 출력하시오. 단 부서없는 사원도 출력하시오
SELECT employee_id, first_name, d.department_id, department_name
FROM employees e LEFT OUTER JOIN departments d ON(e.department_id=d.department_id);

--사원의 사번, 이름, 부서번호, 부서명을 출력하시오. 단 사원없는 부서도 출력하시오
SELECT employee_id, first_name, d.department_id, department_name
FROM employees e RIGHT JOIN departments d ON(e.department_id=d.department_id);

--사원의 사번, 이름, 부서번호, 부서명을 출력하시오. 단 사원없는 부서도, 부서없는 사원도 출력
SELECT employee_id, first_name, d.department_id, department_name
FROM employees e FULL JOIN departments d ON(e.department_id=d.department_id);

--오라클전용 OUTER JOIN
SELECT employee_id, first_name, d.department_id, department_name
FROM employees e , departments d 
WHERE e.department_id=d.department_id(+);

--SELF JOIN
--사원의 사번, 이름, 관리자번호, 관리자이름을 출력하시오
SELECT e.employee_id "사번", e.first_name "이름", e.manager_id "관리자번호", m.first_name "관리자이름"
FROM employees e JOIN employees m ON (e.manager_id=m.employee_id);



--1.부서의 부서번호, 부서가 속한 지역의 도시명(city), 국가명(country_name)을 출력하시오
SELECT d.department_id "부서번호", l.city "도시명", c.country_name "국가명"
FROM departments d
JOIN locations l ON (d.location_id=l.location_id)
JOIN countries c ON (l.country_id=c.country_id);

--2. 사원의 사번, 부서번호, 부서명, 직무번호, 직무명을 출력하시오
    --직무명에 'Manager'를 포함한 사원들만 출력하시오
   --직무번호순, 부서명으로 오름차순하시오
SELECT e.employee_id "사번", e.department_id"부서번호", d.department_name"부서명", e.job_id"직무번호", j.job_title"직무명"
FROM employees e JOIN jobs j ON(e.job_id=j.job_id)
JOIN departments d ON (d.department_id=e.department_id)
--WHERE j.job_title LIKE '%Manager%'
WHERE INSTR(j.job_title,'Manager')>0
ORDER BY j.job_id ASC, d.department_name ASC;

--3. 부서별 부서번호, 부서명, 사원수, 평균급여를 출력하시오
SELECT d.department_id "부서번호", d.department_name "부서명", COUNT(*) "사원수", AVG(salary)"평균급여"
FROM employees e JOIN departments d ON (e.department_id = d.department_id)
GROUP BY d.department_id, d.department_name;

--4. 부서별 사원수가 10명이상인 부서들의 부서별 부서번호, 부서명, 사원수, 평균급여를 출력하시오
SELECT d.department_id "부서번호", d.department_name "부서명", COUNT(*) "사원수", AVG(salary) "평균급여"
FROM employees e JOIN departments d ON (e.department_id=d.department_id)
GROUP BY d.department_id, d.department_name
HAVING COUNT(*)>=10;

--5.사원의 부서번호와 관리자의 부서번호가 일치하지않는 사원들 사번, 부서번호를 출력하시오 
--사번순으로 오름차순 정렬하시오
SELECT e.employee_id "사번", e.department_id "부서번호"
FROM employees e JOIN employees m ON (e.manager_id=m.employee_id)
WHERE e.department_id != m.department_id
ORDER BY e.employee_id ASC;

--6. 각 도시에 있는 부서수를 출력하시오
SELECT l.city "도시", COUNT(d.department_id) "부서수"
FROM departments d JOIN locations l ON(d.location_id = l.location_id)
GROUP BY l.city;


--7.각 도시에 있는 부서수를 출력하시오.  단, 부서가 없는 도시도 모두 출력하시오
SELECT l.city "도시", COUNT(d.department_id) "부서수"
FROM departments d RIGHT JOIN locations l ON(d.location_id = l.location_id)
GROUP BY l.city;

SELECT *
FROM job_history;

SELECT *
FROM employees
WHERE employee_id=176;

--사원의 사번, 이전직무번호를 출력하시오
--사원의 사번, 직무번호를 출력하시오
SELECT employee_id, job_id
FROM job_history
UNION
SELECT employee_id, job_id
FROM employees
ORDER BY employee_id; --각각 정렬 안 되고 맨 밑에 있는 구문에 쓸 수 있음

SELECT employee_id, job_id
FROM job_history
UNION ALL -- 중복도 출력
SELECT employee_id, job_id
FROM employees
ORDER BY employee_id; --각각 정렬 안 되고 맨 밑에 있는 구문에 쓸 수 있음

--이전직무와 다른 직무를 갖는 사원들의 사번, 현재직무를 출력하시오
SELECT employee_id, job_id
FROM employees
MINUS
SELECT employee_id, job_id
FROM job_history;

SELECT employee_id, job_id
FROM employees
INTERSECT
SELECT employee_id, job_id
FROM job_history;

--부서별 최대급여를 받는 사원의 부서번호, 사번, 이름, 급여를 출력하시오
--1)부서별 최대급여를 계산한다
SELECT department_id, employee_id, first_name, MAX(salary)
FROM employees
GROUP BY department_id;
--2) 1번과 같은 급열르 받는 사원의 사번, 이름, 급여를 출력하시오
SELECT department_id, employee_id, first_name, salary
FROM employees
WHERE (department_id, salary) IN (SELECT department_id, MAX(salary)  --쌍 맞춰주기
FROM employees 
GROUP BY department_id);

--최대급여자의 사번, 이름, 급여를 출력하시오
SELECT employee_id, first_name, salary
FROM employees
WHERE salary = (SELECT MAX(salary) FROM employees);

--사원들의 평균급여보다 많은 급여를 받는 사원의 사번, 이름, 급여를 출력하시오
SELECT employee_id, first_name, salary
FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees);

--부하직원이 있는 관리자의 관리자번호, 이름 출력하시오
SELECT employee_id, first_name
FROM employees
WHERE employee_id IN (SELECT manager_id FROM employees);

SELECT employee_id, first_name
FROM employees
WHERE employee_id IN (null,100,102,103,101,108);

--부하직원이 없는 모든사원의 사번, 이름을 출력하시오
SELECT employee_id, first_name
FROM employees
--WHERE employee_id NOT IN (SELECT NVL(manager_id,-1) FROM employees);
WHERE employee_id NOT IN (SELECT manager_id FROM employees WHERE manager_id IS NOT NULL);

SELECT employee_id, first_name
FROM employees
WHERE employee_id NOT IN (null,100,102,103,101,108);