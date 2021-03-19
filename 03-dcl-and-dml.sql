-- system 접속
-- 사용자 정보 확인
-- USER_USERS: 현재 사용자 관련 정보
-- ALL_USERS: DB의 모든 사용자 정보
-- DB_USERS: 모든 사용자의 상세 정보(DBA Only)

-- 현재 사용자 확인
SELECT * FROM USER_USERS;
-- 전체 사용자 확인
SELECT * FROM ALL_USERS;

-- 로그인 권한 부여
CREATE USER C##KHOH IDENTIFIED BY 1234; -- 로그인할 수 없는 상태
--권한 부여 필요
GRANT create session TO C##KHOH;
/* 로그인 해서 다음의 쿼리 수행
CREATE TABLE test(a NUMBER); -- 권한 불충분
*/
GRANT connect, resource TO C##KHOH; -- 접속과 자원 접근 롤을 부여
-- 일반 데이터베이스 사용자의 권한 부여


/* 다시 로그인 해서 다음의 쿼리 수행
CREATE TABLE test(a NUMBER); -- 권한 불충분
SELECT * FROM tab;
DESC test;
INSERT INTO test
VALUES(10);
*/

/*
 Oracle 12이후
 일반 계정 구분하기 위해 C## 접두어
 실제 데이터가 저장될 테이블 스페이스 마련해 줘야함 - USERS 테이블 스페이스에 공간 마련
*/

-- C## 없이 계정 생성하는 방법
ALTER SESSION SET "_ORACLE_SCRIPT" = true;
CREATE USER KHOH IDENTIFIED BY 1234;
-- 사용자 데이터 저장 테이블 스페이스 부여
ALTER USER C##KHOH DEFAULT TABLESPACE USERS -- C##KHOH 사용자의 저장 공간을 USERS에 마련
    QUOTA unlimited ON USERS; -- 저장 공간 한도를 무한으로 부여

-- ROLE의 생성
DROP ROLE dbuser;
CREATE ROLE dbuser; -- dbuser 역할을 만들어 여러개의 권한을 담아둔다.
GRANT create session TO dbuser; -- dbuser 역할에 접속할 수 있는 권한을 부여한다.
GRANT resource TO dbuser;     -- dbuser 역할에 자원 생성 권한을 부여한다.

-- ROLE을 GRANT 하면 내부에 있는 개별 Privilege(권한)이 모두 부여된다.
GRANT dbuser TO KHOH;   -- KHOH 사용자에게 dbuser 역할을 부여한다.
-- 권한의 회수 REVOKE
REVOKE dbuser FROM KHOH; -- KHOH 사용자로부터 dbuser 역할 회수

-- 계정 삭제
DROP USER KHOH CASCADE; 

-- 현재 사용자에게 부여된 ROLE 확인
-- 사용자 계정으로 로그인
show user;
SELECT * FROM user_role_privs;

-- CONNECT 역할에는 어떤 권한이 포함되어 있는가?
DESC role_sys_privs;
SELECT * FROM role_sys_privs WHERE role = 'CONNECT'; -- CONNECT롤이 포함하고 있는 권한
SELECT * FROM role_sys_privs WHERE role = 'RESOURCE';

SHOW USER;
-- System 계정으로 진행
-- HR 계정의 employees 테이블 조회 권한을 C##KHOH에게 부여하고 싶다면 (system)
GRANT SELECT ON hr.employees TO C##KHOH;    -- 권한의 부여
REVOKE SELECT ON hr.employees FROM C##KHOH;  -- 권한의 회수

-- C##KHOH로 진행
SHOW USER;
SELECT * FROM hr.employees;


--------
-- DDL
--------
-- 내가 가진 테이블 확인
SELECT * FROM tab;
-- 테이블의 구조 확인
DESC test;

-- 테이블 삭제
DROP TABLE test;
SELECT * FROM tab;
-- 휴지통
PURGE RECYCLEBIN; -- 삭제된 테이블은 휴지통에 보관

SELECT * FROM tab;

-- CREATE TABLE
CREATE TABLE book ( -- 컬럼 명세
    book_id NUMBER(5), -- 5자리 숫자
    title VARCHAR2(50), -- 50글자 가변문자
    author VARCHAR2(10), -- 10글자 가변문자열
    pub_date DATE DEFAULT SYSDATE -- 기본값은 현재시간
);

-- 서브쿼리를 활용한 테이블 생성
-- hr.employees 테이블을 기반으로 일부 데이터를 추출
-- 새 테이블
SELECT * FROM hr.employees WHERE job_id like 'IT_%';
CREATE TABLE it_emps AS (
    SELECT * FROM hr.employees WHERE job_id like 'IT_%'
);
    

SELECT * FROM it_emps;
CREATE TABLE emp_summary AS (
    SELECT employee_id,
        first_name || ' ' || last_name full_name,
        hire_date, salary
    FROM hr.employees
);
DESC emp_summary;
SELECT * FROM emp_summary;

-- author 테이블
DESC book;
CREATE TABLE author (
    author_id NUMBER(10),
    author_name VARCHAR2(100) NOT NULL, -- NULL일 수 없다.
    author_desc VARCHAR2(500),
    PRIMARY KEY (author_id) -- author_id 컬럼을 PK로
);
DESC author;

-- book 테이블에 author 테이블 연결을 위해
-- book 테이블의 author 컬럼을 삭제
ALTER TABLE book
DROP COLUMN author;
DESC book;

-- author테이블 참조를 위한 author_id 컬럼을 book에 추가
ALTER TABLE book
ADD (author_id NUMBER(10));
DESC book;

-- book 테이블의 PK로 사용할 book_id도 NUMBER(10)으로 변경
ALTER TABLE book 
MODIFY (book_id NUMBER(10));
DESC book;

-- 제약조건의 추가: ADD CONSTARINT
-- book 테이블의 book_id를 PRIMARY KEY 제약조건 부여
ALTER TABLE book
ADD CONSTRAINT pk_book_id PRIMARY KEY(book_id);
DESC book;

