# Changelog

All notable changes to this project will be documented in this file.

## [Unreleased]
### Added
- Feature
  - Auth
    - Configure the sign in with email/password process
    - Configure the sign-up with email/password process
- Implement **Firebase** and configure for all platforms

### Changed
- Feature
  - Auth
    - Update data source and repository for auth implementation
    - Update unit tests for auth feature
    
### Removed
- Feature
  - Auth
    - Remove kwadra-api implementation for auth data source and repository

## [0.2.0] - 2024-05-19
### Added
- Feature
  - **Auth**
    - **auth** directory in both **lib** and **test** directories
    - First implementation of dumb feature to test overall architecture flow
    - Write first unit tests and mocks to validate testing setup and architecture
    - First Bloc pattern creation with **auth_bloc**/**auth_event**/**auth_state**
    - Basic **sign_in_screen** and dumb **sign_up_screen** (for navigation testing)
    - Basic **sign_in_form**
- Bloc pattern
  - Configure Bloc observer in **app_bloc_observer.dart**
  - Configure Bloc initialisation in **main.dart**
- Dependency injection
  - Configure **get_it** package into **di_container.dart** 
  - Add the first injections to DI container
- Routing
  - Configure routing in **app_router.dart** 
- Environment variable management
- **test** directory that mirrors the **lib** directory
- **failure.dart** file in **lib/core/error** directory
  - Include a basic set of specific failures (to be upgraded) 
- **exceptions.dart** file in **lib/core/error** directory
  - Include a first specific server exception (to be upgraded)
- Packages:
  - **bloc_test** 
  - **build_runner** 
  - **dartz** 
  - **equatable** 
  - **flutter_bloc** 
  - **flutter_dotenv** 
  - **flutter_test** 
  - **get_it**
  - **go_router**
  - **http** 
  - **json_serializable** 
  - **mocktail** 

### Changed
- **lib** directory structure
- Android app icons
- iOS app icons 

## [0.1.0] - 2024-05-18
### Added
- Empty Flutter project
- LICENSE.txt
- CHANGELOG.md
- README.md
### Removed
- Unnecessary content in **main.dart**
- Unnecessary content in **pubspec.yaml**

[0.2.0]: https://github.com/nikoden-io/Kwadra-UI/tree/0.2.0
[0.1.0]: https://github.com/nikoden-io/Kwadra-UI/tree/0.1.0

--- 

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).
