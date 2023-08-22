CREATE SEQUENCE order_seq;

CREATE SEQUENCE test_seq;
DROP SEQUENCE test_seq;

CREATE SEQUENCE test_seq
START WITH 11
INCREMENT BY 2
MAXVALUE 30
MINVALUE 0
CYCLE;
--오래된 오라클일수록 캐쉬가 휘발되는 경우가 많음, 고로 캐쉬 사용하지 말라고 설정해줘야 함

CREATE SEQUENCE test_seq
START WITH 11 --일련번호 11부터 시작
INCREMENT BY 2
MAXVALUE 30
MINVALUE 0
NOCACHE --캐쉬 설정하지 말라는 의미
CYCLE;

--일련번호 발급하기
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
SELECT test_seq.NEXTVAL FROM dual; --MAXVALUE이 넘어가면서 0이 됨

--현재일련번호 확인하기 : NEXTVAL 사용후에만 사용 가능하다
SELECT test_seq.CURRVAL FROM dual;

SELECT * FROM order_info;

DROP SEQUENCE order_seq; --다시 만들기 위해 삭제
CREATE SEQUENCE order_seq
START WITH 4; --일련번호가 4부터 시작

--주문기본정보추가
INSERT INTO order_info(order_no, order_id) VALUES (order_seq.NEXTVAL, 'A');
SELECT * FROM order_info;

--주문상세정보추가
INSERT INTO order_line(order_line_no, order_prod_no, order_quantity) VALUES (order_seq.CURRVAL, 'C0001', 1);
INSERT INTO order_line(order_line_no, order_prod_no, order_quantity) VALUES (order_seq.CURRVAL, 'F0001', 2);
SELECT* FROM order_line;

ROLLBACK;
SELECT * FROM order_info;
SELECT* FROM order_line; 
--작업이 모두 취소됨

SELECT employee_id, first_name, hire_date, salary FROM employees WHERE department_id=60;