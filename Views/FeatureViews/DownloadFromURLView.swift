//
//  DownloadFromURLView.swift
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

struct DownloadFromURLView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: FileManagerViewModel
    
    @State private var urlString = ""
    @State private var fileName = ""
    @State private var fileDescription = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("URL")) {
                    TextField("Enter URL", text: $urlString)
                        .keyboardType(.URL)
                        .autocapitalization(.none)
                }
                
                Section(header: Text("File Details")) {
                    TextField("File Name", text: $fileName)
                    TextField("Description", text: $fileDescription)
                }
                
                Section {
                    Button("Start Download") {
                        viewModel.downloadFile(
                            from: urlString,
                            name: fileName.isEmpty ? "Downloaded File" : fileName,
                            description: fileDescription
                        )
                        dismiss()
                    }
                    .disabled(urlString.isEmpty)
                }
            }
            .navigationTitle("Download from URL")
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
}