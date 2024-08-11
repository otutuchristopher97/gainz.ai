# Gainz AI App
A Flutter application designed to track and count the number of jumping jacks performed by a user using real-time pose detection. The app provides an intuitive UI, real-time feedback, and a workout summary after each session.

# Features
- Real-time pose detection using the device's camera.
- Accurate counting of jumping jack reps based on body movement.
- Live camera feed with overlay showing detected key points and rep count.
- Workout summary displaying total reps, duration, and accuracy.
- Firebase integration (optional) for storing user workout data.
- Responsive design optimized for both Android and iOS platforms.

# Setup Instructions
Prerequisites
Ensure you have the following installed on your system:

- Flutter SDK: >=3.4.1 <4.0.0
- Dart SDK: Included with the Flutter SDK
- Android Studio or Visual Studio Code: Preferred IDEs for Flutter development
- Xcode: Required for building and testing on iOS devices

# Step 1: Clone the Repository

git clone https://github.com/otutuchristopher97/gainz.ai.git
cd gainz_ai_app

# Step 2: Install Dependencies

Run the following command in the project directory to install all the necessary dependencies:

- flutter pub get

# Step 3: Firebase Setup (Optional)
If you plan to use Firebase for storing workout data and user authentication, follow these steps:

- Create a Firebase project in the Firebase Console.
- Add both Android and iOS apps to the Firebase project.
- Download the google-services.json (for Android) and GoogleService-Info.plist (for iOS) and place them in the appropriate directories (android/app and ios/Runner respectively).
- Make sure to enable Firebase Authentication, Firestore, and Firebase Storage in the Firebase Console.

# Step 4: Running the App

To run the app on an emulator or a physical device, use the following command:

- flutter run

# Step 5: Running Tests

To run unit tests and widget tests, use:

- flutter run

# Project Structure
This project follows the Clean Architecture principles, which ensure separation of concerns, maintainability, and testability. The key layers in this architecture are:

- Presentation Layer: Manages the UI and user interactions.
    Flutter BLoC is used for state management, separating the business logic from the UI.
- Domain Layer: Contains business logic and use cases.
    This layer is independent of the other layers and can be tested without dependencies on Flutter.
- Data Layer: Handles data operations like accessing the camera for pose detection and storing data in Firebase.
Firebase is used for data storage (optional), and Google ML Kit for pose detection.

# Key Packages Used
- flutter_bloc: State management solution based on BLoC architecture.
- google_mlkit_pose_detection: Library for real-time pose detection using the device's camera.
- firebase_core, firebase_auth, cloud_firestore, firebase_storage: Firebase services for user authentication, Firestore database, and storage.
- shared_preferences: Local storage for caching user data.
- lottie: For adding animations.
- provider: Dependency injection and state management.
- dartz: Functional programming utilities.
- smooth_page_indicator: For creating page indicators in onboarding screens.