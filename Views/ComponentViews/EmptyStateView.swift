//
//  EmptyStateView.swift
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

struct EmptyStateView: View {
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "folder")
                .font(.system(size: 80))
                .foregroundColor(.gray)
            Text("No files or folders")
                .font(.title2)
                .foregroundColor(.secondary)
            Text("Tap the + button to add content")
                .font(.body)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}