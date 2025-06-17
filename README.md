# Blog App

A Flutter blog application built with Clean Architecture principles, utilizing Supabase for authentication, data storage, and image storage. The app allows users to sign up, log in, create and read blogs, with `get_it` for dependency injection.

## Table of Contents

- [Features](#features)
- [Architecture](#architecture)
- [Prerequisites](#prerequisites)
- [Usage](#usage)
- [Project Structure](#project-structure)
- [Dependencies](#dependencies)
- [Contributing](#contributing)

## Features

- Login and Signup using Supabase Authentication
- Create a blog post with title, content, and image
- Read and list all blog posts
- Upload and retrieve images via Supabase Storage
- Clean Architecture: Separation of concerns in Presentation, Domain, and Data layers
- Dependency Injection with `get_it`

## Architecture

The project follows Clean Architecture with the following layers:

1. **Presentation Layer**: Flutter UI, state management, and widgets
2. **Domain Layer**: Business logic, use cases, entities
3. **Data Layer**: Repositories, Supabase data sources, models

Dependencies are decoupled and injected using the `get_it` package.

## Prerequisites

- [Flutter](https://flutter.dev/docs/get-started/install) >= 3.0.0
- [Dart](https://dart.dev/get-dart) SDK
- Supabase account

## Usage

1. Sign up or log in.
2. Create new blog posts by tapping the `+` button.
3. View existing posts in the feed.
4. Tap on a post to read its details.

## Project Structure

```
lib/
├── core/           # Common utilities, constants, network helpers
├── data/
│   ├── models/     # Data models
│   ├── sources/    # Supabase API implementations
│   └── repositories/ # Repository implementations
├── domain/
│   ├── entities/   # Business entities
│   ├── repositories/ # Repository interfaces
│   └── usecases/   # Use case classes
├── presentation/
│   ├── pages/      # UI pages
│   ├── providers/  # Riverpod or Bloc providers
│   └── widgets/    # Reusable widgets
├── injection_container.dart # `get_it` setup
└── main.dart       # App entry point
```

## Dependencies

- `flutter`
- `get_it`
- `supabase_flutter`
- `flutter_bloc` (or Bloc/MobX)
- `image_picker`

## Contributing

Contributions are welcome! Please open an issue or submit a pull request.
