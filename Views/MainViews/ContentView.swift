//
//  ContentView.swift
//  File Manager Pro
//
//  Created by Azozz ALFiras on 11/11/2025.
//  Copyright © 2025 Azozz ALFiras. All rights reserved.
//
//  Secure File Manager Pro - Your Privacy is Our Priority
//  GitHub: https://github.com/azozzalfiras
//  Website: https://dev.3zozz.com
//


import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = FileManagerViewModel()
    @StateObject private var appSettings = AppSettings()
    @StateObject private var lifecycleManager = AppLifecycleManager()
    @Environment(\.scenePhase) var scenePhase
    
    @State private var showingAddFolder = false
    @State private var showingImportMedia = false
    @State private var showingDownloadURL = false
    @State private var showingDownloadsLibrary = false
    @State private var showingSettings = false
    @State private var showingPasswordView = false
    @State private var lockedFolder: FileItem?
    @State private var selectedItem: FileItem?
    @State private var itemToShare: FileItem?
    @State private var passwordChangeItem: FileItem?
    
    var body: some View {
        Group {
            if appSettings.hasSetPassword && !appSettings.isUnlocked {
                AppLockScreen(appSettings: appSettings)
                    .preferredColorScheme(getPreferredColorScheme())
            } else {
                mainView
                    .preferredColorScheme(getPreferredColorScheme())
            }
        }
        .onChange(of: scenePhase) { oldPhase, newPhase in
            lifecycleManager.scenePhase = newPhase
            
            if appSettings.hasSetPassword && (newPhase == .background || newPhase == .inactive) {
                appSettings.lockApp()
            }
        }
    }
    
    private var mainView: some View {
        NavigationView {
            VStack {
                if !viewModel.path.isEmpty {
                    BreadcrumbView(viewModel: viewModel)
                }
                
                if viewModel.getCurrentItems().isEmpty {
                    EmptyStateView()
                } else {
                    FileListView(
                        viewModel: viewModel,
                        onItemTap: handleItemTap,
                        onPasswordChange: { passwordChangeItem = $0 },
                        onShare: { itemToShare = $0 }
                    )
                }
            }
            .navigationTitle(viewModel.currentFolder?.name ?? "File Manager")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItems(
                    showingSettings: $showingSettings,
                    showingDownloadsLibrary: $showingDownloadsLibrary,
                    showingDownloadURL: $showingDownloadURL,
                    showingImportMedia: $showingImportMedia,
                    showingAddFolder: $showingAddFolder
                )
            }
        }
        .sheet(isPresented: $showingSettings) {
            SettingsView(appSettings: appSettings)
        }
        .sheet(isPresented: $showingAddFolder) {
            AddFolderView(viewModel: viewModel)
        }
        .sheet(isPresented: $showingImportMedia) {
            ImportMediaView(viewModel: viewModel)
        }
        .sheet(isPresented: $showingDownloadURL) {
            DownloadFromURLView(viewModel: viewModel)
        }
        .sheet(isPresented: $showingDownloadsLibrary) {
            DownloadsLibraryView(viewModel: viewModel)
        }
        .sheet(item: $selectedItem) { item in
            if item.isVideo {
                VideoPlayerView(item: item)
            } else {
                ImageViewerView(item: item)
            }
        }
        .sheet(item: $passwordChangeItem) { item in
            ChangeFolderPasswordView(viewModel: viewModel, item: item)
        }
        .sheet(item: $itemToShare) { item in
            if let imageData = item.imageData {
                ShareSheet(items: [imageData])
            } else if let videoURL = item.videoURL {
                ShareSheet(items: [videoURL])
            } else if let url = item.fileURL {
                ShareSheet(items: [url])
            }
        }
        .overlay(
            Group {
                if showingPasswordView, let folder = lockedFolder {
                    Color.black.opacity(0.3)
                        .edgesIgnoringSafeArea(.all)
                    PasswordView(
                        isPresented: $showingPasswordView,
                        folder: folder
                    ) {
                        viewModel.navigateToFolder(folder)
                    }
                }
            }
        )
        .onAppear {
            if !appSettings.hasSetPassword {
                appSettings.isUnlocked = true
            }
        }
    }
    
    private func handleItemTap(_ item: FileItem) {
        if item.isFolder {
            if item.password.isEmpty {
                viewModel.navigateToFolder(item)
            } else {
                lockedFolder = item
                showingPasswordView = true
            }
        } else {
            selectedItem = item
        }
    }
    
    private func getPreferredColorScheme() -> ColorScheme? {
        if appSettings.useSystemAppearance {
            return nil
        } else {
            return appSettings.isDarkMode ? .dark : .light
        }
    }
}