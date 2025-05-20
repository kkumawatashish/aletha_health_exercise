# aletha_health_exercise

# Aletha Health – Exercise App

A mobile exercise app built with Flutter and Dart to help users improve their physical well-being by performing guided workouts. This app retrieves exercises from a REST API and allows users to start a timer, complete exercises, and track progress including daily streaks.

---

## 📱 2.1 About the App

The Aletha Health Exercise App allows users to:

- Browse a list of exercises with their names and durations.
- View detailed information about each exercise, including its description and difficulty.
- Start an in-app timer to perform the exercise.
- Get notified when the exercise is complete.
- Track completion status locally.
- View a streak tracker showing how many **continuous days** they’ve completed at least one exercise.

---

## 🏗️ 2.2 Architecture

The app follows Clean Architecture principles and is modularized into three layers:

### 1. Presentation Layer
- UI Widgets
- Bloc-based State Management
- Uses `flutter_bloc` to handle UI updates, events, and transitions.

### 2. Domain Layer
- Entities: Plain models like `Exercise`.
- Use Cases: Business logic, like tracking streaks.

### 3. Data Layer
- Repositories and Data Sources.
- Uses Dio for API requests.
- Local persistence via `Flutter_Secure_Storage` for streak and completion tracking.

#### 🔄 Navigation
- Uses `go_router` for declarative routing.
- Passes exercise objects between screens as route extras.

---

## ⚠️ 2.3 Known Shortcomings or Errors

- Exercise completion is tracked locally; not synced with a backend.
- App assumes API is always available (limited offline support).
- Streak tracking is done locally and could be reset on uninstall.

---

## 🚀 2.4 How to Run the App

### Prerequisites:
- Flutter SDK (>=3.7.2)
- Dart
- IDE: Android Studio

### Steps:

1. Clone the Repo
   ```bash
   git clone https://github.com/your-username/aletha-health-exercise.git
   cd aletha-health-exercise

2. Install Dependencies

   ```bash
   flutter pub get
   
3. Run on Emulator or Device
   ```bash
   flutter run
   
4. To run with hot reload while coding:
   ```bash
   flutter run --hot