# TIL - Book Search Project Summary

이 문서는 프로젝트 전반에 걸쳐 학습하고 구현한 기능들을 정리한 내용입니다.

## 1. 프로젝트 개요 (Project Overview)
- **주제**: 네이버 책 검색 API를 활용한 도서 검색 애플리케이션
- **목표**: 키워드로 책을 검색하고, 결과 목록을 확인하며, 상세 정보를 볼 수 있는 기능 구현

## 2. 아키텍처 및 디자인 패턴 (Architecture)
**MVVM (Model - View - ViewModel)** 패턴을 적용하여 UI와 비즈니스 로직을 분리했습니다.

- **Model**: 데이터 구조 정의 (`Book`)
- **View**: UI 구성 (`HomePage`, `DetailPage`, `HomeBottomSheet`)
- **ViewModel**: 상태 관리 및 로직 처리 (`HomeViewModel`)
- **Repository**: 데이터 통신 담당 (`BookRepository`)

## 3. 주요 사용 라이브러리 (Libraries)
| 패키지명 | 용도 |
| --- | --- |
| `flutter_riverpod` | 전역 상태 관리 (ViewModel과 UI 연결) |
| `http` | 네이버 오픈 API 통신 (GET 요청) |
| `flutter_inappwebview` | 책 상세 페이지(웹사이트) 표시 |

## 4. 구현 기능 상세 (Implementation Details)

### A. 데이터 통신 (Networking)
- **Http 요청**: `BookRepository`에서 `http` 패키지를 사용해 네이버 API에 GET 요청을 보냅니다.
- **헤더 설정**: API 인증을 위해 `X-Naver-Client-Id`와 `X-Naver-Client-Secret` 헤더를 포함합니다.
- **JSON 파싱**: 응답받은 JSON 데이터를 `Map`으로 변환 후, `Book.fromJson` 생성자를 통해 객체 리스트로 변환합니다.

### B. 상태 관리 (State Management)
- **Riverpod 사용**: `NotifierProvider`를 사용하여 `HomeViewModel`을 관리합니다.
- **UI 업데이트**: `ref.watch(homeViewModelProvider)`를 통해 상태 변화를 감지하고 UI를 자동으로 다시 그립니다.
- **이벤트 처리**: `ref.read(...).searchBooks(query)`로 검색 이벤트를 실행합니다.

### C. UI 구성 (User Interface)
- **검색창 커스텀**: `Focus` 위젯을 사용하여 포커스 여부에 따라 테두리 색상과 두께가 변하는 인터랙션을 구현했습니다.
- **그리드 뷰**: `GridView.builder`를 사용하여 검색 결과를 3열 그리드로 보여줍니다.
- **보텀 시트**: 책을 탭하면 `showModalBottomSheet`를 통해 간략한 정보를 하단에서 띄워줍니다.
- **웹뷰 (WebView)**: 상세 정보 버튼 클릭 시 `InAppWebView`를 통해 실제 네이버 책 페이지로 이동합니다.

---

## 5. 트러블슈팅 로그 (Troubleshooting Log)
개발 과정에서 발생한 주요 문제와 해결 방법입니다.

### 1) Getter 'imageUrl' isn't defined for the type 'Book'
- **문제**: `home_page.dart`에서 `book.imageUrl`을 호출했으나 정의되지 않음.
- **원인**: `Book` 모델에서는 필드명이 `image`였음.
- **해결**: `book.image`로 수정하여 해결.

### 2) WebView가 PC 버전으로 뜨는 현상
- **문제**: 모바일 앱 내 WebView에서 네이버 페이지가 데스크탑(PC) 버전으로 로드됨.
- **원인**: `InAppWebViewSettings`의 `userAgent`가 Windows Desktop 환경으로 하드코딩되어 있었음.
- **해결**: `userAgent` 설정을 제거하여 기본 모바일 UserAgent를 사용하도록 수정.

### 3) BookRepository 반환 타입 에러 (The body might complete normally...)
- **문제**: `searchBooks` 메서드가 `Future<List<Book>>`을 반환해야 하나, 에러 케이스나 조건문 밖에서 반환값이 명시되지 않았음.
- **해결**: 함수 끝에 `return [];`을 추가하여 예외 상황에서도 빈 리스트를 반환하도록 수정.

### 4) Missing Semicolon
- **문제**: 여러 파일에서 구문 끝에 세미콜론(`;`) 누락.
- **해결**: 에러 로그를 확인하여 해당 라인에 세미콜론을 추가.
