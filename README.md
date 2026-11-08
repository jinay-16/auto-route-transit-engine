# AutoRoute: Intelligent Multi-Modal Transit Mesh & Booking Platform
### Pune ⇄ Lonavala ⇄ Mumbai High-Reliability Corridor

[![Java 21](https://img.shields.io/badge/Java-21-orange.svg)](https://openjdk.org/projects/jdk/21/)
[![Spring Boot](https://img.shields.io/badge/Spring%20Boot-3.3.3-green.svg)](https://spring.io/projects/spring-boot)
[![Build Status](https://img.shields.io/badge/Build-Passing%20(16%2F16%20Tests)-brightgreen.svg)]()
[![Frontend](https://img.shields.io/badge/Frontend-12%20Interactive%20Views-blue.svg)]()

---

## 🌟 Overview

**AutoRoute** is an end-to-end multi-modal transit routing, last-mile feeder mobility, peer-to-peer ride sharing, and concurrent ticketing engine. It connects intercity high-speed rail (Vande Bharat, Deccan Queen), regional express buses (Shivneri, Maharashtra State Express), metro rail corridors (Pune Purple Line, Mumbai Aqua Line 3), and first/last-mile feeder mobility (Auto-Rickshaws, Cabs, Bike Taxis, Walkways).

---

## 🚀 How to Run the Project

### Option 1: Full-Stack Mode (Recommended)
Double-click **`run.bat`** (or execute from terminal):
```powershell
.\mvnw.cmd spring-boot:run
```
Open your browser to:
👉 **`http://localhost:8080/dashboard.html`** or **`http://localhost:8080/index.html`**

*Note: The platform features a **Resilient DataSource** (`ResilientDataSourceConfig.java`). If local MySQL 8.0 on port 3306 is reachable, it uses MySQL; if MySQL is unavailable or has different credentials, it automatically falls back to an embedded high-performance H2 database running in MySQL-compatibility mode with automated data seeding!*

### Option 2: Standalone Browser Mode (No Server Required)
Double-click `dashboard.html` or `index.html` directly in Chrome, Edge, Safari, or Firefox. All 12 pages link via relative URLs.

---

## 🖥️ 13 Complete Interactive Views (Left-Side Sidebar Navigation)

All platform pages feature a sleek **Left-Side Sidebar Navigation** with active page indicator, Transit Pay Fast-Tag wallet widget, commuter profile badge, and light/dark theme switch.

| Page | File | Key Features & Backend Linkage |
| :--- | :--- | :--- |
| **Home Showcase** | `landing.html` | Corridor overview, live corridor departure board with direct 1-click booking, feature highlights, and interactive FAQ accordion. |
| **Plan Journey** | `index.html` | Origin/destination interchange selector, quick corridor chip presets, strategy optimizer (Fastest, Cheapest, Fewest Transfers), last-mile toggle. |
| **Commuter Dashboard** | `dashboard.html` | Transit ID, Gold Tier badge, Transit Pay wallet (live balance, Auto-Reload), live trip progress tracker, Fast-Tag Turnstile scanner simulation. |
| **Route Results** | `route-results.html` | Live backend Dijkstra routing results, Strategy filter buttons (Fastest, Cheapest, Transfers, Eco), coach density heatmap, last-mile feeder options, delay insurance. |
| **Journey Details** | `journey-details.html` | In-depth leg-by-leg timeline, interchange buffer times, train/bus/metro vehicle specs, platform skywalk wayfinder, station concourse map. |
| **Seat Selection** | `seat-selection.html` | Coach switching (C1 Exec, C2 AC, C3 AC, C4 AC), live 2×3 seat blueprint grid, dynamic fare calculation, backend booking creation. |
| **Smart Pass** | `smart-pass.html` | Digital ticket with dynamic auto-refreshing QR code, confirmed PNR, last-mile cohort carpool details (pickup bay, co-passengers, PIN), PDF download, return trip planner. |
| **Journey Simulator** | `journey-simulator.html` | Planning sandbox / What-if simulator with timing shifts (-30m, +15m, +45m), segment closures, baseline comparison, and 1-tap booking update. |
| **Disruption Simulator**| `disruption-simulator.html`| Interactive Bhor Ghat landslide & monsoon delay injection slider, dynamic Dijkstra bypass calculation, and animated SVG failover curve with 1-click pass update. |
| **Notifications** | `notifications.html` | Real-time corridor telemetry, interactive category filtering (Disruptions, Waitlist, Offers, Archived), live search filter, mark all as read, delivery rules config. |
| **Commuter Profile** | `profile.html` | Profile management, Transit ID (DigiLocker linked), saved stations presets editor, Transit Pay recharge with live wallet synchronization. |
| **AI Travel Assistant** | `ai-assistant.html` | Context-aware AI assistant grounded in backend tools (`findRoutes`, `checkSeats`, `explainFare`), answering natural queries with zero hallucination. |
| **Authentication** | `login.html` | Live JWT-based sign-in with BCrypt verification, account registration, guest passenger access, and offline session fallback. |

### 🔑 Demo Accounts Seeded Out-Of-The-Box:
- **Default Commuter**: `rahul.deshmukh@autoroute.in` / `password123` (₹1,450.00 Wallet, Gold Tier)
- **Commuter 2**: `aditya@autoroute.com` / `password123`
- **Commuter 3**: `sneha@autoroute.com` / `password123`
- **Transit Admin**: `admin@autoroute.com` / `password123`

---

## 🏗️ Backend Architecture & OOP/DSA Highlights

- **Adjacency-List Graph (`TransitNetworkGraph.java`)**: Models stations as nodes and directed transit segments as edges.
- **Dijkstra Engine (`DijkstraEngine.java`)**: Min-heap `PriorityQueue` solving shortest paths under configurable strategies (`FastestRouteStrategy`, `CheapestRouteStrategy`, `FewestTransfersRouteStrategy`, `ReliableRouteStrategy`).
- **Concurrency Protection (`ReentrantLock`)**: Segment-keyed lock map with double-checked locking, completely eliminating double-booking under race conditions.
- **FIFO Waitlist Queue**: Thread-safe vacancy promotion automatically reallocates newly opened seats to the earliest waiting passenger.
- **Spatiotemporal Ride Sharing (`RideMatchingService.java`)**: Deterministic carpool scoring algorithm based on detour distances and departure synchronization.
- **Automated Data Seeder (`NetworkDataSeeder.java`)**: Populates 9 stations, 6 transit vehicles, 12 segments, pre-generated schedules, and seats.

---

## 🧪 Testing Suite (16 Automated Tests)

Run all JUnit 5 test suites by double-clicking **`test.bat`** or running:
```powershell
.\mvnw.cmd test
```

### Verified Passing Tests:
1. `AITravelAssistantTest` — Tool registry invocation & zero-hallucination validation.
2. `ConcurrentBookingTest` — **100 concurrent threads competing for 20 seats** with 0 overbooking.
3. `WaitlistPromotionTest` — Automatic promotion of FIFO waitlist queue upon ticket cancellation.
4. `VehicleAndMobilityFactoryTest` — Creational factory validation for trains, buses, and feeder vehicles.
5. `LastMileServiceTest` — Walk, auto, cab, bike feeder estimates with weather surge.
6. `UserInheritanceTest` — OOP inheritance, role hierarchy, and BCrypt password encryption.
7. `VehiclePolymorphismTest` — Polymorphic vehicle types, fare calculations, and seat configurations.
8. `DijkstraRoutingTest` — Graph pathfinding across the Pune–Mumbai network.
9. `RouteStrategyAndExplanationTest` — Human-readable rationale comparisons.
10. `RideMatchingServiceTest` — Spatiotemporal ride matching and fare split calculation.
11. `FareStrategyTest` — Bus, Train, Metro, Auto, Cab, Bike fare computation strategies.

---

## 📁 Project Structure

```
autoroute-project/
├── run.bat                            # 1-Click launcher for full-stack application
├── test.bat                           # 1-Click test runner
├── pom.xml                            # Maven build configuration (Java 21 + Spring Boot 3.3.3)
├── database/                          # MySQL DDL and seed scripts
│   ├── schema.sql
│   └── seed.sql
├── docs/                              # Comprehensive architectural specifications
│   ├── ARCHITECTURE.md
│   ├── OOP_DSA_DESIGN.md
│   ├── CONCURRENCY_WAITLIST.md
│   ├── API_DOCUMENTATION.md
│   └── DATABASE_SCHEMA.md
├── src/
│   ├── main/java/com/autoroute/       # Complete backend (127 Java source files)
│   │   ├── algorithm/                 # DijkstraEngine, TransitNetworkGraph
│   │   ├── config/                    # ResilientDataSourceConfig, WebConfig
│   │   ├── controller/                # Journey, Booking, User, Mobility, Assistant APIs
│   │   ├── service/                   # BookingService, JourneyService, UserService
│   │   ├── model/                     # User, Passenger, Admin, TransitVehicle
│   │   └── integration/               # AI Tool Registry, Google Transit Adapter
│   ├── main/resources/static/         # Embedded frontend assets served by Spring Boot
│   └── test/java/com/autoroute/       # 16 passing JUnit 5 tests
├── dashboard.html                     # Commuter dashboard & Fast-Tag turnstile scanner
├── index.html                         # Plan journey search & feeder selector
├── route-results.html                 # Route comparator & transfer wayfinder
├── journey-details.html               # Leg-by-leg schedule & GPS telemetry
├── seat-selection.html                # Interactive seat blueprint & concurrency booking
├── smart-pass.html                    # Dynamic QR pass & cohort carpool pool pass
├── journey-simulator.html             # What-if planning sandbox
├── disruption-simulator.html          # Dynamic delay slider & failover simulator
├── notifications.html                 # Corridor notification feed
├── profile.html                       # Profile & Transit Pay wallet manager
├── login.html                         # Sign in & account registration
├── style.css                          # Custom animations, gradients, and styling
└── js/autoroute-desktop.js            # Unified REST client connecting all 12 pages
```
