//
//  AppLifecycleManager.swift
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

class AppLifecycleManager: ObservableObject {
    @Published var scenePhase: ScenePhase = .active
    
    func shouldLock(hasPassword: Bool) -> Bool {
        return hasPassword && scenePhase != .active
    }
}