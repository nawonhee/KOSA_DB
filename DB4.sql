--����� ���, �̸�, �޿��� ����Ͻÿ�
SELECT employee_id, first_name, salary
FROM employees
ORDER BY salary DESC;

--ROWNUM : ���ȣ
--����� ���ȣ, ���, �̸�, �޿��� ����Ͻÿ�
SELECT ROWNUM, employee_id, first_name, salary
FROM employees
ORDER BY salary DESC; --���ȣ�� ���� �߱޵Ǵٺ��� ���ĵ� �� ���� �ڼ��δ�

SELECT ROWNUM, employee_id, first_name, salary
FROM (SELECT employee_id, first_name, salary
    FROM employees
    ORDER BY salary DESC);
    
--TOP-N Query
--����� ���, �̸�, �޿��� ����Ͻÿ�. ���� �޿��� �޴� ��� 5�� ����Ѵ�
SELECT ROWNUM, employee_id, first_name, salary
FROM (SELECT employee_id, first_name, salary
    FROM employees
    ORDER BY salary DESC)
WHERE ROWNUM BETWEEN 1 AND 5;

--����� ���, �̸�, �޿��� ����Ͻÿ�. ���� �޿��� �޴� ������� �����Ͽ� 11~20��° ����� ����Ѵ�
SELECT *
FROM (SELECT ROWNUM rn, employee_id, first_name, salary --ROWNUM�� 1������ �� �߱޵Ǿ� rn�̶�� ��Ī �ֱ�
    FROM (SELECT employee_id, first_name, salary
            FROM employees
            ORDER BY salary DESC)
    )
WHERE rn BETWEEN 11 AND 20; --��Ī�� ���� ���� ����

--Scalar SubQuery : SELECT������ ����ϴ� SubQuery
--����� ���, �μ���ȣ, �μ����� ����Ͻÿ�
SELECT employee_id, e.department_id, department_name
FROM employees e JOIN departments d ON (e.department_id = d.department_id);

SELECT employee_id, department_id
    , (SELECT department_name
        FROM departments 
        WHERE department_id = e.department_id)
FROM employees e;

--�μ����� 'IT'�� �μ��� �ٹ��ϴ� ������� ���, �̸��� ����Ͻÿ� 
SELECT employee_id, first_name
FROM employees 
WHERE department_id = (SELECT department_id FROM departments WHERE department_name = 'IT');

--�̸��� 'Bruce'�� ����� ���� �μ��� �ٹ��ϴ� ������� ���, �̸��� ����Ͻÿ�
SELECT employee_id, first_name
FROM employees
WHERE (department_id = (SELECT department_id FROM employees WHERE first_name = 'Bruce'))
    AND (first_name <> 'Bruce');
    
--�̸��� 'Bruce'�� ����� ���� �μ��� �ٹ��ϸ鼭
--�μ���ձ޿����� ���� �޿��� �޴� ����� ���, �̸�, �޿��� ����Ͻÿ�
SELECT employee_id, first_name, salary
FROM employees e
WHERE (department_id = (SELECT department_id FROM employees WHERE first_name = 'Bruce'))
    AND (salary > (SELECT AVG(salary) FROM employees WHERE department_id = e.department_id)); --��ȣ������������ -> �����ս� �� ������

--������ �� ������...
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

--������ �����ؼ� ���̺� ����
CREATE TABLE t_a_copy3 AS SELECT * FROM t_a WHERE 1 = 2;
SELECT * FROM t_a_copy3;

--Į���߰�
ALTER TABLE t_a
ADD six number;

--Į�� �̸�����
ALTER TABLE t_a
RENAME COLUMN six TO six2;

--Į������
ALTER TABLE t_a
DROP COLUMN six2;

--Į�� �ڷ�������/�ڸ�������
ALTER TABLE t_a
MODIFY four VARCHAR2(10);

--���̺� ����
DROP TABLE t_a_copy3;

--������ ����
--t_a���̺��� two�÷����� null�� �ƴϸ� two�÷����� 1.5�� �����Ѵ�
UPDATE t_a
SET two = two*1.5
WHERE two IS NOT NULL;

SELECT * FROM t_a;

--t_a���̺��� two�÷����� null�̸� one�÷����� 1�����ϰ� five�÷����� 1�� �����Ѵ�
UPDATE t_a
SET one = one+1, five = five-1
WHERE two IS NULL;

--������ ����
--t_a���̺��� one�÷����� 4�� ���� �����Ѵ�
DELETE t_a
WHERE one=4;

--t_a���̺��� five�÷����� ������¥ (23/08/17)�� ���� �����Ѵ�
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

--���̺��� �������� ����
CREATE TABLE t_b(
    id varchar2(5),
    pwd varchar2(5),
    status number(1),
    CONSTRAINT t_b_id_pk PRIMARY KEY(id),
    CONSTRAINT t_b_email_uq UNIQUE(email),
    CONSTRAINT t_b_status_ck CHECK(status IN (-1,0,1))
);

--�÷����� �������� �����ϱ� : NOT NULL���������� �ݵ�� �÷������θ� ����
CREATE TABLE t_b(
    id varchar2(5) CONSTRAINT t_b_id_pk PRIMARY KEY,
    pwd varchar2(5) NOT NULL,
    email varchar2(30) CONSTRAINT t_b_email_uq UNIQUE,
    status number(1) CONSTRAINT t_b_stauts_ck CHECK(status IN(-1,0,1))
);