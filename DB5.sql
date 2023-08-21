CREATE TABLE CUSTOMER(
    ID VARCHAR2(5) PRIMARY KEY,
    PWD VARCHAR2(5) NOT NULL,
    NAME VARCHAR2(5)
);

CREATE TABLE PRODUCT(
    prod_no VARCHAR2(5) PRIMARY KEY,
    prod_name VARCHAR2(50) NOT NULL,
    prod_price NUMBER(6) CHECK (prod_price>=0),
    prod_mf_dt DATE,
    prod_detail VARCHAR2(4000)
);

CREATE TABLE order_info(
    order_no NUMBER,
    order_id VARCHAR2(5),
    order_dt DATE DEFAULT SYSDATE);

ALTER TABLE order_info
ADD CONSTRAINT order_info_no_pk PRIMARY KEY(order_no);

ALTER TABLE order_info
ADD CONSTRAINT order_id_fk FOREIGN KEY(order_id) REFERENCES customer(id);


CREATE TABLE order_line(
    order_line_no NUMBER,
    order_prod_no VARCHAR2(5),
    order_quantity NUMBER(3));
    
ALTER TABLE order_line
ADD CONSTRAINT order_line_pk PRIMARY KEY(order_line_no, order_prod_no);

ALTER TABLE order_line
ADD CONSTRAINT order_prod_no_fk FOREIGN KEY(order_prod_no) REFERENCES product(prod_no);

ALTER TABLE order_line
ADD CONSTRAINT order_line_no_fk FOREIGN KEY(order_line_no) REFERENCES order_info(order_no);

INSERT INTO customer(id,pwd,name) VALUES ('A',NULL,'A'); --����° not null���� �־ ����
INSERT INTO customer(id,pwd,name) VALUES ('B','b','B');
INSERT INTO customer(id,pwd,name) VALUES ('B','b11','B11'); --
INSERT INTO customer VALUES('A','a','A');
INSERT INTO customer VALUES('C','c','C');

SELECT * FROM user_constraints WHERE table_name='CUSTOMER';

INSERT INTO product(prod_no,prod_name,prod_price) VALUES ('C0001','�Ƹ޸�ī��',1000);
INSERT INTO product(prod_no,prod_name,prod_price) VALUES ('C0002', '���̽��Ƹ޸�ī��', 1000);
INSERT INTO product(prod_no,prod_name,prod_price) VALUES ('C0003','����',1500);
INSERT INTO product(prod_no,prod_name,prod_price) VALUES ('C0004', '���̽�����', 1500);
INSERT INTO product(prod_no,prod_name,prod_price) VALUES ('C0005','īǪġ��',1500);

INSERT INTO order_info(order_no, order_id) VALUES (1,'A');
INSERT INTO order_info(order_no, order_id) VALUES (1,'X'); --�θ�Ű �� ã�Ƽ� �� ��
INSERT INTO order_info(order_no, order_id) VALUES (2,'X'); --�θ�Ű �� ã�Ƽ� �� ��
INSERT INTO order_info(order_no, order_id) VALUES (2,'B');
INSERT INTO order_info(order_no, order_id) VALUES (3,'A');
SELECT * FROM order_info;

INSERT INTO order_line(order_line_no,order_prod_no,order_quantity) VALUES(1,'C0001',2);
INSERT INTO order_line(order_line_no,order_prod_no,order_quantity) VALUES(1,'C0001',9);
INSERT INTO order_line(order_line_no,order_prod_no,order_quantity) VALUES(2,NULL,9);
INSERT INTO order_line(order_line_no,order_prod_no,order_quantity) VALUES(NULL,'C0001',9);
INSERT INTO order_line(order_line_no,order_prod_no,order_quantity) VALUES(2,'C0001',4);
INSERT INTO order_line(order_line_no,order_prod_no,order_quantity) VALUES(2,'C0002',1);
INSERT INTO order_line(order_line_no,order_prod_no,order_quantity) VALUES(2,'C0005',1);
INSERT INTO order_line(order_line_no,order_prod_no,order_quantity) VALUES(3,'C0002',1);

--���� �� �� ��ǰ ����
UPDATE product SET prod_no = 'F0001', prod_name='�ٳ���' WHERE prod_no='C0003';
SELECT * FROM product;

--������ ��ǰ ����
UPDATE product SET prod_no='X' WHERE prod_no='C0001'; --PK�� �ǵ�� �� �ƴ�
UPDATE product SET prod_price = prod_price+100 WHERE prod_no = 'C0001';

--CHECK ��������
UPDATE product SET prod_price=-1 WHERE prod_no='F0001'; --ERROR

--���� �� �� ��ǰ�� �����Ѵ�
DELETE product WHERE prod_no='C0004';

--������ ��ǰ�� �����Ѵ�
DELETE product WHERE prod_no='C0001';

--�䰴ü
--�ֹ���ȣ, �ֹ��ھ��̵�, �ֹ���ǰ��ȣ, ��ǰ��, ����, �ֹ�����, �ֹ����ڸ� ����Ͻÿ�
SELECT info.order_no, order_id, order_prod_no, prod_name, prod_price, order_quantity, order_dt
FROM order_info info JOIN order_line line ON(info.order_no = line.order_line_no)
JOIN product p ON (line.order_prod_no = p.prod_no);

CREATE VIEW vw_order AS SELECT info.order_no, order_id, order_prod_no, prod_name, prod_price, order_quantity, order_dt
FROM order_info info  JOIN order_line line ON(info.order_no = line.order_line_no)
JOIN product p ON (line.order_prod_no = p.prod_no);

SELECT * 
FROM vw_order;

CREATE OR REPLACE VIEW vw_order
AS SELECT info.order_no "�ֹ���ȣ", order_id "�ֹ��ھ��̵�", order_prod_no "��ǰ��ȣ", prod_name "��ǰ��", prod_price "��ǰ����", order_quantity "�ֹ�����", order_dt"�ֹ���¥"
FROM order_info info JOIN order_line line ON (info.order_no = line.order_line_no)
JOIN product p ON(line.order_prod_no = p.prod_no);

SELECT * FROM vw_order;
SELECT �ֹ���ȣ FROM vw_order;
--SELECT order_no FROM vw_order; -- error

DROP VIEW vw_order;