# Flutter templete
This is a templete project with all basic setup completed and support for web

Current Flutter Version -> 3.35.7
Current Dart Version -> 3.9.2

## What's Included?
This Flutter project includes the following features and components:

### Features
- **Flutter Flavors**: Supports multiple environments (e.g., dev, staging, production) for easy configuration.
- **Screen Responsiveness**: Utilizes `flutter_screenutil` to adapt UI components dynamically across different screen sizes.
- **Theme Switching**: Implements dark and light mode with data managed via shared preferences.
- **Dependency Injection**: Uses `getIt` for service locator-based dependency injection.
- **State Management**: Utilizes `Flutter Bloc` for efficient and scalable state management.

### Components
- **Device Info Service**: Get all required device data for android, ios and web.
- **App Imports**: Centralized file containing all basic imports.
- **App Extensions**:
  - Dark mode support.
  - String casing utilities.
  - TextStyle extensions.
  - Base API Extensions - Parse data from map or list to Given Object or List
- **Text Widget**: A reusable widget to manage text styling and size consistency.
- **Parse Service**: Handles type parsing with error management.
- **Constants**:
  - Color definitions.
  - Environment configurations.
  - Theme settings.
  - Preference keys.
- **Localization Support**: Implement multi-language support.
- **Routing Improvements**: Enhance navigation structure with a robust routing mechanism - goRouter.
- **API Service**:
  - Handles fetching of normal or paginated data and parse into [Object] or [PaginatedModel] with help of [base_api_extension].

  #### Example Of Api Service using flutter bloc
  > Use this inside your bloc for api calling

  Pagination API:

  ```dart
  Future<void> _getPaginatedDataExample(
      GetPaginatedDataEvent event, Emitter<PaginatedDataState> emit) async {
    if (event.refresh) {
      emit(state.copyWith(
          paginatedDataState: const PaginationLoadingState()));
    }

    if (state.paginatedDataState.currentPage <=
        state.paginatedDataState.lastPage) {
      PaginationState<PaginatedDataModel> dataPaginationState =
          await ApiService.fetchPaginatedData<PaginatedDataModel>(
        currentState: state.paginatedDataState,
        apiCall: () => getIt<ApiRepo>().getPaginatedDataApiSample(
          pageNo: state.paginatedDataState.currentPage,
        ),
        fromJson: PaginatedDataModel.fromJson,
      );

      emit(state.copyWith(paginatedDataState: dataPaginationState));
    }
  }
  ```

  Normal API:
  
  ```dart
  Future<void> _getNormalDataExample(GetNormalEvent event, Emitter<NormalDataState> emit) async {
    emit(state.copyWith(normalDataState: const NormalLoadingState()));

    final result = await ApiService.fetchNormalData(
      apiCall: () =>
          getIt<ApiRepo>().getNormalDataApiSample(someParams: event.someParams),
      fromJson: NormalDataModel.fromJson,
    );
    emit(state.copyWith(normalDataState: result));
  }
  ```

## Getting Started
1. Clone the repository.
2. Run `flutter pub get` to install dependencies.
3. Configure your desired flavor using the appropriate environment setup.
4. Run the app using `flutter run --flavor {flavor_name}`.

## Contributions
Contributions are welcome! Please submit a pull request with your changes.

## License
This project is open-source and available under the MIT License.

