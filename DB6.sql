CREATE SEQUENCE order_seq;

CREATE SEQUENCE test_seq;
DROP SEQUENCE test_seq;

CREATE SEQUENCE test_seq
START WITH 11
INCREMENT BY 2
MAXVALUE 30
MINVALUE 0
CYCLE;
--������ ����Ŭ�ϼ��� ĳ���� �ֹߵǴ� ��찡 ����, ��� ĳ�� ������� ����� ��������� ��

CREATE SEQUENCE test_seq
START WITH 11 --�Ϸù�ȣ 11���� ����
INCREMENT BY 2
MAXVALUE 30
MINVALUE 0
NOCACHE --ĳ�� �������� ����� �ǹ�
CYCLE;

--�Ϸù�ȣ �߱��ϱ�
SELECT test_seq.NEXTVAL FROM dual; --11
SELECT test_seq.NEXTVAL FROM dual; --13
SELECT test_seq.NEXTVAL FROM dual; --15
SELECT test_seq.NEXTVAL FROM dual; --17
SELECT test_seq.NEXTVAL FROM dual; --19
SELECT test_seq.NEXTVAL FROM dual; --21
SELECT test_seq.NEXTVAL FROM dual; --23
SELECT test_seq.NEXTVAL FROM dual; --25
SELECT test_seq.NEXTVAL FROM dual; --27
SELECT test_seq.NEXTVAL FROM dual; --29
SELECT test_seq.NEXTVAL FROM dual; --MAXVALUE�� �Ѿ�鼭 0�� ��

--�����Ϸù�ȣ Ȯ���ϱ� : NEXTVAL ����Ŀ��� ��� �����ϴ�
SELECT test_seq.CURRVAL FROM dual;

SELECT * FROM order_info;

DROP SEQUENCE order_seq; --�ٽ� ����� ���� ����
CREATE SEQUENCE order_seq
START WITH 4; --�Ϸù�ȣ�� 4���� ����

--�ֹ��⺻�����߰�
INSERT INTO order_info(order_no, order_id) VALUES (order_seq.NEXTVAL, 'A');
SELECT * FROM order_info;

--�ֹ��������߰�
INSERT INTO order_line(order_line_no, order_prod_no, order_quantity) VALUES (order_seq.CURRVAL, 'C0001', 1);
INSERT INTO order_line(order_line_no, order_prod_no, order_quantity) VALUES (order_seq.CURRVAL, 'F0001', 2);
SELECT* FROM order_line;

ROLLBACK;
SELECT * FROM order_info;
SELECT* FROM order_line; 
--�۾��� ��� ��ҵ�

SELECT employee_id, first_name, hire_date, salary FROM employees WHERE department_id=60;