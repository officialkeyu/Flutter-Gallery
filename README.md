# Event Management System - Android App (Assessment Submission)

This Android application was built as part of a mobile development assessment. It showcases skills in Kotlin development, MVVM architecture, API integration, pagination, map integration, UI design, and user interaction.

## 🚀 Features Implemented

### Screen 1: Discover Events
- **Search** events by name.
- **Pagination** – loads 20 events at a time.
- **Pull-to-refresh** functionality.
- **Map icon** in the top-right navigates to Event Map screen.
- **Validation and user-friendly toasts/messages** for better UX.
- Built using **MVVM** pattern with clean separation of concerns.
- Minimum API calls using efficient logic and caching.

### Screen 2: Event Details
- Carousel image viewer for event images.
- Back navigation to Discover screen.
- Event details fully mapped and rendered.

### Screen 3: Event Map
- Google Maps integration.
- Markers for each event.
- Swipe left/right to browse events and auto-highlight markers.
- Bottom card displays event details for the selected marker.
- Back button to return to Discover screen.

## Bonus Features

- **Category filtering** using Material `ChipGroup`.
- Custom vector assets used to keep app size minimal.
- Proper API call validations and user feedback via Toast messages.

## Tech Stack

- **Language**: Kotlin
- **Architecture**: MVVM (ViewModel + LiveData)
- **Network**: Retrofit + Coroutines
- **Image Loading**: Glide
- **UI Components**: RecyclerView, ViewPager2, ChipGroup
- **Maps**: Google Maps SDK
- **Design**: Material Design Components
- **Tools**: Android Studio Meerkat Feature Drop | 2024.3.2 Patch 1

API Reference
GET http://18.208.147.119/events – Get all events (with pagination)
GET http://18.208.147.119/events/:id – Get event by ID
GET http://18.208.147.119/event-categories - Get event categories for filter



