//
//  ChangeFolderPasswordView.swift
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

struct ChangeFolderPasswordView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: FileManagerViewModel
    let item: FileItem
    
    @State private var currentPassword = ""
    @State private var newPassword = ""
    @State private var confirmPassword = ""
    @State private var showError = false
    @State private var errorMessage = ""
    
    var body: some View {
        NavigationView {
            Form {
                if !item.password.isEmpty {
                    Section(header: Text("Current Password")) {
                        SecureField("Current Password", text: $currentPassword)
                    }
                }
                
                Section(header: Text("New Password")) {
                    SecureField("New Password", text: $newPassword)
                    SecureField("Confirm Password", text: $confirmPassword)
                }
                
                if showError {
                    Section {
                        Text(errorMessage)
                            .foregroundColor(.red)
                            .font(.caption)
                    }
                }
                
                Section {
                    Button(item.password.isEmpty ? "Set Password" : "Update Password") {
                        updatePassword()
                    }
                    .disabled(!isValidInput())
                }
            }
            .navigationTitle(item.password.isEmpty ? "Set Password" : "Change Password")
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
    
    private func isValidInput() -> Bool {
        if !item.password.isEmpty && currentPassword.isEmpty {
            return false
        }
        return !newPassword.isEmpty && newPassword == confirmPassword
    }
    
    private func updatePassword() {
        if !item.password.isEmpty && currentPassword != item.password {
            showError = true
            errorMessage = "Current password is incorrect"
            return
        }
        
        if newPassword != confirmPassword {
            showError = true
            errorMessage = "Passwords do not match"
            return
        }
        
        if newPassword.count < 4 {
            showError = true
            errorMessage = "Password must be at least 4 characters"
            return
        }
        
        viewModel.updateItemPassword(item, newPassword: newPassword)
        dismiss()
    }
}