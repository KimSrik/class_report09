-- ------------------------------------------------------------------------------------------
-- 												데이터베이스 생성 및 초기화,
-- 														권한 초기화 및 생성
-- ------------------------------------------------------------------------------------------

drop database if exists 학사관리_DB;
drop user if exists school_admin@localhost;
create database if not exists 학사관리_DB;
create user school_admin@localhost identified with mysql_native_password by 'school';
grant all privileges on 학사관리_db.* to school_admin@localhost with grant option;

use 학사관리_DB;


-- ------------------------------------------------------------------------------------------
-- 													1. 테이블 생성
-- ------------------------------------------------------------------------------------------

create table 학과(
	학과번호 varchar(20) not null unique,
    학과명 varchar(30) not null,
    학과전화번호 varchar(20) not null,
    primary key(학과번호)
);

-- desc 학과;

create table 학생(
	학생번호	 varchar(20) not null unique,
	학생이름 varchar(20) not null,
	학생주민번호 varchar(14) not null unique,
	학생주소	 varchar(50) not null,
	학생전화번호 varchar(20) not null unique,
	학생이메일 varchar(30) not null unique,
	소속학과번호 varchar(20) not null,
    primary key(학생번호),
    foreign key (소속학과번호) references 학과(학과번호) on update cascade
);

-- desc 학생;

create table 교수(
	교수번호	 varchar(20) not null unique,
	교수이름 varchar(20) not null,
	교수주민번호 varchar(14) not null unique,
	교수주소	 varchar(50) not null,
	교수전화번호 varchar(20) not null unique,
	교수이메일 varchar(30) not null unique,
	소속학과번호 varchar(20) not null,
    primary key(교수번호),
    foreign key (소속학과번호) references 학과(학과번호) on update cascade
);

-- desc 교수;



create table 강좌(
	강좌번호 varchar(20) not null unique,
    강좌명 varchar(30) not null,
    취득학점 int not null,
    강의시간 varchar(20),
    강의실 varchar(45),
    교수번호 varchar(20),
    primary key(강좌번호, 교수번호),
    foreign key(교수번호) references 교수(교수번호)
);

-- desc 강좌;

create table 수강내역( 
	출석점수 int not null,
    중간고사점수 int not null,
    기말고사점수 int not null,
    기타점수 int not null,
    총점 int not null,
    평점 varchar(2) not null,
    학생번호 varchar(20) not null,
    교수번호 varchar(20) not null,
    강좌번호 varchar(20) not null,
    primary key(학생번호, 교수번호, 강좌번호),
    foreign key(학생번호) references 학생(학생번호),
    foreign key(교수번호, 강좌번호) references 강좌(교수번호, 강좌번호)
);

-- desc 수강내역;

create table 현재학년학기(
	현재학년학기 varchar(10) not null,
    학생번호 varchar(20) not null,
    교수번호 varchar(20) not null,
    primary key(학생번호, 교수번호),
    foreign key(학생번호) references 학생(학생번호),
    foreign key(교수번호) references 수강내역(교수번호)
);

-- desc 현재학년학기;




-- 3. 삽입(구현된 데이터베이스에 관련 자료를 입력)
insert into 학과 values('0101', '컴퓨터학과', '031-111-0101');
insert into 학과 values('0102', '전기공학과', '031-111-0102');
insert into 학과 values('0103', '전자공학과', '031-111-0103');
insert into 학과 values('0104', '통신공학과', '031-111-0104');

-- 학과 테이블 데이터 삽입 확인 select 구문
-- select * from 학과;

insert into 학생 values('22010101', '홍길동', '010101-3001001', '인천시 서구 ', '010-0101-0101', 'kdg1@email.com', '0101');
insert into 학생 values('22010102', '김찬영', '010112-3011321', '서울시 강서구', '010-0202-0202', 'kyc1@email.com', '0101');
insert into 학생 values('22010103', '강라율', '010321-4201354', '서울시 영등포구', '010-0303-0303', 'gry3@email.com', '0101');
insert into 학생 values('22010104', '김지훈', '010703-3061771', '경기도 부천시', '010-0404-0404', 'kjh7@email.com', '0101');
insert into 학생 values('22010105', '한현수', '011221-3231871', '경기도 김포시', '010-0505-0505', 'hhs8@email.com', '0101');

insert into 학생 values('22020101', '이예서', '010202-4031123', '제주시 서귀포구', '010-0606-0606', 'hong11@email.com', '0102');
insert into 학생 values('22020102', '지윤수', '010221-3301511', '서울시 용산구', '010-0707-0707', 'hong12@email.com', '0102');
insert into 학생 values('22020103', '오윤진', '010401-4001401', '서울시 강동구', '010-0808-0808', 'hong13@email.com', '0102');
insert into 학생 values('22020104', '김성진', '011001-3301041', '서울시 강서구', '010-0909-0909', 'hong14@email.com', '0102');
insert into 학생 values('22020105', '곽진주', '011201-4021071', '인천시 남동구', '010-1010-1010', 'hong15@email.com', '0102');

insert into 학생 values('22030101', '최건', '010131-3031031', '인천시 부평구', '010-1111-1111', 'hong16@email.com', '0103');
insert into 학생 values('22030102', '장효린', '010501-4071401', '인천시 서구', '010-1212-1212', 'hong17@email.com', '0103');
insert into 학생 values('22030103', '우채원', '010611-4022001', '서울시 강남구', '010-1313-1313', 'hong18@email.com', '0103');
insert into 학생 values('22030104', '노다솜', '010807-4071091', '경기도 수원시', '010-1414-1414', 'hong19@email.com', '0103');
insert into 학생 values('22030105', '안준형', '010909-3201051', '인천시 계양구', '010-1515-1515', 'hong20@email.com', '0103');

insert into 학생 values('22040101', '주민지', '010128-4211121', '서울시 강북구', '010-1616-1616', 'hong21@email.com', '0104');
insert into 학생 values('22040102', '강정윤', '010330-4061031', '경기도 의정부시', '010-1717-1717', 'hong22@email.com', '0104');
insert into 학생 values('22040103', '민현서', '010418-4081111', '경기도 양주시', '010-1818-1818', 'hong23@email.com', '0104');
insert into 학생 values('22040104', '고우성', '010901-3012401', '경기도 포천시', '010-1919-1919', 'hong24@email.com', '0104');
insert into 학생 values('22040105', '하한준', '011231-3331001', '전라남도 광주', '010-2020-2020', 'hong25@email.com', '0104');

-- 학생 테이블 데이터 삽입 확인 select 구문
-- select * from 학생;

insert into 교수 values('201526', '강교수', '850101-1014868', '서울시 영등포구', '010-9001-9001', 'teacher1@email.com', '0101');
insert into 교수 values('201624', '김교수', '830221-1211320', '인천시 서구', '010-9002-9002', 'teacher2@email.com', '0102');
insert into 교수 values('201795', '이교수', '791231-2212828', '인천시 계양구', '010-9003-9003', 'teacher3@email.com', '0103');
insert into 교수 values('201926', '황교수', '800321-1132874', '서울시 강남구', '010-9004-9004', 'teacher4@email.com', '0104');

-- 교수 테이블 데이터 삽입 확인 select 구문
-- select * from 교수;

insert into 강좌 values('100101', '자료구조', 2, 140, '본관 301호', '201526');
insert into 강좌 values('100201', '전기기기설비', 3, 160, '신관 101호', '201624');
insert into 강좌 values('100301', '통신기초', 2, 140, '공업대학 202호', '201795');
insert into 강좌 values('100102', '프로그래밍기초', 3, 160, '본관 402호', '201526');

-- 강좌 테이블 데이터 삽입 확인 select 구문
-- select * from 강좌;

insert into 수강내역 values(100, 90, 70, 100, 90, 'A', '22010101', '201526', '100101');
insert into 수강내역 values(100, 90, 90, 85, 91, 'A+', '22010102', '201526', '100101');
insert into 수강내역 values(70, 60, 70, 60, 65, 'B', '22010103', '201526', '100101');
insert into 수강내역 values(60, 40, 40, 70, 42, 'C', '22010104', '201526', '100101');
insert into 수강내역 values(40, 30, 40, 20, 32, 'D', '22010105', '201526', '100101');

insert into 수강내역 values(100, 90, 70, 100, 90, 'A', '22020101', '201624', '100201');
insert into 수강내역 values(100, 90, 90, 85, 91, 'A+', '22020102', '201624', '100201');
insert into 수강내역 values(70, 60, 70, 60, 65, 'B', '22020103', '201624', '100201');
insert into 수강내역 values(60, 40, 40, 70, 42, 'C', '22020104', '201624', '100201');
insert into 수강내역 values(40, 30, 40, 20, 32, 'D', '22020105', '201624', '100201');

insert into 수강내역 values(100, 90, 70, 100, 90, 'A', '22030101', '201795', '100301');
insert into 수강내역 values(70, 60, 70, 60, 65, 'B', '22030103', '201795', '100301');
insert into 수강내역 values(60, 40, 40, 70, 42, 'C', '22030104', '201795', '100301');
insert into 수강내역 values(40, 30, 40, 20, 32, 'D', '22030105', '201795', '100301');

insert into 수강내역 values(100, 90, 70, 100, 90, 'A', '22040101', '201526', '100102');
insert into 수강내역 values(100, 90, 90, 85, 91, 'A+', '22040102', '201526', '100102');
insert into 수강내역 values(60, 40, 40, 70, 42, 'C', '22040104', '201526', '100102');
insert into 수강내역 values(40, 30, 40, 20, 32, 'D', '22040105', '201526', '100102');

-- 수강내역 테이블 데이터 삽입 확인 select 구문
-- select * from 수강내역;

insert into 현재학년학기 values('3학년/1학기', '22010101', '201526');
insert into 현재학년학기 values('2학년/1학기', '22010102', '201526');
insert into 현재학년학기 values('4학년/1학기', '22010103', '201526');
insert into 현재학년학기 values('2학년/1학기', '22010104', '201526');
insert into 현재학년학기 values('3학년/1학기', '22010105', '201526');

insert into 현재학년학기 values('2학년/1학기', '22020101', '201624');
insert into 현재학년학기 values('1학년/1학기', '22020102', '201624');
insert into 현재학년학기 values('1학년/1학기', '22020103', '201624');
insert into 현재학년학기 values('1학년/1학기', '22020104', '201624');
insert into 현재학년학기 values('2학년/1학기', '22020105', '201624');

insert into 현재학년학기 values('3학년/1학기', '22030101', '201795');
insert into 현재학년학기 values('3학년/1학기', '22030102', '201795');
insert into 현재학년학기 values('4학년/1학기', '22030103', '201795');
insert into 현재학년학기 values('4학년/1학기', '22030104', '201795');
insert into 현재학년학기 values('3학년/1학기', '22030105', '201795');

insert into 현재학년학기 values('1학년/1학기', '22040101', '201526');
insert into 현재학년학기 values('2학년/1학기', '22040102', '201526');
insert into 현재학년학기 values('1학년/1학기', '22040103', '201526');
insert into 현재학년학기 values('1학년/1학기', '22040104', '201526');
insert into 현재학년학기 values('2학년/1학기', '22040105', '201526');

-- 자료 조회 예제

-- 4. 수강하지 않은 학생의 명단을 출력하시오. 
-- outer join

select 학생.학생번호, 학생.학생이름
from 수강내역 right outer join 학생 on 수강내역.학생번호 = 학생.학생번호
where 수강내역.강좌번호 is null;

-- 5. 교수별 담당학생 명단을 출력하시오.
-- 이중조인

select 교수.교수번호 as 교번, 교수.교수이름 as 교수자명, 학생.학생번호 as 학번, 학생.학생이름
from 교수 join 현재학년학기 on 교수.교수번호 = 현재학년학기.교수번호 join 학생 on 현재학년학기.학생번호 = 학생.학생번호;

-- 변경
-- 6. 학과명이 '컴퓨터학과'인 자료의 학과번호와 학과명을 각각 '0111', '컴퓨터공학과'로 변경하시오.
update 학과
set 학과.학과번호 = '0111',
    학과.학과명 = '컴퓨터공학과'
where 학과.학과번호 = '0101';


-- 변경한 후 확인하는 선택문
-- select 학생이름, 소속학과번호
-- from 학생
-- where 소속학과번호 = '0111';

-- select 교수이름, 소속학과번호
-- from 교수
-- where 소속학과번호 = '0111';

-- select 학과명, 학과번호
-- from 학과
-- where 학과번호 = '0111';

-- 삭제
-- 7. 강좌를 진행하지 않는 교수와 관련된 자료를 삭제하시오.
delete 교수 from 수강내역 right outer join 교수 on 수강내역.교수번호 = 교수.교수번호 where 수강내역.강좌번호 is null;

-- 삭제한 후 교수테이블 검색문
-- '황교수'가 사라진 것을 확인할 수 있다.

-- select *
-- from 교수;
