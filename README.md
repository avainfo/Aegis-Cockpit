# 🚀 Aegis Cockpit – Digital Cockpit Platform

## 📖 Overview

**Aegis Cockpit** is a high-performance digital cockpit.
It has been designed as a **mission-driven embedded system**, featuring:

* A **real-time 3D user interface** (instrument cluster).
* A **standards-compliant vehicle communication pipeline** (CAN, SOME/IP).
* A **Driver Monitoring System (DMS)** powered by AI.
* An **embedded Linux packaging** optimized for fast boot and reliability.

The project demonstrates expertise in **embedded software development**, **system integration**, **real-time constraints**, and **safety-oriented design**.

---

## 🎯 Objectives

* Deliver a **fluid 3D HMI** running at 60 fps with real-time data updates
* Ensure **CAN → HMI latency < 25 ms (p95)**
* Integrate a **Driver Monitoring System** with distraction/somnolence detection
* Package the full system on an embedded Linux distribution with **boot-to-HMI < 10 s**
* Provide a **modular and testable architecture**, aligned with industrial guidelines

---

## ✨ Features

### 1. Human-Machine Interface (HMI)
* Built with **Qt 6 / QML / Qt Quick 3D**
* Real-time gauges: speedometer, tachometer, gear indicator
* Status lights: ABS, ESP, blinkers, warnings, seatbelt
* DMS alerts (driver distraction)
* Live theme switching (e.g. “Night”, “Sport Carbon”)

### 2. Vehicle Data Pipeline
* **CAN Bus** via SocketCAN (simulation or USB-CAN)
* **DBC parsing** and optimized runtime parser
* Signal injection with pre-defined driving profiles (city / sport)
* **vSomeIP services**:
    * VehicleStateService (speed, RPM, lights)
    * ClusterFeedService (aggregated stream)
    * DiagService (mock UDS ISO 14229)

### 3. Driver Monitoring System (DMS)
* Based on **OAK-D Lite + DepthAI**
* ROS 2 integration (Cyclone DDS)
* Detects:
    * Head orientation
    * Eye closure / blinking
    * Off-road gaze duration
* Alerts triggered for distraction > 2s
* Mock node available for demo without camera

### 4. Diagnostics & Robustness
* Minimal UDS protocol implementation
* CAN/SOMEIP logging & replay
* Fuzz testing on CAN/SOMEIP messages
* Watchdog & auto-restart with systemd

### 5. Embedded Packaging
* Buildroot / Yocto based image
* Weston compositor on Wayland
* Automatic startup of services via systemd
* Dual modes:

    * **PC Simulation** (vcan + mock DMS)
    * **Target Hardware** (Raspberry Pi 4 / Jetson + OAK-D + CAN dongle)

---

## 🏗️ Architecture
```
          +-------------------------+
          |     HMI (Qt/QML 3D)     |
          |-------------------------|
          | - UI Thread / MVVM      |
          | - Local API Client      |
          +-----------▲-------------+
                      |
                      |
          +-------------------------+
          |     AppCore / Gateway   |
          |-------------------------|
          | - DDS Client / Bridge   |
          | - vSomeIP Client        |
          | - Unified Data Model    |
          +-----------▲-------------+
        ┌-------------┴-------------┐
        |                           |
+----------------+         +----------------+
|    Services    |         | DMS (ROS 2 +   |
| (vSomeIP, C++) |         |  DepthAI)      |
|----------------|         |----------------|
| - VehicleState |         | - oakd_node    |
| - ClusterFeed  |         | - mock_node    |
| - DiagService  |         | - /driver_state|
+-------▲--------+         +--------▲-------+
        |                           |
     SocketCAN                   DDS (intra)
        |                           |
+----------------+                  |
| CAN Bus        |                  |
| (real / virt.) |                  |
+----------------+                  |
                                    |
                           (cameras / sensors)

```

[Mermaid Graoh](https://www.mermaidchart.com/app/projects/d8d8e17e-7a4d-433c-8777-bc265f613503/diagrams/51cc9749-8fda-476c-b4c4-9a2f6f301bb6/version/v0.1/edit)

---

## ⚙️ Tech Stack
* **Languages**: C++20, Python (tools)
* **UI / HMI**: Qt 6 / QML / Qt Quick 3D
* **Vehicle comms**: SocketCAN, vSomeIP
* **Middleware**: ROS 2, Cyclone DDS
* **AI**: DepthAI (OAK-D Lite)
* **OS**: Buildroot / Yocto Linux
* **Quality & CI/CD**:

    * GitHub Actions (build, tests, packaging)
    * clang-tidy, cppcheck, GTest, Valgrind
    * Documentation: Doxygen + UML

---

## 📊 Performance Targets
* **Frame rate**: 60 fps stable.
* **Latency CAN → HMI**: < 25 ms (p95).
* **Boot-to-HMI**: < 10 s.
* **DMS reaction time**: < 200 ms.

---

## 📦 Deliverables
* Full **source code (monorepo)**
* **Embedded image** for Raspberry Pi / Jetson
* **Documentation**:

    * Installation & usage guide
    * Architecture diagrams
    * Safety note (ISO-style)
    * Test plan & results
* **Demo video**

---

## 🛡️ License
Apache-2.0

![CI](https://github.com/avainfo/Aegis-Cockpit/actions/workflows/build.yml/badge.svg)
![License](https://img.shields.io/badge/license-Apache%202.0-blue.svg)
![Platform](https://img.shields.io/badge/platform-Linux%20%7C%20RaspberryPi%20%7C%20Jetson-lightgrey)
