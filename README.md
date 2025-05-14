# Flutter templete
This is a templete project with all basic setup completed

## What's Included?
This Flutter project includes the following features and components:

### Features
- **Flutter Flavors**: Supports multiple environments (e.g., dev, staging, production) for easy configuration.
- **Screen Responsiveness**: Utilizes `flutter_screenutil` to adapt UI components dynamically across different screen sizes.
- **Theme Switching**: Implements dark and light mode with data managed via shared preferences.
- **Dependency Injection**: Uses `getIt` for service locator-based dependency injection.
- **State Management**: Utilizes `Flutter Bloc` for efficient and scalable state management.

### Components
- **App Imports**: Centralized file containing all basic imports.
- **App Extensions**:
  - Dark mode support.
  - String casing utilities.
  - TextStyle extensions.
- **Text Widget**: A reusable widget to manage text styling and size consistency.
- **Parse Service**: Handles type parsing with error management.
- **Constants**:
  - Color definitions.
  - Environment configurations.
  - Theme settings.
  - Preference keys.
- **Localization Support**: Implement multi-language support.
- **Routing Improvements**: Enhance navigation structure with a robust routing mechanism - goRouter.

## Getting Started
1. Clone the repository.
2. Run `flutter pub get` to install dependencies.
3. Configure your desired flavor using the appropriate environment setup.
4. Run the app using `flutter run --flavor {flavor_name}`.

## Contributions
Contributions are welcome! Please submit a pull request with your changes.

## License
This project is open-source and available under the MIT License.

