# 🌦️ MetroSky: Next-Gen Realistic Weather App in Flutter

**MetroSky** is an ultra-polished, hyper-realistic, fluid Flutter weather application inspired by Apple Weather and Overdrop. Built with Feature-First Clean Architecture, Riverpod 2.0 (code generation), Impeller fragment shaders, MapLibre radar integration, and Stale-While-Revalidate offline caching via Hive.

---

## ✨ Features & Highlights

- **Dynamic Ambient Atmosphere**: Real-time celestial sky gradients driven by local solar elevation (Night, Civil Twilight, Golden Hour, Daytime).
- **GPU-Accelerated Shaders**: Rain streak and snowfall particle simulations running on Flutter's Impeller engine with 60/120 FPS performance and near-zero battery drain.
- **Dynamic Home Dashboard**:
  - Hero condition view with animated Meteocons vectors.
  - 24-hour horizontal hourly forecast with temperature spline curve.
  - 7 to 14-day expanded daily forecast with high/low temperature gradient range bars.
  - Bento-grid weather metrics cards (Air Quality, UV Index, Wind Compass, Sunrise/Sunset tracker, Barometer, Dew Point).
- **Interactive Radar Map**: MapLibre GL vector basemaps with animated RainViewer radar precipitation overlay tiles and time-scrubber playback controls.
- **Location Management**: Debounced geocoding search, reorderable favorites list with swipe-to-delete, and animated mini-condition cards.
- **Offline-First Resilience**: Instant UI hydration from Hive CE storage with background Stale-While-Revalidate (SWR) synchronization.

---

## 🛠️ Architecture & Tech Stack

| Domain | Technology / Library | Purpose |
| :--- | :--- | :--- |
| **SDK & Version Management** | [FVM (Flutter Version Management)](https://fvm.app/) | Deterministic team-wide Flutter SDK pinning (`stable`) |
| **Architecture** | Feature-First Clean Architecture | `presentation`, `domain`, `data` per feature + reusable `core` |
| **State Management** | `flutter_riverpod` & `riverpod_annotation` | Compile-time safe, reactive async state management |
| **Data & Immutability** | `freezed` & `json_annotation` | Immutable value objects, union types, JSON parsing |
| **Networking & HTTP** | `dio` | Custom caching, retry policies, and error interceptors |
| **Local Persistence** | `hive_ce` & `hive_ce_flutter` | High-speed NoSQL key-value box caching for offline states |
| **Location & Maps** | `geolocator`, `latlong2`, `maplibre_gl` | GPS coordinates, geofencing, and vector radar map |
| **Routing** | `go_router` | Declarative routing with stateful nested shell routes |
| **Icons & Micro-Animations** | `lucide_icons`, `lottie`, `flutter_animate` | High-contrast vector glyphs and condition choreography |
| **Visual Effects & Shaders** | Impeller GLSL Fragment Shaders (`.frag`) | Ambient weather physics and celestial gradients |

---

## 📂 Project Structure

```
lib/
├── app.dart                  # Global MaterialApp.router configuration
├── main.dart                 # App initialization, Hive boxes, ProviderScope
├── core/                     # Globally reusable cross-cutting foundation
│   ├── constants/            # API endpoints, WMO condition codes, layout constants
│   ├── error/                # AppFailure, Dio error mapping, custom exceptions
│   ├── network/              # Dio client, cache & retry interceptors
│   ├── persistence/          # Hive storage service, box managers, adapters
│   ├── router/               # GoRouter routes and navigation shell
│   ├── theme/                # Glassmorphism tokens, color palettes, typography
│   ├── utils/                # Date helpers, temperature converters, solar math
│   └── widgets/              # Globally reusable UI components (GlassCard, Shimmers, etc.)
│
└── features/                 # Modular vertical feature slices
    ├── weather/              # Forecast, hourly/daily trends, bento metrics
    ├── location/             # City search, geocoding, saved favorites
    ├── radar/                # MapLibre map view, RainViewer raster tile playback
    ├── visual_engine/        # Fragment shader controllers, celestial sky canvas
    └── settings/             # Unit preferences (°C/°F, km/h/mph), appearance
```

---

## 🚀 Getting Started with FVM

This project uses [FVM](https://fvm.app/) to ensure version consistency across all environments.

### 1. Prerequisites
Ensure `fvm` is installed:
```bash
dart pub global activate fvm
```

### 2. Setup Flutter SDK
```bash
# Fetch and use the pinned Flutter SDK
fvm install
fvm use stable

# Install pub dependencies
fvm flutter pub get
```

### 3. Generate Code
Run `build_runner` for Riverpod, Freezed, and JSON serialization:
```bash
fvm flutter pub run build_runner build --delete-conflicting-outputs
```

### 4. Run Application
```bash
fvm flutter run
```

---

## 🧪 Code Quality & Verification

In accordance with our anti-vibe-coding and developer mastery policy:
```bash
# Static analysis (Enforcing 0 errors, 0 warnings)
fvm flutter analyze

# Unit & Widget Tests
fvm flutter test
```

For agent guidelines and development guardrails, see [AGENTS.md](AGENTS.md).
