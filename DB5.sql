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

INSERT INTO customer(id,pwd,name) VALUES ('A',NULL,'A'); --세번째 not null조건 있어서 오류
INSERT INTO customer(id,pwd,name) VALUES ('B','b','B');
INSERT INTO customer(id,pwd,name) VALUES ('B','b11','B11'); --
INSERT INTO customer VALUES('A','a','A');
INSERT INTO customer VALUES('C','c','C');

SELECT * FROM user_constraints WHERE table_name='CUSTOMER';

INSERT INTO product(prod_no,prod_name,prod_price) VALUES ('C0001','아메리카노',1000);
INSERT INTO product(prod_no,prod_name,prod_price) VALUES ('C0002', '아이스아메리카노', 1000);
INSERT INTO product(prod_no,prod_name,prod_price) VALUES ('C0003','라테',1500);
INSERT INTO product(prod_no,prod_name,prod_price) VALUES ('C0004', '아이스라테', 1500);
INSERT INTO product(prod_no,prod_name,prod_price) VALUES ('C0005','카푸치노',1500);

INSERT INTO order_info(order_no, order_id) VALUES (1,'A');
INSERT INTO order_info(order_no, order_id) VALUES (1,'X'); --부모키 못 찾아서 안 됨
INSERT INTO order_info(order_no, order_id) VALUES (2,'X'); --부모키 못 찾아서 안 됨
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

--참조 안 된 상품 수정
UPDATE product SET prod_no = 'F0001', prod_name='바나나' WHERE prod_no='C0003';
SELECT * FROM product;

--참조된 상품 수정
UPDATE product SET prod_no='X' WHERE prod_no='C0001'; --PK는 건드는 게 아님
UPDATE product SET prod_price = prod_price+100 WHERE prod_no = 'C0001';

--CHECK 제약조건
UPDATE product SET prod_price=-1 WHERE prod_no='F0001'; --ERROR

--참조 안 된 상품을 삭제한다
DELETE product WHERE prod_no='C0004';

--참조된 상품을 삭제한다
DELETE product WHERE prod_no='C0001';

--뷰객체
--주문번호, 주문자아이디, 주문상품번호, 상품명, 가격, 주문수량, 주문일자를 출력하시오
SELECT info.order_no, order_id, order_prod_no, prod_name, prod_price, order_quantity, order_dt
FROM order_info info JOIN order_line line ON(info.order_no = line.order_line_no)
JOIN product p ON (line.order_prod_no = p.prod_no);

CREATE VIEW vw_order AS SELECT info.order_no, order_id, order_prod_no, prod_name, prod_price, order_quantity, order_dt
FROM order_info info  JOIN order_line line ON(info.order_no = line.order_line_no)
JOIN product p ON (line.order_prod_no = p.prod_no);

SELECT * 
FROM vw_order;

CREATE OR REPLACE VIEW vw_order
AS SELECT info.order_no "주문번호", order_id "주문자아이디", order_prod_no "상품번호", prod_name "상품명", prod_price "상품가격", order_quantity "주문수량", order_dt"주문날짜"
FROM order_info info JOIN order_line line ON (info.order_no = line.order_line_no)
JOIN product p ON(line.order_prod_no = p.prod_no);

SELECT * FROM vw_order;
SELECT 주문번호 FROM vw_order;
--SELECT order_no FROM vw_order; -- error

DROP VIEW vw_order;