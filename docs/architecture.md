# Weather App Architecture & Technical Specifications

## 1. Overview
Next-Gen realistic weather application built with Flutter, targeting high performance (60/120 FPS), visual tactility, offline resilience, and clean separation of concerns.

## 2. Architectural Paradigm
- **Feature-First Clean Architecture**: Slices features vertically into `presentation`, `domain`, and `data` layers.
- **Core Layer (`lib/core/`)**: Houses cross-cutting concerns (Network, Persistence, Theme, Router, Shaders, Utils, and Global Design System Widgets).
  - Every component in `core/` is designed for **global reusability** with clear, intentional naming conventions.
  - Core widgets adhere to the design system (Glassmorphism, BackdropFilter, custom borders, Shimmers).
- **State Management**: `flutter_riverpod` with code generation (`@riverpod`, `AsyncNotifier`).
- **Data Modeling & Serialization**: `freezed` with `json_serializable` for compile-time immutability and union states.
- **Offline Storage**: `hive_ce` / `hive_ce_flutter` implementing Stale-While-Revalidate (SWR) caching.

## 3. APIs & Integrations
- **Weather Forecast & Metrics**: Open-Meteo REST API (100% free, zero-key, high-resolution models, 168-hour hourly, solar azimuth, elevation, and air quality).
- **Radar Layer**: RainViewer public raster tile API layered onto `maplibre_gl` with vector basemap styling.
- **City Search & Geocoding**: Open-Meteo Geocoding API with debounced queries and worldwide coordinate resolution.

## 4. Visuals & Realism Pipeline
- **Ambient Particles & Atmosphere**: SkSL / Impeller Fragment Shaders (`.frag`) for rainfall streaks, snowfall drift, and lightning flash opacities with minimal CPU/battery overhead.
- **Dynamic Celestial Gradient**: Real-time sky palette interpolation calculated from local solar elevation angle:
  - Night: deep obsidian navy.
  - Twilight & Golden Hour: rich purple, amber, and coral tones.
  - Daytime: bright azure gradients.
- **Icons**: Lucide vector icons (`lucide_icons`) for weather metrics and Meteocons Lottie vectors for condition states.
- **Aesthetic**: Premium glassmorphism with backdrop blur (`BackdropFilter`), subtle gradient borders, and high-contrast typography.
