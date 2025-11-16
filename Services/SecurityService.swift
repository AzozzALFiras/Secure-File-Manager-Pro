//
//  SecurityService.swift
//  File Manager Pro
//
//  Created by Azozz ALFiras on 11/11/2025.
//  Copyright © 2025 Azozz ALFiras. All rights reserved.
//
//  Secure File Manager Pro - Your Privacy is Our Priority
//  GitHub: https://github.com/azozzalfiras
//  Website: https://dev.3zozz.com
//

import Foundation

class SecurityService {
    func encryptPassword(_ password: String) -> Data? {
        return password.data(using: .utf8)
    }
    
    func decryptPassword(_ data: Data) -> String? {
        return String(data: data, encoding: .utf8)
    }
}