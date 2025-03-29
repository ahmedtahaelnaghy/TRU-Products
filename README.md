# Products List

This repository contains a Swift-based **Products List** application implementing **Clean Architecture** with **Combine**, **CoreData** for caching, and **SkeletonView** for loading indicators.

## Features
- Fetch and display a list of products
- API calls only when the internet connection is available
- Offline mode with **CoreData** as a local cache
- **SkeletonView** for a smooth loading experience
- **MVVM (Model-View-ViewModel)** architecture
- Dependency Injection
- **Combine** for reactive programming

## Architecture
The project follows **Clean Architecture** principles with the following layers:

- **Presentation Layer**: Views, ViewModels, Skeleton loading effects
- **Domain Layer**: Business logic, use cases
- **Data Layer**: Repository pattern, API handling, CoreData caching
- **Entity Layer**: Shared models

### Flow Diagram
```
View ↔ ViewModel ↔ UseCase ↔ Repository ↔ API/CoreData
```

## Technologies Used
- Swift
- Combine
- UIKit
- CoreData (for caching offline data)
- URLSession (for API calls)
- SkeletonView (for smooth loading indicators)
- Custom Network Monitor Class (to check internet connectivity)
- Dependency Injection
