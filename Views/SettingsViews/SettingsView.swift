//
//  SettingsView.swift
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

struct SettingsView: View {
    @ObservedObject var appSettings: AppSettings
    @Environment(\.dismiss) var dismiss
    @Environment(\.colorScheme) private var systemColorScheme
    
    @State private var showingPasswordSetup = false
    @State private var showingPasswordChange = false
    @State private var showingPasswordRemove = false
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Appearance")) {
                    Toggle("Use System Appearance", isOn: $appSettings.useSystemAppearance)
                    
                    if !appSettings.useSystemAppearance {
                        Toggle("Dark Mode", isOn: $appSettings.isDarkMode)
                    }
                }
                
                Section(header: Text("Security")) {
                    if appSettings.hasSetPassword {
                        Button(action: { showingPasswordChange = true }) {
                            HStack {
                                Image(systemName: "lock.rotation")
                                    .foregroundColor(.blue)
                                Text("Change App Password")
                            }
                        }
                        
                        Button(action: { showingPasswordRemove = true }) {
                            HStack {
                                Image(systemName: "lock.open")
                                    .foregroundColor(.red)
                                Text("Remove App Password")
                            }
                        }
                    } else {
                        Button(action: { showingPasswordSetup = true }) {
                            HStack {
                                Image(systemName: "lock.fill")
                                    .foregroundColor(.green)
                                Text("Set App Password")
                            }
                        }
                    }
                }
                
                Section(header: Text("About")) {
                    HStack {
                        Text("Version")
                        Spacer()
                        Text("1.0.0")
                            .foregroundColor(.secondary)
                    }
                    
                    HStack {
                        Text("Security Status")
                        Spacer()
                        HStack {
                            Image(systemName: appSettings.hasSetPassword ? "lock.fill" : "lock.open.fill")
                            Text(appSettings.hasSetPassword ? "Protected" : "Unprotected")
                        }
                        .foregroundColor(appSettings.hasSetPassword ? .green : .orange)
                        .font(.caption)
                    }
                }
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
            .sheet(isPresented: $showingPasswordSetup) {
                SetupPasswordView(appSettings: appSettings)
            }
            .sheet(isPresented: $showingPasswordChange) {
                ChangeAppPasswordView(appSettings: appSettings)
            }
            .sheet(isPresented: $showingPasswordRemove) {
                RemovePasswordView(appSettings: appSettings)
            }
        }
        .preferredColorScheme(getPreferredColorScheme())
    }
    
    private func getPreferredColorScheme() -> ColorScheme? {
        if appSettings.useSystemAppearance {
            return nil
        } else {
            return appSettings.isDarkMode ? .dark : .light
        }
    }
}