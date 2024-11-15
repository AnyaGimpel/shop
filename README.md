# Mobile App for Online Store on Flutter

![App Screenshots](assets/images/app_screens.jpg)

## Table of Contents

- [Project Description](#project-description)
- [Key Features](#key-features)
- [Technologies Used](#technologies-used)
- [Getting Started](#getting-started)
  - [Prerequisites](#prerequisites)
  - [Cloning the Repository](#cloning-the-repository)
  - [Running the Application](#running-the-application)

## Project Description

This Flutter-based mobile application is designed for an e-commerce store, allowing users to browse products, add them to their cart, adjust quantities, and remove items as needed. Product data is fetched from a remote API, and cart state is saved locally on the device for a seamless user experience.

## Key Features

- **Product Loading and Display**: On startup, the application fetches product data from a remote API and displays key information about each item.
  
- **Detailed Product View**: Tapping on a product opens a detailed view with comprehensive information and options to add the item to the cart or adjust its quantity.
  
- **Cart Management**: Users can add products to the cart, modify quantities, and remove items. A cart item count indicator is displayed in the navigation bar.

## Technologies Used

### Asynchronous Data Loading

- **HTTP Requests**: The `http` package is used for asynchronous data loading. Requests to the API run in the background, keeping the interface responsive. Product data is fetched from [https://dummyjson.com/products](https://dummyjson.com/products).

- **Error Handling**: The application checks network status and displays messages to the user in case of connection issues or other errors.

### State Management with Cubit

- **Cubit Pattern**: `Cubit` manages the application’s state, including catalog display, detailed product view, and cart state management.

### Dependency Injection

- **get_it Package**: The `get_it` package is used for dependency injection, including `ApiService` for API interactions and `CartStorage` for managing cart data.

### Local Data Storage with SharedPreferences

- **Cart Data Caching**: Cart data and quantities are saved locally using `SharedPreferences`, allowing the cart state to persist even when the app is restarted.

### Screen Navigation

- **Main Screen**: Displays the product list loaded from the API with key details.
  
- **Product Detail Screen**: Shows detailed information about a selected product, including its image, price, and description.
  
- **Cart Screen**: Displays items added to the cart with options for quantity adjustment and item removal.

### Adaptive Interface

- **Responsive Design**: The application’s design supports various screen resolutions, ensuring an optimal and consistent experience on both smartphones and tablets. Adaptive controls and font adjustments make interaction comfortable on all screen sizes.

---
## Getting Started

This guide will help you set up the environment, clone the repository, and run the Flutter-based e-commerce application on your local machine.

### Prerequisites

Ensure you have the following installed:
1. **Flutter SDK**: [Install Flutter](https://docs.flutter.dev/get-started/install) following the official guide.
   - Add Flutter to your system path for easy access.
   - Verify your setup by running:
     ```bash
     flutter doctor
     ```
2. **Android Studio** or **Visual Studio Code**:
   - **Android Studio** for Android Emulator or **VS Code** with Flutter/Dart extensions.
3. **Device for Testing**: Set up an Android Emulator or connect a physical Android device with USB debugging enabled.

### Cloning the Repository

Clone the project repository with:

```bash
git clone https://github.com/AnyaGimpel/shop.git
```

## Running the Application

Navigate into the project folder:

```bash
cd shop
```
Run the following command to install project dependencies:
```bash
flutter pub get
```
Start an Emulator

Use the following command to start the app:
```bash
flutter run
```
Alternatively, in Android Studio or VS Code, open the project folder and click Run or Debug to deploy on the device/emulator.

## You’re all set!

