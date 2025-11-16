# Secure File Manager Pro

🔒 **Secure File Manager Pro**

![Swift](https://img.shields.io/badge/Swift-5.9-orange.svg)
![iOS](https://img.shields.io/badge/iOS-17.0+-blue.svg)
![Platform](https://img.shields.io/badge/Platform-iOS-lightgrey.svg)
![License](https://img.shields.io/badge/License-MIT-green.svg)
![Privacy](https://img.shields.io/badge/Privacy-100%2525-brightgreen.svg)

A powerful, privacy-focused file management application for iOS with
military-grade security features and intuitive organization tools. Keep
your files secure and accessible only to you.

------------------------------------------------------------------------

## 📖 Table of Contents

-   Features
-   Screenshots
-   Technical Architecture
-   Installation
-   Usage Guide
-   Development
-   App Store Submission
-   License
-   Contributing
-   Support
-   Acknowledgments
-   Version History

------------------------------------------------------------------------

## ✨ Features

### 🔐 Advanced Security

-   App-Level Password Protection
-   Folder-Specific Encryption
-   Military-Grade Security
-   Auto-Lock When Inactive
-   Zero Data Collection

### 📁 Smart File Management

-   Hierarchical folders
-   Import photos/videos (JPG, PNG, HEIC, MP4, MOV, etc.)
-   Built‑in download manager
-   File sharing
-   Detailed metadata

### 🎨 Premium User Experience

-   Dark/Light Mode
-   Modern SwiftUI Interface
-   Breadcrumb Navigation
-   Context Menus
-   Custom Icons

### 🚀 Technical Excellence

-   MVVM Architecture
-   Offline‑first
-   Privacy‑focused
-   SwiftUI + Combine

------------------------------------------------------------------------

## 📸 Screenshots

*(Add screenshots here once available)*

------------------------------------------------------------------------

## 🏗 Technical Architecture

### Project Structure

    Secure-File-Manager-Pro/
    ├── Models/
    │   ├── FileItem.swift
    │   ├── AppSettings.swift
    │   └── Enums/
    │       └── DownloadStatus.swift
    ├── Views/
    │   ├── MainViews/
    │   │   ├── ContentView.swift
    │   │   ├── AppLockScreen.swift
    │   │   └── EmptyStateView.swift
    │   ├── ComponentViews/
    │   │   ├── FileItemView.swift
    │   │   ├── BreadcrumbView.swift
    │   │   ├── ToolbarItems.swift
    │   │   └── PasswordView.swift
    │   ├── SettingsViews/
    │   │   ├── SettingsView.swift
    │   │   ├── SetupPasswordView.swift
    │   │   ├── ChangeAppPasswordView.swift
    │   │   └── RemovePasswordView.swift
    │   ├── MediaViews/
    │   │   ├── ImageViewerView.swift
    │   │   └── VideoPlayerView.swift
    │   └── FeatureViews/
    │       ├── AddFolderView.swift
    │       ├── ImportMediaView.swift
    │       ├── DownloadFromURLView.swift
    │       ├── DownloadsLibraryView.swift
    │       └── ChangeFolderPasswordView.swift
    ├── ViewModels/
    │   ├── FileManagerViewModel.swift
    │   └── AppLifecycleManager.swift
    ├── Services/
    │   ├── FileManagerService.swift
    │   └── SecurityService.swift
    ├── Extensions/
    │   └── URL+Extensions.swift
    ├── Utilities/
    │   ├── Constants.swift
    │   └── ShareSheet.swift
    └── FileManagerApp.swift

------------------------------------------------------------------------

## 🚀 Installation

### Requirements

-   iOS 17.0+
-   Xcode 15+
-   Swift 5.9+
-   iPhone or iPad

### Quick Start

``` bash
git clone https://github.com/azozzalfiras/secure-file-manager-pro.git
cd secure-file-manager-pro
open FileManagerApp.xcodeproj
```

Enable signing → Run the project with `Cmd + R`.

------------------------------------------------------------------------

## 📱 Usage Guide

### First Launch

-   Set an optional master password
-   Create folders
-   Import photos/videos
-   Download files via URL

### Core Features

-   App & Folder Passwords
-   Auto‑Lock
-   File organizing tools
-   Media viewer
-   Full offline support

------------------------------------------------------------------------

## 🔧 Development

### Code Style

-   SwiftLint
-   MVVM Architecture
-   Documented code
-   Unit tests

------------------------------------------------------------------------

## 📋 App Store Submission

Checklist: - Test on iOS 17 devices
- Validate privacy
- Prepare screenshots
- Set age rating

Privacy: - No tracking
- No analytics
- No cloud sync
- Local-only storage

------------------------------------------------------------------------

## 📄 License

```
MIT License
Copyright (c) 2025 Azozz ALFiras
(Full license text included in original prompt)
```
------------------------------------------------------------------------

## 🤝 Contributing

``` bash
git checkout -b feature/amazing-feature
git commit -m "Add amazing feature"
git push origin feature/amazing-feature
```

------------------------------------------------------------------------

## 🔄 Version History

### v1.0.0

-   Initial release
-   Advanced security
-   Media management
-   SwiftUI interface

Planned: - iCloud sync
- Sorting & filtering
- Themes
- Compression tools
- Search

------------------------------------------------------------------------

## ⭐ Show Your Support

If this project helps you, please star the repo!\
Built with ❤️ by **Azozz ALFiras**
