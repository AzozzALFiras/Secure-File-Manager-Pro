//
//  ImportMediaView.swift
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
import PhotosUI

struct ImportMediaView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: FileManagerViewModel
    @State private var selectedItems: [PhotosPickerItem] = []
    @State private var fileName = ""
    @State private var fileDescription = ""
    @State private var isImporting = false
    @State private var importProgress: Double = 0
    @State private var importStatus = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("File Details")) {
                    TextField("File Name (optional)", text: $fileName)
                    TextField("Description", text: $fileDescription)
                }
                
                Section(header: Text("Select Media")) {
                    PhotosPicker(
                        selection: $selectedItems,
                        matching: .any(of: [.images, .videos]),
                        photoLibrary: .shared()
                    ) {
                        Label("Select Photos & Videos", systemImage: "photo.on.rectangle")
                    }
                }
                
                if !selectedItems.isEmpty {
                    Section(header: Text("Selected Items")) {
                        Text("\(selectedItems.count) item(s) selected")
                            .font(.caption)
                        
                        if isImporting {
                            VStack(alignment: .leading) {
                                Text(importStatus)
                                    .font(.caption)
                                ProgressView(value: importProgress, total: Double(selectedItems.count))
                                    .progressViewStyle(LinearProgressViewStyle())
                            }
                        }
                    }
                }
                
                Section {
                    Button("Import Media") {
                        importMedia()
                    }
                    .disabled(selectedItems.isEmpty || isImporting)
                    
                    if isImporting {
                        HStack {
                            Spacer()
                            ProgressView()
                            Spacer()
                        }
                    }
                }
            }
            .navigationTitle("Import Media")
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
    
    private func importMedia() {
        isImporting = true
        importProgress = 0
        let totalItems = selectedItems.count
        
        Task {
            for (index, item) in selectedItems.enumerated() {
                await MainActor.run {
                    importStatus = "Importing item \(index + 1) of \(totalItems)"
                    importProgress = Double(index)
                }
                
                do {
                    if let data = try? await item.loadTransferable(type: Data.self),
                       let _ = UIImage(data: data) {
                        let name = fileName.isEmpty ? "Image_\(index + 1)" : "\(fileName)_\(index + 1)"
                        
                        await MainActor.run {
                            viewModel.addFile(
                                name: name,
                                description: fileDescription,
                                fileURL: nil,
                                icon: "photo.fill",
                                imageData: data,
                                fileSize: Int64(data.count),
                                isVideo: false,
                                fileExtension: "jpg"
                            )
                        }
                    }
                    else if let url = try? await item.loadTransferable(type: URL.self) {
                        let fileExtension = url.pathExtension
                        let isVideo = url.containsVideo
                        
                        let name = fileName.isEmpty ?
                            (isVideo ? "Video_\(index + 1)" : "File_\(index + 1)") :
                            "\(fileName)_\(index + 1)"
                        
                        if isVideo {
                            if let savedURL = viewModel.saveVideoToDocuments(url, fileName: name) {
                                let fileSize = savedURL.fileSize
                                
                                await MainActor.run {
                                    viewModel.addFile(
                                        name: name,
                                        description: fileDescription,
                                        fileURL: nil,
                                        icon: "video.fill",
                                        videoURL: savedURL,
                                        fileSize: fileSize,
                                        isVideo: true,
                                        fileExtension: fileExtension
                                    )
                                }
                            }
                        } else if url.containsImage {
                            if let data = try? Data(contentsOf: url),
                               let _ = UIImage(data: data) {
                                await MainActor.run {
                                    viewModel.addFile(
                                        name: name,
                                        description: fileDescription,
                                        fileURL: nil,
                                        icon: "photo.fill",
                                        imageData: data,
                                        fileSize: Int64(data.count),
                                        isVideo: false,
                                        fileExtension: fileExtension
                                    )
                                }
                            }
                        }
                    }
                } catch {
                    print("Error importing item: \(error)")
                }
                
                try? await Task.sleep(nanoseconds: 100_000_000)
            }
            
            await MainActor.run {
                isImporting = false
                importStatus = ""
                importProgress = 0
                selectedItems.removeAll()
                dismiss()
            }
        }
    }
}