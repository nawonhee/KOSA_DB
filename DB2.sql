--오라클 내장함수
--1.숫자형함수
SELECT ROUND(1234.567)  --반올림
FROM employees;

--반올림
SELECT ROUND(1234.567)
    ,ROUND(1234.567,0) --반올림
    ,ROUND(1234.567,1) --소수점이하 한자리까지 보여준다는 의미 (반올림X)
    ,ROUND(1234.567,-1) --1의자리 전까지 나타내라
FROM dual; --테스트 간단히 할 때 dual 테이블 이용

--버리기
SELECT TRUNC(1234.567)
    ,TRUNC(1234.567,0)
    ,TRUNC(1234.567,1)
    ,TRUNC(1234.567,-1)
FROM dual;

--올림,내림
SELECT CEIL(1234.1)
    ,FLOOR(1234.1)
FROM dual;

--사원의 사번, 급여, 수당률, 실급여, 실급여/12 출력
--실급여: 급여+(급여*수당률) -> 힌트 : NVL()
SELECT employee_id, salary, commission_pct, salary+(salary*NVL(commission_pct,0)), (salary+(salary*NVL(commission_pct,0)))/12
FROM employees;

--사원의 사번, 급여, 수당률, 실급여, 실월급 출력한다. 단, 실월급은 소숫점이하2자리에서 반올림한다.
SELECT employee_id, salary, commission_pct, salary+(salary*NVL(commission_pct,0)), ROUND((salary+(salary*NVL(commission_pct,0)))/12, 1)
FROM employees;

--2. 문자형함수
SELECT LENGTH('HELLOORACLE') --11byte 문자개수
    ,LENGTH('안녕하세요') --5 문자개수
    ,LENGTHB('안녕하세요') --15 바이트수
    ,INSTR('HELLOORACLE','L') --3 문자의 위치
    ,INSTR('HELLOORACLE','L',5) --10 문자의 위치를 찾는데, 5번째 문자부터 시작해서 찾기
FROM dual;

SELECT SUBSTR('HELLOORACLE',2,3) --2번째 문자에서 3개를 꺼내와라
    ,LPAD('HELLO',8,'*') --***HELLO *를 왼쪽에서부터 길이 8 되도록 덧대자
    ,'BEGIN'||LTRIM('   HELLO   ')||'END' --왼쪽 공백 없애고 앞에 BEGIN, 뒤에 END포함 출력
    ,'BEGIN'||RTRIM('   HELLO   ')||'END' --오른쪽 공백 없애고 앞에 BEGIN, 뒤에 END포함 출력
    ,'BEGIN'||TRIM('   HELLO   ')||'END' --양쪽 공백 없애고 앞에 BEGIN, 뒤에 END포함 출력
FROM dual;

--사원의 이름중 두번째글자가 'e'인 사원들의 사번, 이름을 출력하시오
SELECT employee_id, first_name
FROM employees
WHERE INSTR(first_name,'e')=2;

SELECT employee_id, first_name
FROM employees
WHERE INSTR(UPPER(first_name),'E')=2; --대문자로 다 바꾸고 E랑 비교

--3.날짜형 함수
SELECT SYSDATE
    ,MONTHS_BETWEEN(SYSDATE,'23/01/01') --시간값까지 적용하여 사이의 개월수 반환
    ,ADD_MONTHS(SYSDATE,1) --오늘 기준 한달 후 날짜
    ,ADD_MONTHS(SYSDATE,-6) --오늘 기준 6개월 전 날짜
    ,LAST_DAY('23/02/16') --올해 2월의 마지막 날짜를 출력
    ,NEXT_DAY(SYSDATE,'일요일') --오늘 날짜를 기준으로 앞으로 다가올 일요일의 날짜
FROM dual;

SELECT SYSDATE
    ,SYSDATE+1 "내일날짜"
    ,SYSDATE-1 "어제날짜"
--    ,SYSDATE-'23/01/01' 문자로 인식해서 오류가 난다
    ,SYSDATE-TO_DATE('23/01/01') "일수"
    ,TRUNC(SYSDATE-TO_DATE('23/01/01'))
FROM dual;

--4.형변환함수
--자동형변환 : 숫자형 <-> 문자형 <-> 날짜형
SELECT *
FROM employees
WHERE department_id=30;

SELECT *
FROM employees
WHERE department_id='30';

SELECT *
FROM employees
WHERE department_id='030';

SELECT *
FROM employees
WHERE hire_date='03/05/18';

--(1)TO_DATE: 문자형->날짜형
SELECT TO_DATE('23/12/22'),TO_DATE('23-12-22'),TO_DATE('12-22-23 09:10:35','mm-dd-yy HH24:mi:ss')
FROM dual;

--(2)TO_CHAR : 날짜형->문자형
SELECT TO_CHAR(SYSDATE)
    ,TO_CHAR(SYSDATE,'yy/mm/dd hh24:mi:ss')
FROM dual;

--사원의 사번, 입사일, 근무일수, 22년12월31일까지의 근무일수를 출력하시오
SELECT employee_id, hire_date
    ,TRUNC(SYSDATE-hire_date) "오늘까지의 근무일수"
    ,TRUNC(TO_DATE('22/12/31')-hire_date) 
FROM employees;

--8월입사자들의 사번, 입사일자를 출력하시오
SELECT employee_id, hire_date, TO_CHAR(hire_date,'day')
FROM employees
WHERE TO_CHAR(hire_date,'mm')='08';

SELECT TO_NUMBER('1,234.5','9,999.9')
    ,TO_NUMBER('1,234,567.8','9,999,999,999.9') --실제 문자열 값보다 더 큰 자릿수로 설정해줘야 함
    ,TO_CHAR(1234.5,'9,999.9')
    ,TO_CHAR(1234567.8,'9,999.9') --숫자자릿수보다 작은 패턴자릿수인 경우 ####
FROM dual;

SELECT TO_CHAR('1234.5','9,999,999.9')
    ,TO_CHAR('1234.5','0,000,000.0')
FROM dual;

SELECT TO_CHAR(1234.5,'L9,999,999.00')
FROM dual;

SELECT employee_id, commission_pct, NVL2(commission_pct,'수당있음','수당없음') --첫번째인자값이 NULL이면 세번째인자값을 반환
FROM employees;

SELECT employee_id, commission_pct, NVL2(TO_CHAR(commission_pct),'수당있음','수당없음')
FROM employees;

SELECT NULLIF(10,10) --첫번째인자값과 두번째 인자값이 같으면 NULL을 반환, 다르면 첫번째 인자값을 반환
    ,NULLIF('hello','hi') 
FROM dual;

SELECT employee_id, department_id
FROM employees
--WHERE department_id = NULL; --비교결과 자체가 false를 반환, 즉 결과가 없다. null은 비교연산자 쓰면 안 됨
WHERE department_id IS NULL;

--일반함수
SELECT NVL(commission_pct,0) 
    ,DECODE(commission_pct, null, 0, commission_pct) --수당률이 NULL이라면 0을 출력, 아니라면 수당률 출력
FROM employees;

SELECT NVL2(commission_pct, '수당있음','수당없음')
    ,DECODE(commission_pct, null, '수당없음','수당있음')
FROM employees;

--수당없으면 '수당없음'출력하고 수당이 0.1인 경우 'B등급', 그 외의 경우에는 'A등급'을 출력하시오
SELECT employee_id, commission_pct
    ,DECODE(commission_pct, null, '수당없음', 0.1, 'B등급','A등급')
FROM employees;

SELECT employee_id, commission_pct
    ,CASE commission_pct WHEN 0.1 THEN 'B등급'
                         ELSE          'A등급'
    END
FROM employees;

--수당없으면 '수당없음'을 출력하고 
--수당이 0.1~0.19까지는 'F등급', 
--0.2~0.29까지는 'E등급', 
--0.3~0.39까지는 'D', 
--0.4~0.49까지는 'C'
--0.5~0.59까지는 'B'
--0.6이상은 'A'

SELECT employee_id, commission_pct
    ,CASE WHEN commission_pct >=0.6 THEN 'A'
          WHEN commission_pct >=0.5 THEN 'B'
          WHEN commission_pct >=0.4 THEN 'C'
          WHEN commission_pct >=0.3 THEN 'D'
          WHEN commission_pct >=0.2 THEN 'E'
          WHEN commission_pct >=0.1 THEN 'F'
          --ELSE '수당없음'
          WHEN commission_pct IS NULL THEN '수당없음'
    END
FROM employees;

SELECT COUNT(*) "전체사원수" --107
    ,COUNT(commission_pct) "수당받는사원수"
    ,COUNT(department_id) "부서배치받은사원수"
FROM employees;

--다중행함수

SELECT SUM(salary) "총급여"
    ,AVG(salary) "평균급여"
FROM employees;

SELECT MAX(salary),MIN(salary)
FROM employees;

--그룹화 GROUP BY
--부서별 부서번호,사원수를 출력하시오
SELECT department_id, COUNT(*)
FROM employees
GROUP BY department_id;

SELECT department_id
    , COUNT(*) "부서별사원수"
    ,MAX(salary)"부서의 최대급여"
    ,AVG(salary)"부서의 평균급여"
FROM employees
GROUP BY department_id;

--부서별 부서번호와 최대급여, 최대급여자 이름을 출력하시오 (SUBQUERY로 해결해야 함)
SELECT department_id, MAX(salary), first_name
FROM employees
GROUP BY department_id;

--부서별, 직무별 부서번호, 직무번호, 사원수를 출력하시오
SELECT department_id, job_id, COUNT(*)
FROM employees
GROUP BY department_id, job_id
ORDER BY department_id, COUNT(*);

SELECT department_id, job_id, COUNT(*)
FROM employees
--GROUP BY department_id, job_id
GROUP BY ROLLUP(department_id,job_id)
ORDER BY department_id, COUNT(*);

--30, 50번 부서의 부서별 부서번호, 평균급여, 최대급여
SELECT department_id, AVG(salary), MAX(salary)
FROM employees
WHERE department_id IN(30,50)
GROUP BY department_id;

--부서의 부서별 부서번호, 평균급여, 최대급여를 출력하시오
--부서가 없는 사원들은 출력하지 않는다
SELECT department_id,AVG(salary),MAX(salary)
FROM employees
WHERE department_id IS NOT NULL
GROUP BY department_id;

--부서의 부서번호, 평균급여, 최대급여, 최소급여를 출력하시오
--평균급여가 10000이상인 부서만 출력하시오
SELECT department_id, AVG(salary), MAX(salary), MIN(salary)
FROM employees
GROUP BY department_id
HAVING AVG(salary)>=10000; --그룹에 대한 조건이므로 HAVING절 이용

--입사일자가 빠른 순서대로 출력하시오
SELECT employee_id, hire_date, salary
FROM employees
ORDER BY hire_date ASC;

--급여가 많은 사원부터 출력하시오
SELECT employee_id, hire_date, salary
FROM employees
ORDER BY salary DESC;

--입사일자가 빠른 순서대로 출력하시오
--입사일자가 같은 경우 급여가 많은 사원부터 출력하시오
SELECT employee_id, hire_date, salary
FROM employees
ORDER BY hire_date ASC, salary DESC;