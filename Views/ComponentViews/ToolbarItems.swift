//
//  ToolbarItems.swift
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

struct ToolbarItems: View {
    @Binding var showingSettings: Bool
    @Binding var showingDownloadsLibrary: Bool
    @Binding var showingDownloadURL: Bool
    @Binding var showingImportMedia: Bool
    @Binding var showingAddFolder: Bool
    
    var body: some View {
        Group {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: { showingSettings = true }) {
                    Image(systemName: "gear")
                }
            }
            
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                Button(action: { showingDownloadsLibrary = true }) {
                    Image(systemName: "arrow.down.circle")
                }
                
                Button(action: { showingDownloadURL = true }) {
                    Image(systemName: "link.badge.plus")
                }
                
                Menu {
                    Button(action: { showingImportMedia = true }) {
                        Label("Import Media", systemImage: "photo.on.rectangle")
                    }
                    
                    Button(action: { showingAddFolder = true }) {
                        Label("New Folder", systemImage: "folder.badge.plus")
                    }
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
    }
}