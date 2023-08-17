SELECT employee_id, first_name, department_id
FROM employees; --107��

SELECT department_id, department_name
FROM departments; --27��

--īƼ�ǰ�
--����� ���, �̸�, �μ���ȣ, �μ����� ����Ͻÿ�
SELECT employee_id, first_name, e.department_id, d.department_id, department_name
FROM employees e, departments d; --107��*27��

--����� ���, �̸�, �μ���ȣ, �μ����� ����Ͻÿ�(106��)
SELECT employee_id, first_name, e.department_id, d.department_id, department_name
FROM employees e, departments d
WHERE e.department_id = d.department_id;

--ǥ��ȭ�� ANSI JOIN��
SELECT employee_id, first_name, e.department_id, d.department_id, department_name
FROM employees e JOIN departments d
ON (e.department_id=d.department_id);

--����� ���, �̸�, �μ���ȣ, �μ���, �μ��� ���� ���ø��� ����Ͻÿ�
SELECT * FROM departments;
SELECT * FROM locations WHERE location_id=1700;

SELECT employee_id, first_name, e.department_id, d.department_id, department_name, city
FROM employees e
JOIN departments d ON (e.department_id=d.department_id) 
JOIN locations l ON (d.location_id = l.location_id );

--NATURAL JOIN
--����� ���, �̸�, ������ȣ, �������� ����Ͻÿ�
SELECT employee_id, first_name, job_id, job_title
FROM employees
NATURAL JOIN jobs;
--JOIN jobs j ON (e.job_id = j.job_id);

--JOIN USING
--����� ���, �̸�, �μ���ȣ, �μ����� ����Ͻÿ�
SELECT employee_id, first_name, department_id, department_name
FROM employees
JOIN departments USING (department_id);

--OUTER JOIN
--����� ���, �̸�, �μ���ȣ, �μ����� ����Ͻÿ�. �� �μ����� ����� ����Ͻÿ�
SELECT employee_id, first_name, d.department_id, department_name
FROM employees e LEFT OUTER JOIN departments d ON(e.department_id=d.department_id);

--����� ���, �̸�, �μ���ȣ, �μ����� ����Ͻÿ�. �� ������� �μ��� ����Ͻÿ�
SELECT employee_id, first_name, d.department_id, department_name
FROM employees e RIGHT JOIN departments d ON(e.department_id=d.department_id);

--����� ���, �̸�, �μ���ȣ, �μ����� ����Ͻÿ�. �� ������� �μ���, �μ����� ����� ���
SELECT employee_id, first_name, d.department_id, department_name
FROM employees e FULL JOIN departments d ON(e.department_id=d.department_id);

--����Ŭ���� OUTER JOIN
SELECT employee_id, first_name, d.department_id, department_name
FROM employees e , departments d 
WHERE e.department_id=d.department_id(+);

--SELF JOIN
--����� ���, �̸�, �����ڹ�ȣ, �������̸��� ����Ͻÿ�
SELECT e.employee_id "���", e.first_name "�̸�", e.manager_id "�����ڹ�ȣ", m.first_name "�������̸�"
FROM employees e JOIN employees m ON (e.manager_id=m.employee_id);



--1.�μ��� �μ���ȣ, �μ��� ���� ������ ���ø�(city), ������(country_name)�� ����Ͻÿ�
SELECT d.department_id "�μ���ȣ", l.city "���ø�", c.country_name "������"
FROM departments d
JOIN locations l ON (d.location_id=l.location_id)
JOIN countries c ON (l.country_id=c.country_id);

--2. ����� ���, �μ���ȣ, �μ���, ������ȣ, �������� ����Ͻÿ�
    --������ 'Manager'�� ������ ����鸸 ����Ͻÿ�
   --������ȣ��, �μ������� ���������Ͻÿ�
SELECT e.employee_id "���", e.department_id"�μ���ȣ", d.department_name"�μ���", e.job_id"������ȣ", j.job_title"������"
FROM employees e JOIN jobs j ON(e.job_id=j.job_id)
JOIN departments d ON (d.department_id=e.department_id)
--WHERE j.job_title LIKE '%Manager%'
WHERE INSTR(j.job_title,'Manager')>0
ORDER BY j.job_id ASC, d.department_name ASC;

--3. �μ��� �μ���ȣ, �μ���, �����, ��ձ޿��� ����Ͻÿ�
SELECT d.department_id "�μ���ȣ", d.department_name "�μ���", COUNT(*) "�����", AVG(salary)"��ձ޿�"
FROM employees e JOIN departments d ON (e.department_id = d.department_id)
GROUP BY d.department_id, d.department_name;

--4. �μ��� ������� 10���̻��� �μ����� �μ��� �μ���ȣ, �μ���, �����, ��ձ޿��� ����Ͻÿ�
SELECT d.department_id "�μ���ȣ", d.department_name "�μ���", COUNT(*) "�����", AVG(salary) "��ձ޿�"
FROM employees e JOIN departments d ON (e.department_id=d.department_id)
GROUP BY d.department_id, d.department_name
HAVING COUNT(*)>=10;

--5.����� �μ���ȣ�� �������� �μ���ȣ�� ��ġ�����ʴ� ����� ���, �μ���ȣ�� ����Ͻÿ� 
--��������� �������� �����Ͻÿ�
SELECT e.employee_id "���", e.department_id "�μ���ȣ"
FROM employees e JOIN employees m ON (e.manager_id=m.employee_id)
WHERE e.department_id != m.department_id
ORDER BY e.employee_id ASC;

--6. �� ���ÿ� �ִ� �μ����� ����Ͻÿ�
SELECT l.city "����", COUNT(d.department_id) "�μ���"
FROM departments d JOIN locations l ON(d.location_id = l.location_id)
GROUP BY l.city;


--7.�� ���ÿ� �ִ� �μ����� ����Ͻÿ�.  ��, �μ��� ���� ���õ� ��� ����Ͻÿ�
SELECT l.city "����", COUNT(d.department_id) "�μ���"
FROM departments d RIGHT JOIN locations l ON(d.location_id = l.location_id)
GROUP BY l.city;

SELECT *
FROM job_history;

SELECT *
FROM employees
WHERE employee_id=176;

--����� ���, ����������ȣ�� ����Ͻÿ�
--����� ���, ������ȣ�� ����Ͻÿ�
SELECT employee_id, job_id
FROM job_history
UNION
SELECT employee_id, job_id
FROM employees
ORDER BY employee_id; --���� ���� �� �ǰ� �� �ؿ� �ִ� ������ �� �� ����

SELECT employee_id, job_id
FROM job_history
UNION ALL -- �ߺ��� ���
SELECT employee_id, job_id
FROM employees
ORDER BY employee_id; --���� ���� �� �ǰ� �� �ؿ� �ִ� ������ �� �� ����

--���������� �ٸ� ������ ���� ������� ���, ���������� ����Ͻÿ�
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

--�μ��� �ִ�޿��� �޴� ����� �μ���ȣ, ���, �̸�, �޿��� ����Ͻÿ�
--1)�μ��� �ִ�޿��� ����Ѵ�
SELECT department_id, employee_id, first_name, MAX(salary)
FROM employees
GROUP BY department_id;
--2) 1���� ���� �޿��� �޴� ����� ���, �̸�, �޿��� ����Ͻÿ�
SELECT department_id, employee_id, first_name, salary
FROM employees
WHERE (department_id, salary) IN (SELECT department_id, MAX(salary)  --�� �����ֱ�
FROM employees 
GROUP BY department_id);

--�ִ�޿����� ���, �̸�, �޿��� ����Ͻÿ�
SELECT employee_id, first_name, salary
FROM employees
WHERE salary = (SELECT MAX(salary) FROM employees);

--������� ��ձ޿����� ���� �޿��� �޴� ����� ���, �̸�, �޿��� ����Ͻÿ�
SELECT employee_id, first_name, salary
FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees);

--���������� �ִ� �������� �����ڹ�ȣ, �̸� ����Ͻÿ�
SELECT employee_id, first_name
FROM employees
WHERE employee_id IN (SELECT manager_id FROM employees);

SELECT employee_id, first_name
FROM employees
WHERE employee_id IN (null,100,102,103,101,108);

--���������� ���� ������� ���, �̸��� ����Ͻÿ�
SELECT employee_id, first_name
FROM employees
--WHERE employee_id NOT IN (SELECT NVL(manager_id,-1) FROM employees);
WHERE employee_id NOT IN (SELECT manager_id FROM employees WHERE manager_id IS NOT NULL);

SELECT employee_id, first_name
FROM employees
WHERE employee_id NOT IN (null,100,102,103,101,108);