# E-commerce Mobile App on Flutter

![App Screenshots](assets/images/app_screenshot.png)

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

