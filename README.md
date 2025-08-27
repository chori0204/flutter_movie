# flutter_movie

2. 주요 TMDB API URL 예시
기능	엔드포인트	설명
현재 상영중 영화	/movie/now_playing	현재 상영중인 영화 리스트
인기 영화	/movie/popular	인기있는 영화 리스트
평점 높은 영화	/movie/top_rated	평점이 높은 영화 리스트
개봉 예정 영화	/movie/upcoming	곧 개봉 예정인 영화 리스트
영화 상세 정보	/movie/{movie_id}	특정 영화 상세 정보 조회

3. API 호출 시 고려 사항
api_key 쿼리 파라미터로 발급받은 API Key를 반드시 포함해야 합니다.
page 파라미터로 페이지네이션 가능 (1부터 시작)
이미지 URL은 JSON 내 poster_path 등을 통해 제공되며,
https://image.tmdb.org/t/p/w500{poster_path} 처럼 베이스 URL + 사이즈 + 경로 조합으로 이미지 불러옴

## 전체 구조 
assets/
 ├─ config
 │    └─.env
lib/
 ├─ core/
 │    └─ config/env.dart            // 환경변수(API 키 등)
 ├─ features/
 │    ├─ home/
 │    │    ├─ data/
 │    │    │    ├─ datasources/
 │    │    │    │     └─ movie_remote_data_source.dart
 │    │    │    ├─ models/
 │    │    │    │     └─ movie_model.dart
 │    │    │    └─ repositories/
 │    │    │          └─ movie_repository_impl.dart
 │    │    ├─ domain/
 │    │    │    ├─ entities/
 │    │    │    │     └─ movie.dart
 │    │    │    ├─ repositories/
 │    │    │    │     └─ movie_repository.dart
 │    │    │    └─ usecases/
 │    │    │          ├─ get_now_playing_movies.dart
 │    │    │          └─ get_movie_detail.dart
 │    │    ├─ presentation/
 │    │    │    ├─ bloc/
 │    │    │    │     └─ home_bloc.dart
 │    │    │    ├─ pages/
 │    │    │    │     ├─ home_page.dart
 │    │    │    │     └─ detail_page.dart
 │    │    │    └─ widgets/
 │    │    │          └─ horizontal_movie_list.dart
 └─  main.dart


## 레이어 구조 
✅ 도메인 레이어
    movie.dart, movie_detail.dart
    movie_repository.dart
    UseCases

✅ 데이터 레이어
    movie_model.dart, movie_detail_model.dart
    movie_datasource.dart
    movie_repository_impl.dart

✅ 프레젠테이션 레이어
    home_page.dart, movie_detail_page.dart
    위젯 구성 (movie_horizontal_list_widget.dart)
    ViewModel 또는 BLoC

✅ 기타
    .env, Env 클래스
    main.dart
    테스트 코드

## 설치된 패키지 

| 목적                        | 패키지명                      | 설치 명령어                               |
| ------------------------- | ------------------------- | ----------------------------------------- |
| `.env` 파일을 읽을 수 있도록 설정 | `flutter_dotenv`            | `flutter pub add flutter_dotenv`       |
| 클린아키텍처 <dart>            | `clean_arch_boilerplate_cli`  | `dart pub global activate clean_arch_boilerplate_cli` |
| 클린아키텍처 <flutter>         | `flutter_clean_architecture`  | `flutter pub add flutter_clean_architecture`  |
| BLoC 상태관리 (flutter\_bloc) | `flutter_bloc`            | `flutter pub add flutter_bloc`            |
| BLoC 상태관리 (bloc 라이브러리)  | `bloc`                    | `flutter pub add bloc`                    |
| Equatable (객체 비교 편리)     | `equatable`               | `flutter pub add equatable`               |
| HTTP 통신                   | `http`                    | `flutter pub add http`                    |
| HTTP 통신                   | `dio`                    | `flutter pub add dio`                    |
| JSON 직렬화/역직렬화           | `json_annotation`         | `flutter pub add json_annotation`         |

<<Dev>
| 목적                        | 패키지명                      | 설치 명령어                               |
| ------------------------- | ------------------------- | ----------------------------------------- |
| 코드 생성 도구 (빌드러너)        | `build_runner` (dev)      | `flutter pub add --dev build_runner`      |
| JSON 코드 생성 라이브러리       | `json_serializable` (dev) | `flutter pub add --dev json_serializable` |
| 테스트 프레임워크               | `flutter_test` (기본 내장)    | (별도 설치 불필요)                          |
| 테스트 프레임워크               | `mockito` (기본 내장)    | `flutter pub add --dev mockito build_runner`  |
| 테스트 프레임워크               | `bloc_test` (기본 내장)    | `flutter pub add --dev bloc_test`  |


### 패키지 관련 참고
1.   http/dio 
    단순 GET/POST만 쓴다면 http도 충분
    인증 토큰 처리, 인터셉터, 복잡한 API 호출 많으면 dio 추천
2. bloc_test + mockito 조합
    - Bloc 내부에서 사용하는 useCase, repository 등을 mockito로 mock 처리해서 테스트에 사용하면 더 강력한 테스트를 만들 수 있어요
    - blocTest()는 비동기 상태 테스트를 자동 처리해주므로 await나 pump() 없이 테스트 가능.

## 작업내용 
0. .env 파일 
    - Flutter 앱에서 `.env` 파일을 읽을 수 있도록 패키지 추가 
    - Git 업로드시 `.env` 파일 제한 

1. home_page.dart 
    - ui 
        col 1 - 가장 인기있는
            화면에 가득차게 top 무비 하나 
        col 2 - 현재 상영중
            목록 이미지 
        col 3 - 인기순 
            인기 순위 번호 좌측하단에 출력
            목록 이미지
        col 4 - 평점높은순
            목록 이미지 
        col 5 - 개봉예정
            목록이미지

    * Detail page 이동 시  Hero 위젯 사용 
        서로 다른 두 페이지에서 동일한 tag 속성 사용시 애니메이션 진행됨 
    * 스크롤을 아래로 당겼을때 전체 영화목록을 새로 불러옴
        RefreshIndicator 위젯 이용
        
2. detail_page.dart 
    - ui 
        col 1
            메인 이미지
        col 2 
            row 1
                영화명 
            row 2  영화 개봉일 (우측정렬)
        col 3
            rowundbutton 영화의 type 
        col 4 
             영화 설명 
        col 5 
            흥행정보 
        col 6 
            제작사 banner

3. api 세팅 
    - themoviedb . api key 발급 
    - 패키지 추가 
      ``` flutter pub add flutter_dotenv ```
    - api key 세팅 완료 

4. 클린아키텍처 
    https://pub.dev/packages/clean_arch_boilerplate_cli
        cli- 의존성 추가시 # 이 있어 오류 발생 
        gpt 확인 
            <<dart>>
            pub.dev에 있는 패키지를 활성화할 경우:
            ``` dart pub global activate clean_arch_boilerplate_cli ```
            ``` flutter pub get ```
    * flutter 프로젝트인데 dart 만 클린아키텍쳐 cli 처리하면 flutter 도 적용되는걸까 ?
        일부는 적용되지만, Flutter 특유의 UI 코드나 구조는 별도 고려가 필요합니다.
    | 항목                              | 적용 여부                           |
    | ------------------------------- | ------------------------------- |
    | Dart CLI만 사용                    | ❌ Flutter UI까지는 적용 안 됨          |
    | `flutter_clean_architecture` 사용 | ✅ Flutter UI에도 클린 아키텍처 적용 가능    |
    | 추천 사용                           | 앱 구조 분리와 테스트가 중요한 중대형 프로젝트에서 유용 |

        <<flutter>>
        ```flutter pub add flutter_clean_architecture ```

# 추가로 공부한 내용 
    1. 클린아키텍처 구조 자동화 
        generate_feature.sh 쉘스크립트를 추가해서 하나의 페이지를 추가할때, 
        구조에 맞게 생성하는 기능 
        > 맥에서 쉘스크립트 실행하려면 터미널에서 실행 권한(chmod +x)은 한 번만 주면 됨
        ``` chmod +x generate_feature.sh ```
        > 현재 디렉터리에서 ./generate_feature.sh 기능명 으로 실행
        ```./generate_feature.sh detail_page ```

#  오류 확인
   1. Your project contains issues that can be fixed automatically.
        프로젝트 코드에 스타일이나 문법, 사용하지 않는 변수 등 자동으로 고칠 수 있는 문제가 있다는 뜻이에요.
        Flutter나 Dart SDK가 제공하는 자동 수정 기능(fix)으로 쉽게 해결 가능해요.
        ``` flutter fix --apply ```
        ``` dart fix --apply ```
    2. 버전 최신화 시 에러메세지
        Your flutter checkout has local changes that would be erased by upgrading. If you want to keep these changes, it is recommended that you stash them via "git stash" or else commit the changes to a local branch. If it is okay to remove local changes, then re-run this command with "--force".
        Flutter SDK는 Git으로 관리되고 있어서, 직접 SDK 내부 파일을 수정하면 flutter upgrade 시 변경사항이 충돌날 수 있어요.
        그래서 flutter upgrade가 변경사항 덮어쓰기를 막고 경고를 띄운 상태입니다.
        ``` cd $(flutter sdk 경로)
            git stash
            flutter upgrade
            git stash pop ```

        ``` flutter upgrade --force ```



# dart / flutter 최신화 
    ``` brew upgrade dart ```   
    ``` flutter upgrade ```

        
        

