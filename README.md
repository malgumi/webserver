# 동물 입양 홍보게시판

## 목차

[0. 개요 및 목적](https://github.com/malgumi/webserver?tab=readme-ov-file#0-%EA%B0%9C%EC%9A%94-%EB%B0%8F-%EB%AA%A9%EC%A0%81)

[1. 초기 화면 구상도](https://github.com/malgumi/webserver?tab=readme-ov-file#1-%EC%B4%88%EA%B8%B0-%ED%99%94%EB%A9%B4-%EA%B5%AC%EC%83%81%EB%8F%84)

[2. DB 설계](https://github.com/malgumi/webserver?tab=readme-ov-file#2-%EC%A3%BC%EC%9A%94-%EA%B8%B0%EB%8A%A5)

[3. 개발환경 및 DBMS](https://github.com/malgumi/webserver?tab=readme-ov-file#3-%EA%B0%9C%EB%B0%9C%ED%99%98%EA%B2%BD-%EB%B0%8F-dbms)

[4. 기능](https://github.com/malgumi/webserver?tab=readme-ov-file#4-%EA%B8%B0%EB%8A%A5)


## 0. 개요 및 목적

4학년 1학기 웹서버프로그래밍 과목 기말과제를 위한 홈페이지<br>
반려동물을 입양하거나 홍보를 할 수 있는 커뮤니티

## 1. 초기 화면 구상도

<br>회원가입
![회원가입_화면구상도](https://github.com/malgumi/webserver/assets/97935451/27ef04f7-3eb7-4005-97d2-9fdc6bb9f860)
<br>자유게시판
![자유게시판_화면구상도](https://github.com/malgumi/webserver/assets/97935451/b9f2040a-1ecd-49be-969c-2029b9232fa9)
<br>메인화면
![메인화면_화면구상도](https://github.com/malgumi/webserver/assets/97935451/450d0ef0-8c5d-40b2-bbbb-b7a73e959534)
<br>로그인
![로그인_화면구상도](https://github.com/malgumi/webserver/assets/97935451/5f29fb81-f6ea-469f-8795-c077ecf9f553)
<br>글보기
![글보기_화면구상도](https://github.com/malgumi/webserver/assets/97935451/03ddd73f-1295-428d-87d0-197cfb7bb56e)

## 2. DB 설계

![image](https://github.com/malgumi/webserver/assets/97935451/565914b0-09a6-40ac-a7f4-bb0ac8acb38b)

## 3. 개발환경 및 DBMS

 - H2
 - 아파치 톰캣 9.0
 - Maven
 - JAVA 1.8

## 4. 기능
![image](https://github.com/malgumi/webserver/assets/97935451/292fc5af-b7c3-4ad3-b89d-32d856950ff4)
<br>

- 주요 기능
1. 회원가입 및 로그인, 로그아웃<br>
2. 관리자 기능 차별화(글 관리, 유저 관리)<br>
3. 게시판 CRUD<br>
4. 댓글 작성, 삭제<br>
5. 페이징 및 검색 기능<br><br>

홍보게시판 - 이미지 미리보기 제공<br>
![image](https://github.com/malgumi/webserver/assets/97935451/fd53127d-2f06-4fe5-b01a-6c68390826a2)<br>
자유게시판 - 이미지 미리보기 제공X<br>
![image](https://github.com/malgumi/webserver/assets/97935451/92e0ad73-f8e7-41be-83dc-9e29193a669e)
<br>

- 부가 기능
1. 홍보게시판 게시글의 입양 완료<->홍보중 상태 변경<br>
2. 회원 찾기 기능<br>
3. 유효성 제약<br>
4. 메인페이지 슬라이드 광고<br>
5. 메인페이지에서 마우스 포인터를 고양이 얼굴 사진이 따라다님<br>
6. 로그인 전, 후 상황에 따라 네비게이션바의 드롭다운 메뉴가 달라짐<br>
7. 첨부파일 업로드 및 이미지 미리보기<br>
8. 이전 글, 다음 글 출력<br>


## 결과 보고서(기말제출용)

[다운로드 링크](https://drive.google.com/file/d/1139tnn8AR7KyhbiPP-kzHwGtruGx-J3t/view?usp=sharing)

