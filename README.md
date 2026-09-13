# TaskFlow – Flutter Project Management App

A modern, scalable project management application built with **Flutter and Dart**, featuring mock authentication, project management, task tracking, team assignment, and simulated offline support.

TaskFlow is designed with clean architecture, Riverpod state management, and a repository-based data layer to demonstrate production-style Flutter development without relying on a live backend.

---

## 📱 Overview

TaskFlow helps teams organize projects, manage tasks, assign team members, and track progress through a clean and responsive mobile interface.

This application uses a local mock JSON data source to simulate real-world API interactions, authentication, authorization, and offline scenarios.

### ✨ Key Highlights

* 🔐 Mock JWT-style authentication
* 📊 Dashboard with project and task insights
* 📁 Project management
* ✅ Complete task management
* 👥 Team member assignment
* 🔄 Simulated token refresh
* 📡 Simulated offline mode
* 💾 Local data storage
* 🧱 Clean layered architecture
* ⚡ Riverpod state management
* 🧪 Unit, widget, and integration testing
* 📱 Responsive Android UI

---

## 🛠️ Technology Stack

| Category         | Technology                         |
| ---------------- | ---------------------------------- |
| Framework        | Flutter                            |
| Language         | Dart                               |
| Platform         | Android                            |
| State Management | Riverpod                           |
| Architecture     | Clean / Layered Architecture       |
| Data Source      | Local Mock JSON                    |
| Local Storage    | SharedPreferences / Secure Storage |
| Authentication   | Simulated JWT                      |
| Testing          | Flutter Test                       |
| Navigation       | Flutter Navigation                 |
| Version Control  | Git & GitHub                       |

---

## 🏗️ Architecture

TaskFlow follows a layered architecture that separates UI, business logic, and data access.

```text
┌──────────────────────────────┐
│       Presentation Layer     │
│                              │
│  Screens • Widgets • Pages   │
│  Riverpod Providers          │
└──────────────┬───────────────┘
               │
┌──────────────▼───────────────┐
│         Domain Layer         │
│                              │
│  Entities • Use Cases        │
│  Repository Interfaces       │
│  Business Rules              │
└──────────────┬───────────────┘
               │
┌──────────────▼───────────────┐
│          Data Layer           │
│                              │
│  Repository Implementations  │
│  Mock JSON Data Source        │
│  DTOs • JSON Serialization    │
│  Local Storage                │
└──────────────┬───────────────┘
               │
┌──────────────▼───────────────┐
│       Local Mock Data         │
│                              │
│       TaskFlow-MockData.json  │
└──────────────────────────────┘
```

### Architecture Principles

* Separation of concerns
* Dependency inversion
* Reusable widgets
* Repository abstraction
* Testable business logic
* Scalable folder structure
* No direct JSON access from UI widgets

---

## 📂 Project Structure

```text
lib/
│
├── main.dart
│
├── app/
│   ├── app.dart
│   ├── router.dart
│   └── theme/
│       ├── app_theme.dart
│       ├── app_colors.dart
│       └── app_text_styles.dart
│
├── core/
│   ├── constants/
│   ├── errors/
│   ├── extensions/
│   ├── utils/
│   └── storage/
│
├── features/
│   │
│   ├── auth/
│   │   ├── data/
│   │   │   ├── datasources/
│   │   │   ├── models/
│   │   │   └── repositories/
│   │   ├── domain/
│   │   │   ├── entities/
│   │   │   ├── repositories/
│   │   │   └── usecases/
│   │   └── presentation/
│   │       ├── providers/
│   │       ├── screens/
│   │       └── widgets/
│   │
│   ├── projects/
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   │
│   ├── tasks/
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   │
│   ├── users/
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   │
│   └── dashboard/
│       └── presentation/
│
├── shared/
│   ├── widgets/
│   ├── dialogs/
│   └── loading/
│
└── injection/
    └── providers.dart
```

### Data Flow

```text
UI Screen
   ↓
Riverpod Provider
   ↓
Use Case
   ↓
Repository Interface
   ↓
Repository Implementation
   ↓
Mock JSON Data Source
   ↓
Local Storage / In-Memory State
```

---

## 🚀 Features

### 1. Authentication

* Login using mock credentials
* Register screen with simulated success
* Splash screen with session check
* Client-side validation
* Mock access and refresh tokens
* Secure token storage
* Simulated token expiry after 15 minutes
* Mock refresh-token flow
* Logout and session clearing
* Protected authenticated screens

### 2. Dashboard

* Overview of projects
* Total task count
* Completed tasks
* Pending tasks
* In-progress tasks
* Quick navigation to projects and tasks

### 3. Projects

* View projects belonging to the logged-in organization
* Create a project
* Edit a project
* Delete a project
* View project details
* Task count per project
* Task status summary
* Pull-to-refresh
* Loading, empty, and error states
* Admin authorization for destructive actions

### 4. Tasks

* View all tasks
* View task details
* Create tasks
* Edit tasks
* Delete tasks
* Update task status
* Update task priority
* Assign and unassign users
* Filter by status
* Filter by priority
* Filter by assignee
* Filter by due-date range
* Pull-to-refresh
* Loading, empty, and error states

### 5. Team Members

* Display organization members
* View member details
* Assign members to tasks
* Remove task assignees
* Validate organization membership
* Restrict unauthorized admin actions

### 6. Offline Awareness

* Simulated connectivity toggle
* Preserve previously loaded data
* Display offline status
* Show stale-data indicator
* Retry failed operations
* Local data caching
* Optional pending-operation queue

---

## 📦 Mock Data

The application uses a single JSON asset:

```text
assets/data/TaskFlow-MockData.json
```

The file contains the following top-level collections:

```json
{
  "organizations": [],
  "users": [],
  "org_members": [],
  "projects": [],
  "tasks": [],
  "comments": [],
  "notifications": [],
  "auth_mock": {}
}
```

### Data Handling

* JSON is bundled as a Flutter asset.
* A centralized data source reads the JSON file.
* Each top-level key is parsed into its own model collection.
* Repositories expose business-friendly methods.
* UI widgets never read JSON directly.
* Mutations update local in-memory or local-storage state.

### Repository Abstraction

The repository layer is designed so the mock data source can later be replaced with a real HTTP implementation without changing the presentation layer or repository interfaces.

---

## 🔐 Authentication Flow

```text
Splash Screen
      ↓
Check Stored Session
      ↓
┌───────────────┐
│ Session Valid?│
└───────┬───────┘
        │
   ┌────▼─────┐
   │   Yes    │──────► Dashboard
   └──────────┘
        │ No
        ▼
      Login
        │
        ▼
 Validate Mock Credentials
        │
        ▼
 Store Mock Tokens Securely
        │
        ▼
     Dashboard
```

### Mock Authentication

The application loads credentials from the `auth_mock` data collection.

**Security considerations:**

* Credentials are not hardcoded in UI widgets.
* Passwords are not persisted locally.
* Tokens are not logged.
* Session state is cleared on logout.
* Authenticated routes are protected by business logic.

> This is a simulated authentication system for development and evaluation. It is not a production authentication backend.

---

## 🧪 Testing

TaskFlow includes a testing structure for:

### Unit Tests

* Authentication validation
* Repository methods
* Task filtering
* Project task counts
* Authorization rules
* Token expiry and refresh
* Organization membership validation

### Widget Tests

* Login form validation
* Project list rendering
* Task list rendering
* Empty states
* Error states
* Loading indicators
* Confirmation dialogs

### Integration Tests

* Login flow
* Session restoration
* Project creation
* Task creation
* Task assignment
* Logout flow

### Run Tests

```bash
flutter test
```

Run integration tests:

```bash
flutter test integration_test
```

---

## ⚠️ Simulated Error Handling

TaskFlow supports simulated errors to demonstrate robust error handling.

| Error            | Example Scenario               |
| ---------------- | ------------------------------ |
| Validation Error | Invalid login or task form     |
| Not Found        | Requested task does not exist  |
| Timeout          | Simulated data-source delay    |
| Unauthorized     | Member attempts admin action   |
| Offline          | Connectivity toggle disabled   |
| Empty State      | No projects or tasks available |

Error states are handled through Riverpod state management and displayed using reusable UI components.

---

## 📡 Offline Mode

Since TaskFlow does not use a real backend, offline behavior is simulated.

When offline mode is enabled:

* No remote request is performed.
* Previously loaded data remains visible.
* The UI displays an offline message.
* Retry is available.
* Data may be marked as stale.
* Optional pending operations can be synchronized when online mode is restored.

---

## ⚙️ Installation & Setup

### Prerequisites

Make sure you have installed:

* Flutter SDK
* Dart SDK
* Android Studio
* Android SDK
* Git
* VS Code or Android Studio

### 1. Clone Repository

```bash
git clone https://github.com/YOUR_USERNAME/taskflow-flutter.git
```

### 2. Open Project

```bash
cd taskflow-flutter
```

### 3. Install Dependencies

```bash
flutter pub get
```

### 4. Add Mock Data

Place the provided JSON file at:

```text
assets/data/TaskFlow-MockData.json
```

Ensure the asset is registered in `pubspec.yaml`:

```yaml
flutter:
  assets:
    - assets/data/TaskFlow-MockData.json
```

### 5. Run Application

```bash
flutter run
```

Run on a connected Android device or emulator.

---

## 📱 Supported Platform

| Platform | Support      |
| -------- | ------------ |
| Android  | Required     |
| iOS      | Optional     |
| Web      | Not required |

---

## 🛡️ Authorization Rules

TaskFlow enforces authorization in the business-logic layer.

### Organization Admin

* Create projects
* Edit projects
* Delete projects
* Manage organization members

### Organization Member

* View projects
* View tasks
* Create and edit tasks according to application rules
* Update task status and priority
* Assign users only when allowed by business rules

### Important

Authorization is not implemented only by hiding UI buttons.

Unauthorized operations are blocked in the business-logic/repository layer to simulate backend enforcement.

---

## 📋 Requirements Coverage

| Requirement                   | Status      |
| ----------------------------- | ----------- |
| Flutter + Dart                | Implemented |
| Android application           | Implemented |
| Clean architecture            | Implemented |
| Riverpod state management     | Implemented |
| Local mock JSON               | Implemented |
| Repository layer              | Implemented |
| Mock authentication           | Implemented |
| Secure token storage          | Implemented |
| Projects CRUD                 | Implemented |
| Tasks CRUD                    | Implemented |
| Task assignment               | Implemented |
| Offline awareness             | Implemented |
| Error states                  | Implemented |
| Unit/widget/integration tests | Implemented |
| README documentation          | Implemented |

---

## 🎨 UI/UX

The application focuses on:

* Clean and modern interface
* Consistent spacing
* Responsive layouts
* Reusable components
* Meaningful form validation
* Clear loading indicators
* Empty-state screens
* Error-state screens
* Confirmation dialogs
* Smooth navigation
* Proper back-navigation handling

---

## 🔮 Future Improvements

* Real REST API integration
* Backend authentication
* Firebase push notifications
* Real-time task updates
* Role-based access control from server
* Team chat
* Advanced analytics
* Dark mode
* Biometric authentication
* Automated CI/CD
* Production deployment

---

## 👨‍💻 Developer

**Shivam Kumar**

B.Tech – Computer Science & Engineering
Indian Institute of Information Technology, Kottayam

### Skills

Flutter • Dart • React.js • Next.js • Node.js • Express.js • MongoDB • REST APIs • Git • Docker • AI/ML

---

## 📄 License

This project is developed for educational, evaluation, and demonstration purposes.

---

## ⭐ Acknowledgements

Built with Flutter and Dart, following scalable architecture and maintainable software engineering practices.
