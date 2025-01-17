Here's the updated README to reflect that you're using **SQLite** for offline data storage, and that users can only **add expenses** and **filter by month, year, or category**:

---

# Expense App
![expenses](https://github.com/user-attachments/assets/ca07a714-cc78-45c1-8e80-31eeffd9d411)

A simple and responsive **Expense Tracker** built with **Flutter**, featuring **theme management**, state handling using **BLoC** and **Provider**, and an **SQLite database** for storing data locally. This app allows users to add expenses, filter them by month, year, or category, and manage different user profiles securely.

## Features

- **Flutter UI**: Cross-platform compatibility with a clean, responsive design.
- **Theme Management**: Toggle between light and dark modes for better accessibility.
- **Expense Management**: Add expenses with relevant details like amount, category, and date.
- **Data Filtering**: Filter expenses by **Month**, **Year**, or **Category** for better insights.
- **User Profiles**: Manage different user profiles securely and seamlessly.
- **Offline Database (SQLite)**: All user data (expenses and profiles) are stored locally on the device using SQLite.
- **State Management**:
  - **BLoC**: For scalable and complex state management.
  - **Provider**: For simpler state management needs and dependency injection.

## Technologies Used

- **Flutter** (UI framework)
- **Dart** (Programming language)
- **BLoC** (State management)
- **Provider** (State management and dependency injection)
- **SQLite** (Offline local database for storing expenses)
- **MVVM** (Model-View-ViewModel architecture)

## Getting Started

### Prerequisites

Ensure you have the following installed on your machine:

- Flutter SDK: [Install Flutter](https://docs.flutter.dev/get-started/install)
- Dart SDK (comes with Flutter)
- A code editor like [Visual Studio Code](https://code.visualstudio.com/) or [Android Studio](https://developer.android.com/studio)

### Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/SauravPatel31/expense_app.git
   ```
2. Navigate to the project directory:
   ```bash
   cd expense_app
   ```
3. Fetch dependencies:
   ```bash
   flutter pub get
   ```
4. Run the app:
   ```bash
   flutter run
   ```

The application will launch on a connected device or emulator.

## Usage

- **Add Expenses**: Enter your expenses with relevant details like amount, category, and date.
- **Filter Data**: View your expenses filtered by **Month**, **Year**, or **Category** to get better insights into your spending habits.
- **Manage Multiple Profiles**: Create and switch between different user profiles.
- **Offline Storage**: All your data is securely stored offline on the device using SQLite, ensuring accessibility even without an internet connection.

## Contributing

Contributions are welcome! Follow these steps:

1. Fork the repository.
2. Create a feature branch:
   ```bash
   git checkout -b feature-name
   ```
3. Commit your changes:
   ```bash
   git commit -m "Add a meaningful message"
   ```
4. Push your changes:
   ```bash
   git push origin feature-name
   ```
5. Submit a pull request.

## Acknowledgements

- Thanks to the Flutter community and open-source libraries used in this project.

## Contact

- **Author**: Saurav Patel
- **Email**: [sauravp3103@gmail.com](mailto:sauravp3103@gmail.com)
- **GitHub**: [SauravPatel31](https://github.com/SauravPatel31)

---

Let me know if you'd like to make any further adjustments!
