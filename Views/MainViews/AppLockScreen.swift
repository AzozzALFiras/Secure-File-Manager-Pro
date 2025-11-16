//
//  AppLockScreen.swift
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

struct AppLockScreen: View {
    @ObservedObject var appSettings: AppSettings
    
    @State private var passwordInput = ""
    @State private var showError = false
    @State private var shakeOffset: CGFloat = 0
    
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [Color.blue.opacity(0.6), Color.purple.opacity(0.6)]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            VStack(spacing: 30) {
                Spacer()
                
                Image(systemName: "lock.shield.fill")
                    .font(.system(size: 80))
                    .foregroundColor(.white)
                
                Text("File Manager")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                
                Text("Enter password to unlock")
                    .font(.headline)
                    .foregroundColor(.white.opacity(0.8))
                
                Spacer()
                
                VStack(spacing: 20) {
                    SecureField("Password", text: $passwordInput)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal, 40)
                        .offset(x: shakeOffset)
                    
                    if showError {
                        Text("Incorrect password")
                            .foregroundColor(.red)
                            .font(.subheadline)
                    }
                    
                    Button(action: attemptUnlock) {
                        Text("Unlock")
                            .fontWeight(.semibold)
                            .foregroundColor(.blue)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(10)
                    }
                    .padding(.horizontal, 40)
                    .disabled(passwordInput.isEmpty)
                }
                
                Spacer()
            }
        }
        .onSubmit {
            attemptUnlock()
        }
    }
    
    private func attemptUnlock() {
        if appSettings.verifyPassword(passwordInput) {
            appSettings.isUnlocked = true
        } else {
            showError = true
            passwordInput = ""
            withAnimation(.spring(response: 0.2, dampingFraction: 0.3)) {
                shakeOffset = 10
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                withAnimation(.spring(response: 0.2, dampingFraction: 0.3)) {
                    shakeOffset = -10
                }
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                withAnimation(.spring(response: 0.2, dampingFraction: 0.3)) {
                    shakeOffset = 0
                }
            }
        }
    }
}