//
//  AppSettings.swift
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

class AppSettings: ObservableObject {
    @AppStorage("appPassword") private var storedPassword: String = ""
    @AppStorage("hasSetPassword") var hasSetPassword: Bool = false
    @AppStorage("isDarkMode") var isDarkMode: Bool = false
    @AppStorage("useSystemAppearance") var useSystemAppearance: Bool = true
    @Published var isUnlocked = false
    
    func setPassword(_ password: String) {
        storedPassword = password
        hasSetPassword = !password.isEmpty
    }
    
    func verifyPassword(_ password: String) -> Bool {
        return storedPassword == password
    }
    
    func changePassword(currentPassword: String, newPassword: String) -> Bool {
        if verifyPassword(currentPassword) {
            setPassword(newPassword)
            return true
        }
        return false
    }
    
    func removePassword(currentPassword: String) -> Bool {
        if verifyPassword(currentPassword) {
            storedPassword = ""
            hasSetPassword = false
            return true
        }
        return false
    }
    
    func lockApp() {
        isUnlocked = false
    }
}