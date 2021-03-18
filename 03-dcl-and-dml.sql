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
GRANT create session TO C##KHOH;
/* 로그인 해서 다음의 쿼리 수행
CREATE TABLE test(a NUMBER); -- 권한 불충분
*/
GRANT connect, resource TO C##KHOH; -- 접속과 자원 접근 롤을 부여

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
-- HR 계정의 employees 테이블 조회 권한을 C##KHOH에게 부여하고 싶다면 
GRANT SELECT ON hr.employees TO C##KHOH;

-- C##KHOH로 진행
SHOW USER;
SELECT * FROM hr.employees;
