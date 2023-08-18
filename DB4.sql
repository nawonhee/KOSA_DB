--사원의 사번, 이름, 급여를 출력하시오
SELECT employee_id, first_name, salary
FROM employees
ORDER BY salary DESC;

--ROWNUM : 행번호
--사원의 행버호, 사번, 이름, 급여를 출력하시오
SELECT ROWNUM, employee_id, first_name, salary
FROM employees
ORDER BY salary DESC; --행번호가 먼저 발급되다보니 정렬될 때 마구 뒤섞인다

SELECT ROWNUM, employee_id, first_name, salary
FROM (SELECT employee_id, first_name, salary
    FROM employees
    ORDER BY salary DESC);
    
--TOP-N Query
--사원의 사번, 이름, 급여를 출력하시오. 많은 급여를 받는 사원 5명만 출력한다
SELECT ROWNUM, employee_id, first_name, salary
FROM (SELECT employee_id, first_name, salary
    FROM employees
    ORDER BY salary DESC)
WHERE ROWNUM BETWEEN 1 AND 5;

--사원의 사번, 이름, 급여를 출력하시오. 많은 급여를 받는 사원부터 정렬하여 11~20번째 사원만 출력한다
SELECT *
FROM (SELECT ROWNUM rn, employee_id, first_name, salary --ROWNUM이 1번부터 다 발급되어 rn이라는 별칭 주기
    FROM (SELECT employee_id, first_name, salary
            FROM employees
            ORDER BY salary DESC)
    )
WHERE rn BETWEEN 11 AND 20; --별칭을 통해 조건 설정

--Scalar SubQuery : SELECT절에서 사용하는 SubQuery
--사원의 사번, 부서번호, 부서명을 출력하시오
SELECT employee_id, e.department_id, department_name
FROM employees e JOIN departments d ON (e.department_id = d.department_id);

SELECT employee_id, department_id
    , (SELECT department_name
        FROM departments 
        WHERE department_id = e.department_id)
FROM employees e;

--부서명이 'IT'인 부서에 근무하는 사원들의 사번, 이름을 출력하시오 
SELECT employee_id, first_name
FROM employees 
WHERE department_id = (SELECT department_id FROM departments WHERE department_name = 'IT');

--이름이 'Bruce'인 사원과 같은 부서에 근무하는 사원들의 사번, 이름을 출력하시오
SELECT employee_id, first_name
FROM employees
WHERE (department_id = (SELECT department_id FROM employees WHERE first_name = 'Bruce'))
    AND (first_name <> 'Bruce');
    
--이름이 'Bruce'인 사원과 같은 부서에 근무하면서
--부서평균급여보다 많은 급여를 받는 사원의 사번, 이름, 급여를 출력하시오
SELECT employee_id, first_name, salary
FROM employees e
WHERE (department_id = (SELECT department_id FROM employees WHERE first_name = 'Bruce'))
    AND (salary > (SELECT AVG(salary) FROM employees WHERE department_id = e.department_id)); --상호연관서브쿼리 -> 퍼포먼스 좀 떨어짐

--쿼리가 좀 길지만...
SELECT employee_id, first_name, salary
FROM employees e
WHERE (department_id = (SELECT department_id FROM employees WHERE first_name = 'Bruce'))
    AND (salary > (SELECT AVG(salary) FROM employees WHERE department_id = (SELECT department_id FROM employees WHERE first_name = 'Bruce')));


CREATE TABLE T_a(
    one number(5),    
    two number(5,2),  
    three char(3),   
    four varchar2(3),   
    five date
);

SELECT * FROM t_a;

INSERT INTO t_a VALUES (2, 2.2, 'B', 'B', '23/01/01'); 
INSERT INTO t_a VALUES(3,null,'C','','23/01/01');

SELECT three,LENGTH(three), four, LENGTH(four)
FROM t_a;

CREATE TABLE t_a_copy
AS SELECT * FROM t_a;

CREATE TABLE t_a_copy2 AS SELECT one, three FROM t_a;
SELECT * FROM t_a_copy2;

--구조만 복사해서 테이블 생성
CREATE TABLE t_a_copy3 AS SELECT * FROM t_a WHERE 1 = 2;
SELECT * FROM t_a_copy3;

--칼럼추가
ALTER TABLE t_a
ADD six number;

--칼럼 이름변경
ALTER TABLE t_a
RENAME COLUMN six TO six2;

--칼럼삭제
ALTER TABLE t_a
DROP COLUMN six2;

--칼럼 자료형변경/자릿수변경
ALTER TABLE t_a
MODIFY four VARCHAR2(10);

--테이블 제거
DROP TABLE t_a_copy3;

--데이터 수정
--t_a테이블의 two컬럼값이 null이 아니면 two컬럼값을 1.5배 증가한다
UPDATE t_a
SET two = two*1.5
WHERE two IS NOT NULL;

SELECT * FROM t_a;

--t_a테이블의 two컬럼값이 null이면 one컬럼값은 1증가하고 five컬럼값은 1일 감소한다
UPDATE t_a
SET one = one+1, five = five-1
WHERE two IS NULL;

--데이터 삭제
--t_a테이블의 one컬럼값이 4인 행을 삭제한다
DELETE t_a
WHERE one=4;

--t_a테이블의 five컬럼값이 어제날짜 (23/08/17)인 행을 삭제한다
DELETE t_a
--WHERE TO_CHAR(five, 'yy/mm/dd')='23/08/17';
WHERE TO_CHAR(five, 'yy/mm/dd')=TO_CHAR(SYSDATE-1);

CREATE TABLE t_b(
    id varchar2(5) PRIMARY KEY, 
    pwd varchar2(5) NOT NULL,
    name varchar2(30),
    email varchar2(30) UNIQUE,
    status number(1) --CHECK
);

--테이블레벨 제약조건 설정
CREATE TABLE t_b(
    id varchar2(5),
    pwd varchar2(5),
    status number(1),
    CONSTRAINT t_b_id_pk PRIMARY KEY(id),
    CONSTRAINT t_b_email_uq UNIQUE(email),
    CONSTRAINT t_b_status_ck CHECK(status IN (-1,0,1))
);

--컬럼레벨 제약조건 설정하기 : NOT NULL제약조건은 반드시 컬럼레벨로만 설정
CREATE TABLE t_b(
    id varchar2(5) CONSTRAINT t_b_id_pk PRIMARY KEY,
    pwd varchar2(5) NOT NULL,
    email varchar2(30) CONSTRAINT t_b_email_uq UNIQUE,
    status number(1) CONSTRAINT t_b_stauts_ck CHECK(status IN(-1,0,1))
);