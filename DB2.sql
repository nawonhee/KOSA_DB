--����Ŭ �����Լ�
--1.�������Լ�
SELECT ROUND(1234.567)  --�ݿø�
FROM employees;

--�ݿø�
SELECT ROUND(1234.567)
    ,ROUND(1234.567,0) --�ݿø�
    ,ROUND(1234.567,1) --�Ҽ������� ���ڸ����� �����شٴ� �ǹ� (�ݿø�X)
    ,ROUND(1234.567,-1) --1���ڸ� ������ ��Ÿ����
FROM dual; --�׽�Ʈ ������ �� �� dual ���̺� �̿�

--������
SELECT TRUNC(1234.567)
    ,TRUNC(1234.567,0)
    ,TRUNC(1234.567,1)
    ,TRUNC(1234.567,-1)
FROM dual;

--�ø�,����
SELECT CEIL(1234.1)
    ,FLOOR(1234.1)
FROM dual;

--����� ���, �޿�, �����, �Ǳ޿�, �Ǳ޿�/12 ���
--�Ǳ޿�: �޿�+(�޿�*�����) -> ��Ʈ : NVL()
SELECT employee_id, salary, commission_pct, salary+(salary*NVL(commission_pct,0)), (salary+(salary*NVL(commission_pct,0)))/12
FROM employees;

--����� ���, �޿�, �����, �Ǳ޿�, �ǿ��� ����Ѵ�. ��, �ǿ����� �Ҽ�������2�ڸ����� �ݿø��Ѵ�.
SELECT employee_id, salary, commission_pct, salary+(salary*NVL(commission_pct,0)), ROUND((salary+(salary*NVL(commission_pct,0)))/12, 1)
FROM employees;

--2. �������Լ�
SELECT LENGTH('HELLOORACLE') --11byte ���ڰ���
    ,LENGTH('�ȳ��ϼ���') --5 ���ڰ���
    ,LENGTHB('�ȳ��ϼ���') --15 ����Ʈ��
    ,INSTR('HELLOORACLE','L') --3 ������ ��ġ
    ,INSTR('HELLOORACLE','L',5) --10 ������ ��ġ�� ã�µ�, 5��° ���ں��� �����ؼ� ã��
FROM dual;

SELECT SUBSTR('HELLOORACLE',2,3) --2��° ���ڿ��� 3���� �����Ͷ�
    ,LPAD('HELLO',8,'*') --***HELLO *�� ���ʿ������� ���� 8 �ǵ��� ������
    ,'BEGIN'||LTRIM('   HELLO   ')||'END' --���� ���� ���ְ� �տ� BEGIN, �ڿ� END���� ���
    ,'BEGIN'||RTRIM('   HELLO   ')||'END' --������ ���� ���ְ� �տ� BEGIN, �ڿ� END���� ���
    ,'BEGIN'||TRIM('   HELLO   ')||'END' --���� ���� ���ְ� �տ� BEGIN, �ڿ� END���� ���
FROM dual;

--����� �̸��� �ι�°���ڰ� 'e'�� ������� ���, �̸��� ����Ͻÿ�
SELECT employee_id, first_name
FROM employees
WHERE INSTR(first_name,'e')=2;

SELECT employee_id, first_name
FROM employees
WHERE INSTR(UPPER(first_name),'E')=2; --�빮�ڷ� �� �ٲٰ� E�� ��

--3.��¥�� �Լ�
SELECT SYSDATE
    ,MONTHS_BETWEEN(SYSDATE,'23/01/01') --�ð������� �����Ͽ� ������ ������ ��ȯ
    ,ADD_MONTHS(SYSDATE,1) --���� ���� �Ѵ� �� ��¥
    ,ADD_MONTHS(SYSDATE,-6) --���� ���� 6���� �� ��¥
    ,LAST_DAY('23/02/16') --���� 2���� ������ ��¥�� ���
    ,NEXT_DAY(SYSDATE,'�Ͽ���') --���� ��¥�� �������� ������ �ٰ��� �Ͽ����� ��¥
FROM dual;

SELECT SYSDATE
    ,SYSDATE+1 "���ϳ�¥"
    ,SYSDATE-1 "������¥"
--    ,SYSDATE-'23/01/01' ���ڷ� �ν��ؼ� ������ ����
    ,SYSDATE-TO_DATE('23/01/01') "�ϼ�"
    ,TRUNC(SYSDATE-TO_DATE('23/01/01'))
FROM dual;

--4.����ȯ�Լ�
--�ڵ�����ȯ : ������ <-> ������ <-> ��¥��
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

--(1)TO_DATE: ������->��¥��
SELECT TO_DATE('23/12/22'),TO_DATE('23-12-22'),TO_DATE('12-22-23 09:10:35','mm-dd-yy HH24:mi:ss')
FROM dual;

--(2)TO_CHAR : ��¥��->������
SELECT TO_CHAR(SYSDATE)
    ,TO_CHAR(SYSDATE,'yy/mm/dd hh24:mi:ss')
FROM dual;

--����� ���, �Ի���, �ٹ��ϼ�, 22��12��31�ϱ����� �ٹ��ϼ��� ����Ͻÿ�
SELECT employee_id, hire_date
    ,TRUNC(SYSDATE-hire_date) "���ñ����� �ٹ��ϼ�"
    ,TRUNC(TO_DATE('22/12/31')-hire_date) 
FROM employees;

--8���Ի��ڵ��� ���, �Ի����ڸ� ����Ͻÿ�
SELECT employee_id, hire_date, TO_CHAR(hire_date,'day')
FROM employees
WHERE TO_CHAR(hire_date,'mm')='08';

SELECT TO_NUMBER('1,234.5','9,999.9')
    ,TO_NUMBER('1,234,567.8','9,999,999,999.9') --���� ���ڿ� ������ �� ū �ڸ����� ��������� ��
    ,TO_CHAR(1234.5,'9,999.9')
    ,TO_CHAR(1234567.8,'9,999.9') --�����ڸ������� ���� �����ڸ����� ��� ####
FROM dual;

SELECT TO_CHAR('1234.5','9,999,999.9')
    ,TO_CHAR('1234.5','0,000,000.0')
FROM dual;

SELECT TO_CHAR(1234.5,'L9,999,999.00')
FROM dual;

SELECT employee_id, commission_pct, NVL2(commission_pct,'��������','�������') --ù��°���ڰ��� NULL�̸� ����°���ڰ��� ��ȯ
FROM employees;

SELECT employee_id, commission_pct, NVL2(TO_CHAR(commission_pct),'��������','�������')
FROM employees;

SELECT NULLIF(10,10) --ù��°���ڰ��� �ι�° ���ڰ��� ������ NULL�� ��ȯ, �ٸ��� ù��° ���ڰ��� ��ȯ
    ,NULLIF('hello','hi') 
FROM dual;

SELECT employee_id, department_id
FROM employees
--WHERE department_id = NULL; --�񱳰�� ��ü�� false�� ��ȯ, �� ����� ����. null�� �񱳿����� ���� �� ��
WHERE department_id IS NULL;

--�Ϲ��Լ�
SELECT NVL(commission_pct,0) 
    ,DECODE(commission_pct, null, 0, commission_pct) --������� NULL�̶�� 0�� ���, �ƴ϶�� ����� ���
FROM employees;

SELECT NVL2(commission_pct, '��������','�������')
    ,DECODE(commission_pct, null, '�������','��������')
FROM employees;

--��������� '�������'����ϰ� ������ 0.1�� ��� 'B���', �� ���� ��쿡�� 'A���'�� ����Ͻÿ�
SELECT employee_id, commission_pct
    ,DECODE(commission_pct, null, '�������', 0.1, 'B���','A���')
FROM employees;

SELECT employee_id, commission_pct
    ,CASE commission_pct WHEN 0.1 THEN 'B���'
                         ELSE          'A���'
    END
FROM employees;

--��������� '�������'�� ����ϰ� 
--������ 0.1~0.19������ 'F���', 
--0.2~0.29������ 'E���', 
--0.3~0.39������ 'D', 
--0.4~0.49������ 'C'
--0.5~0.59������ 'B'
--0.6�̻��� 'A'

SELECT employee_id, commission_pct
    ,CASE WHEN commission_pct >=0.6 THEN 'A'
          WHEN commission_pct >=0.5 THEN 'B'
          WHEN commission_pct >=0.4 THEN 'C'
          WHEN commission_pct >=0.3 THEN 'D'
          WHEN commission_pct >=0.2 THEN 'E'
          WHEN commission_pct >=0.1 THEN 'F'
          --ELSE '�������'
          WHEN commission_pct IS NULL THEN '�������'
    END
FROM employees;

SELECT COUNT(*) "��ü�����" --107
    ,COUNT(commission_pct) "����޴»����"
    ,COUNT(department_id) "�μ���ġ���������"
FROM employees;

--�������Լ�

SELECT SUM(salary) "�ѱ޿�"
    ,AVG(salary) "��ձ޿�"
FROM employees;

SELECT MAX(salary),MIN(salary)
FROM employees;

--�׷�ȭ GROUP BY
--�μ��� �μ���ȣ,������� ����Ͻÿ�
SELECT department_id, COUNT(*)
FROM employees
GROUP BY department_id;

SELECT department_id
    , COUNT(*) "�μ��������"
    ,MAX(salary)"�μ��� �ִ�޿�"
    ,AVG(salary)"�μ��� ��ձ޿�"
FROM employees
GROUP BY department_id;

--�μ��� �μ���ȣ�� �ִ�޿�, �ִ�޿��� �̸��� ����Ͻÿ� (SUBQUERY�� �ذ��ؾ� ��)
SELECT department_id, MAX(salary), first_name
FROM employees
GROUP BY department_id;

--�μ���, ������ �μ���ȣ, ������ȣ, ������� ����Ͻÿ�
SELECT department_id, job_id, COUNT(*)
FROM employees
GROUP BY department_id, job_id
ORDER BY department_id, COUNT(*);

SELECT department_id, job_id, COUNT(*)
FROM employees
--GROUP BY department_id, job_id
GROUP BY ROLLUP(department_id,job_id)
ORDER BY department_id, COUNT(*);

--30, 50�� �μ��� �μ��� �μ���ȣ, ��ձ޿�, �ִ�޿�
SELECT department_id, AVG(salary), MAX(salary)
FROM employees
WHERE department_id IN(30,50)
GROUP BY department_id;

--�μ��� �μ��� �μ���ȣ, ��ձ޿�, �ִ�޿��� ����Ͻÿ�
--�μ��� ���� ������� ������� �ʴ´�
SELECT department_id,AVG(salary),MAX(salary)
FROM employees
WHERE department_id IS NOT NULL
GROUP BY department_id;

--�μ��� �μ���ȣ, ��ձ޿�, �ִ�޿�, �ּұ޿��� ����Ͻÿ�
--��ձ޿��� 10000�̻��� �μ��� ����Ͻÿ�
SELECT department_id, AVG(salary), MAX(salary), MIN(salary)
FROM employees
GROUP BY department_id
HAVING AVG(salary)>=10000; --�׷쿡 ���� �����̹Ƿ� HAVING�� �̿�

--�Ի����ڰ� ���� ������� ����Ͻÿ�
SELECT employee_id, hire_date, salary
FROM employees
ORDER BY hire_date ASC;

--�޿��� ���� ������� ����Ͻÿ�
SELECT employee_id, hire_date, salary
FROM employees
ORDER BY salary DESC;

--�Ի����ڰ� ���� ������� ����Ͻÿ�
--�Ի����ڰ� ���� ��� �޿��� ���� ������� ����Ͻÿ�
SELECT employee_id, hire_date, salary
FROM employees
ORDER BY hire_date ASC, salary DESC;