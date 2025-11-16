//
//  RemovePasswordView.swift
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

struct RemovePasswordView: View {
    @ObservedObject var appSettings: AppSettings
    @Environment(\.dismiss) var dismiss
    
    @State private var currentPassword = ""
    @State private var showError = false
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Confirm Password")) {
                    SecureField("Current Password", text: $currentPassword)
                }
                
                Section {
                    Text("Warning: Removing the password will allow anyone to access your files without authentication.")
                        .font(.caption)
                        .foregroundColor(.orange)
                }
                
                if showError {
                    Section {
                        Text("Incorrect password")
                            .foregroundColor(.red)
                            .font(.caption)
                    }
                }
                
                Section {
                    Button("Remove Password") {
                        removePassword()
                    }
                    .foregroundColor(.red)
                    .disabled(currentPassword.isEmpty)
                }
            }
            .navigationTitle("Remove Password")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
        }
    }
    
    private func removePassword() {
        if appSettings.removePassword(currentPassword: currentPassword) {
            dismiss()
        } else {
            showError = true
        }
    }
}