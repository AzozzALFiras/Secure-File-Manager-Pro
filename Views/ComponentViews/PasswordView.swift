//
//  PasswordView.swift
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

struct PasswordView: View {
    @Binding var isPresented: Bool
    var folder: FileItem
    var onSuccess: () -> Void
    
    @State private var passwordInput = ""
    @State private var showError = false
    
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: folder.icon)
                .font(.system(size: 50))
                .foregroundColor(.blue)
            
            Text("Enter password for '\(folder.name)'")
                .font(.headline)
            
            SecureField("Password", text: $passwordInput)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
            
            if showError {
                Text("Incorrect password")
                    .foregroundColor(.red)
            }
            
            HStack(spacing: 20) {
                Button("Cancel") {
                    isPresented = false
                }
                .foregroundColor(.red)
                
                Button("Unlock") {
                    if passwordInput == folder.password {
                        onSuccess()
                        isPresented = false
                    } else {
                        showError = true
                    }
                }
                .foregroundColor(.blue)
                .disabled(passwordInput.isEmpty)
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(15)
        .shadow(radius: 10)
        .padding(40)
    }
}