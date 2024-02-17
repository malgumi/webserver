# 동물 입양 홍보게시판

## 목차

[0. 개요 및 목적](https://github.com/malgumi/web#0-%EA%B0%9C%EC%9A%94-%EB%B0%8F-%EB%AA%A9%EC%A0%81)

[1. 초기 화면 구상도](https://github.com/malgumi/web#1-%EB%A9%94%EB%89%B4-%EA%B5%AC%EC%A1%B0%EB%8F%84)

[2. 주요 기능](https://github.com/malgumi/web#2-%EC%A3%BC%EC%9A%94-%EA%B8%B0%EB%8A%A5)

[3. 개발환경 및 DBMS](https://github.com/malgumi/web#3-%EA%B0%9C%EB%B0%9C%ED%99%98%EA%B2%BD-%EB%B0%8F-dbms)

[4. 개발환경 통일](https://github.com/malgumi/web#4-%EC%B6%94%EA%B0%80-%EC%98%88%EC%A0%95-%EA%B8%B0%EB%8A%A5)

[4. 기말 보고서 제출](https://github.com/malgumi/web#4-%EC%B6%94%EA%B0%80-%EC%98%88%EC%A0%95-%EA%B8%B0%EB%8A%A5)

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


## 2. 주요 기능

1. 회원가입 및 로그인, 로그아웃<br>
2. 관리자 기능(글 관리, 유저 관리)<br>
3. 홍보글 작성, 삭제, 수정<br>
4. 댓글 작성, 삭제, 수정<br>
5. 입양 완료<->홍보중 변경 가능<br>
6. 회원 찾기<br>


## 3. 개발환경 및 DBMS

오라클 클라우드 서버
 - MySQL
 - 아파치 톰캣 9.0
 - 자바 17
 - Spring 예정


## 4. 개발환경 통일
1. 프로젝트 이름 오른쪽 클릭<br>
2. Properties 클릭
<img width="1439" alt="1" src="https://user-images.githubusercontent.com/26024730/211736255-e30f8a4c-271d-4282-a1e6-beb90f603791.png">
1. Project Facets에서 Java 버전 1.8로 맞추기
<img width="962" alt="2" src="https://user-images.githubusercontent.com/26024730/211722123-0fc11778-3c33-4dad-8fa5-2c573b0676c6.png">
1. Java Compiler 에서 Compiler compliance level 1.8로 맞추기<br>
2. 오른쪽 아래 Apply and Close
<img width="961" alt="3" src="https://user-images.githubusercontent.com/26024730/211722128-a5393c67-b973-40d6-9e53-8a7529f82013.png">


## 5. 기말 보고서 제출 

