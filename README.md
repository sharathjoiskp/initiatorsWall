# Flutter App with BLoC and Firestore Integration

## Overview
This Flutter application allows users to log in with their email and password, create posts, and view real-time data updates. It utilizes the BLoC (Business Logic Component) pattern for state management and Firestore as the backend for data storage.

## Features

### User Authentication
- Users can log in using their email and password.
- If an account does not exist, users can create a new account.

### Post Creation
- After logging in, users can create posts.
- Posts are saved in Firestore and are accessible in real-time.

### Real-Time Data Display
- The app fetches and displays posts in real-time.
- Users can view all posts created during their session.

### Session Management
- User data is retained until they log out.
- On logout, users are redirected to the login screen.

## Installation

1. Clone the repository:
   ```
   git clone https://github.com/sharathjoiskp/initiatorsWall.git
2. Navigate to the project directory:
   ```
   cd initiatorsWall
3. Install dependencies:
   ```
   flutter pub get
4. Configure Firebase:
   Follow the Firebase setup documentation to configure your project with Firebase.
   ```
   https://firebase.google.com/docs
6. Run the app:
   ```
   flutter run
