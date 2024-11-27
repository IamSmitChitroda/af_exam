# Flutter Contacts Manager

A simple **Contacts Manager App** built with **Flutter** and **GetX** state management. The app allows users to:  
- Add, edit, and delete contacts.
- Switch between light and dark themes (stored using `SharedPreferences`).
- Save and manage contacts locally using `Sqflite`.
- Backup and restore contacts to/from **Firebase** for added security.

---

## Features

- **Theme Management**: Toggle between light and dark themes, persisted across sessions.
- **Contact Management**:
  - Add new contacts with a name and number.
  - Edit or delete existing contacts.
- **Local Storage**: Contacts are stored in the local database using `Sqflite`.
- **Firebase Backup**:
  - Backup all contacts to Firebase Firestore.
  - Restore contacts from Firebase anytime.
  
---

## Screenshots

| Light Theme  | Dark Theme |
| ------------- | ---------- |
| ![Light](path_to_light_screenshot) | ![Dark](path_to_dark_screenshot) |

---

## Setup Instructions

1. **Clone the Repository**
   ```bash
   git clone https://github.com/IamSmitChitroda/af_exam.git
   cd ad_exam
