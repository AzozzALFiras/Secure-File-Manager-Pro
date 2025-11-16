//
//  BreadcrumbView.swift
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

struct BreadcrumbView: View {
    @ObservedObject var viewModel: FileManagerViewModel
    
    var body: some View {
        HStack {
            Button(action: {
                viewModel.navigateUp()
            }) {
                HStack {
                    Image(systemName: "arrow.left")
                    Text("Back")
                }
            }
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(viewModel.path) { folder in
                        Text(folder.name)
                            .font(.caption)
                        if folder.id != viewModel.path.last?.id {
                            Image(systemName: "chevron.right")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                    }
                }
            }
            
            Spacer()
        }
        .padding(.horizontal)
    }
}