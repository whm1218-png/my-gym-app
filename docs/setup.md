# Setup

점진적 과부하 × 1RM 헬스 앱(`health_app`) 개발 환경 구축 가이드.  
**5분 안에** 클론 → 의존성 설치 → 첫 실행까지 따라할 수 있도록 작성했습니다.

---

## 아키텍처 선택 요약 (11주차)

| 항목 | 결정 |
|------|------|
| 패턴 | **Layered Architecture + MVVM** |
| 상태/DI | **flutter_riverpod** |
| 근거 | 화면 8개 내외·로컬 DB 중심·학기 일정 — `02-architecture-patterns.md` 권장과 동일 |

**왜 Clean Architecture 전체가 아닌가?**  
UseCase·Repository 분리는 유지하되, 초기에는 레이어 4단과 ViewModel만으로도 Must 기능(기록·과부하·e1RM)을 데모할 수 있습니다. 팀 규모·기한 대비 학습 비용이 낮습니다.

**왜 MVVM인가?**  
화면(Widget)은 입력·표시만, `HomeViewModel` 등이 도메인 서비스(Epley, 과부하) 결과를 UI 상태로 변환합니다. 테스트·화면 교체가 쉽습니다.

상세 다이어그램: [`architecture.md`](architecture.md)

---

## `lib/` 폴더 구조와 의미

```
lib/
├── main.dart                 # 앱 진입점, ProviderScope
├── app.dart                  # MaterialApp, 다크 테마, 홈 라우트
├── presentation/             # Presentation 레이어 (View)
│   ├── screens/              # 화면 단위 위젯
│   ├── widgets/              # 재사용 UI 조각
│   └── theme/                # 다크 모드 ThemeData
├── application/              # Application 레이어 (ViewModel·DI)
│   ├── view_models/          # 화면 상태·사용자 액션 처리
│   └── providers/            # Riverpod Provider (Repository 주입 등)
├── domain/                   # Domain 레이어 (규칙·계약)
│   ├── entities/             # WorkoutSession, SetEntry
│   ├── services/             # Epley, 점진적 과부하 판정
│   └── repositories/         # WorkoutRepository 인터페이스
└── data/                     # Data 레이어
    ├── repositories/         # Repository 구현체
    └── local/                # drift/SQLite (예정)
```

| 레이어 | 역할 | 헬스 앱 예시 |
|--------|------|----------------|
| **presentation** | 사용자가 보는 UI | 홈, 세션 입력, e1RM 숫자 표시 |
| **application** | UI 상태·흐름 | 세트 저장 후 과부하 배지 갱신 |
| **domain** | 비즈니스 규칙 | Epley 공식, 직전 세션 비교 |
| **data** | 저장·조회 | SQLite에 세션/세트 CRUD |

의존 방향: `presentation → application → domain ← data` (domain은 data 구현에만 의존, UI는 data를 직접 import하지 않음).

---

## 1. 사전 요구

| 도구 | 버전 | 확인 명령 |
|------|------|-----------|
| Git | 2.40+ | `git --version` |
| Flutter SDK | 3.24+ (권장 3.35 stable) | `flutter --version` |
| Dart | Flutter에 포함 | `dart --version` |
| Android Studio / SDK | API 34 권장 | Android Studio SDK Manager |
| JDK | 17 | `java -version` |

### 윈도우 설치

```powershell
winget install Git.Git
winget install Google.AndroidStudio
# Flutter: https://docs.flutter.dev/get-started/install/windows
```

설치 후:

```powershell
flutter doctor
```

### macOS

```bash
brew install git
brew install --cask flutter
flutter doctor
```

### 리눅스 (Ubuntu)

```bash
sudo apt update
sudo apt install git curl unzip
# Flutter SDK 압축 해제 후 PATH 추가 — 공식 문서 참고
flutter doctor
```

---

## 2. 클론

```bash
git clone https://github.com/[user]/HealthApp_VibeCoding.git
cd HealthApp_VibeCoding
```

> 기획 문서는 `.planning/` 에 있습니다. 앱 코드는 `lib/` 입니다.

---

## 3. 의존성 설치

```bash
flutter pub get
```

---

## 4. 환경 변수

초기 MVP는 **서버·API 키 없음**(로컬 저장만).  
향후 동기화·분석 도입 시 `.env.example` 을 추가할 예정입니다.

현재: **별도 `.env` 설정 불필요.**

---

## 5. 첫 실행

### Windows (데스크톱, 가장 빠른 확인)

```bash
flutter run -d windows
```

### Android 에뮬레이터

```bash
flutter devices
flutter run -d <device_id>
```

### 테스트

```bash
flutter test
```

**성공 시:** 다크 테마 **Health App** 홈 화면, 예시 e1RM 숫자, `운동 시작 (준비 중)` 버튼이 보입니다.

---

## 6. 플랫폼 폴더가 없을 때

`.planning` 등으로 `flutter create .` 가 실패할 수 있습니다. 그때:

```bash
flutter create . --org com.healthapp --project-name health_app
```

이미 `lib/` 가 있으면 **플랫폼 파일만 보완**됩니다. 기존 `lib/` 는 덮어쓰지 마세요.

---

## 7. 자주 묻는 문제

### Q1. `flutter` command not found
→ Flutter SDK `bin` 을 PATH에 추가한 뒤 터미널을 다시 엽니다.

### Q2. Android Gradle 동기화 실패
→ `flutter doctor --android-licenses` 실행, JDK 17 사용, Android Studio에서 SDK 34 설치.

### Q3. 에뮬레이터가 안 떠요
→ Android Studio → Device Manager에서 AVD 생성 후 `flutter devices` 로 인식 확인.

### Q4. `local.properties` / flutter.sdk 오류
→ 프로젝트 루트에서 `flutter pub get` 한 번 실행하거나, `android/local.properties` 에 `flutter.sdk=C:\\path\\to\\flutter` 수동 지정.

### Q5. Windows 빌드 도구 없음
→ Visual Studio 2022 **Desktop development with C++** 워크로드 설치 후 `flutter doctor` 재실행.

---

## 검증

다른 PC에서 위 순서(클론 → `pub get` → `flutter run` 또는 `flutter test`)를 **5분 내** 완료할 수 있으면 이 문서는 합격입니다.
