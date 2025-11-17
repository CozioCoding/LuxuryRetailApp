# LuxuryRetailApp

A modern luxury-shopping mobile app built with **SwiftUI**, featuring smooth UI animations, real product browsing, category filtering, and a stylish premium design system.  
This project serves as a clean portfolio example of scalable iOS architecture with modular views and best practices.

---

## Features

### 🛍️ Catalog & Product Pages
- Fetch and display products from JSON / API  
- Category chips  
- Sorting (price, rating, brand, etc.)  
- Advanced filters (price range, brand, etc.)  
- Lazy grids with pagination-ready structure  

### 💄 Product Experience
- Product detail page  
- Multiple images carousel  
- Luxury-style UI animations & gradients  

### 🛒 Shopping Cart
- Shared global `CartStore`  
- Add / remove items  
- Real-time price calculations  
- Cart badge on navigation  

### 🎨 Design System
- Custom **LuxuryGradient**  
- Consistent spacing & layout  
- Typography presets  
- Reusable components (chips, cards, filter sheet, sort menu)  

### ⚙️ Architecture
- MVVM  
- Clean separation of concerns  
- Reusable UI modules  
- `CatalogViewModel` handles state, filtering, sorting  

---

## Tech Stack

| Category | Technologies |
|---------|--------------|
| Language | Swift 5.10 |
| UI | SwiftUI |
| Architecture | MVVM, modular views |
| State | `@State`, `@EnvironmentObject`, `Observable` |
| Networking | URLSession / Local JSON |
| Tools | Xcode 16+ |

---

## Project Structure

```
LuxuryRetailApp/
├── Assets.xcassets/
│   ├── AccentColor.colorset/
│   │   └── Contents.json
│   ├── AppIcon.appiconset/
│   │   └── Contents.json
│   └── Contents.json
├── Cart/
│   ├── CartButton.swift
│   ├── CartStore.swift
│   └── CartView.swift
├── Data/
│   └── ProductRepository.swift
├── Models/
│   ├── PagedProducts.swift
│   └── Products.swift
├── Networking/
│   ├── APIClient.swift
│   └── Endpoints.swift
├── Presentation/
│   ├── Home/
│   │   └── HomeView.swift
│   ├── Catalog/
│   │   ├── CatalogView.swift
│   │   ├── CatalogViewModel.swift
│   │   ├── Components/
│   │   │   ├── CatalogCategoryChips.swift
│   │   │   ├── CatalogSkeletonCard.swift
│   │   │   └── ProductCard.swift
│   │   └── Filters/
│   │       ├── CatalogFilterSheet.swift
│   │       └── CatalogSortOption.swift
│   ├── Detail/
│   │   ├── DetailView.swift
│   │   └── DetailViewModel.swift
├── Theme/
│   └── LuxuryTheme.swift
├── Utils/
│   └── ImageCache.swift
└── LuxuryRetailAppApp.swift
```
## Screenshots

| Home | Catalog | Cart |
| --- | --- | --- |
| <img src="https://github.com/user-attachments/assets/cda775cf-61d0-4f6a-a825-95724eb87b0a" width="250" /> | <img src="https://github.com/user-attachments/assets/cf686e22-040c-4d14-8c1c-989d4a8a9413" width="250" /> | <img src="https://github.com/user-attachments/assets/79569610-9e09-401a-ae4b-4a672a7ac27d" width="250" /> |

| Filters | Product Details | Empty Cart |
| --- | --- | --- |
| <img src="https://github.com/user-attachments/assets/43c14e72-d9ef-4d51-b2d1-da0cc8d887e9" width="250" /> | <img src="https://github.com/user-attachments/assets/723b0c39-6951-4349-8c85-1e1eebf6c6e6" width="250" /> | <img width="250" src="https://github.com/user-attachments/assets/c059d5ee-0a8d-4ae5-b29a-a84e57217582" /> |


---

## Installation

```

Clone the repository:
git clone https://github.com/USERNAME/LuxuryRetailApp.git

Open the project:
open LuxuryRetailApp.xcodeproj

Build & run using Xcode 16+
```



