# art_gallery

Art gallery app demo for accessing art-related data, including artworks, collections, and exhibits.

## 1. GitFlow
Branches: main
Commit name structure: Description
Merge request should contain no more than 40 files

## 2. Architecture
Clean Architecture + BloC
Dependency Injection: app_di.dart
Data layer: repository implementations
Domain layer: inputs, models, repository interfaces
Presentation layer: UI(Flutter) + BloC(Dart)

Note: Domain folder && UseCases && Providers are intentionally omitted as this is a demo application
which does not imply further support and expansion and a full-fledged clean architecture is too heavy for this.

## 3. API
Integration with the Art Institute of Chicago Open API
Base url: https://api.artic.edu/api/v1

## 4. Code Style
Effective Dart: https://dart.dev/effective-dart
Linter rules: analysis_options.yaml

## 5. Concurrency
Dart Async, Rxdart

## 6. Navigation
AutoRoute (https://pub.dev/packages/auto_route)

## 7. Logging
Dio logging interceptor for every HTTP request and response

## 8. Approach for working with UI
Each screen widget includes the necessary BlocProvider for state management
Follow the principle of "one file per widget" to ensure modularity and maintainability

## 9. Supported platforms
Mobile - iOS and Android
