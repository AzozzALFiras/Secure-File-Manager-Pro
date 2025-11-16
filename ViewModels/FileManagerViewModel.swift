//
//  FileManagerViewModel.swift
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
import Combine

class FileManagerViewModel: ObservableObject {
    @Published var fileItems: [FileItem] = []
    @Published var currentFolder: FileItem?
    @Published var path: [FileItem] = []
    @Published var downloadProgress: [UUID: Double] = [:]
    
    private let fileManagerService: FileManagerService
    
    init(fileManagerService: FileManagerService = FileManagerService()) {
        self.fileManagerService = fileManagerService
        loadInitialData()
    }
    
    private func loadInitialData() {
        let downloadsFolder = FileItem(
            name: "Downloads",
            description: "Downloaded files",
            icon: "arrow.down.circle.fill",
            password: "",
            isFolder: true,
            children: [],
            creationDate: Date()
        )
        
        fileItems = [downloadsFolder]
    }
    
    // MARK: - Navigation
    func navigateToFolder(_ folder: FileItem) {
        currentFolder = folder
        path.append(folder)
    }
    
    func navigateUp() {
        if !path.isEmpty {
            path.removeLast()
            currentFolder = path.last
        } else {
            currentFolder = nil
        }
    }
    
    // MARK: - CRUD Operations
    func addFolder(name: String, description: String, password: String, icon: String) {
        let newFolder = FileItem(
            name: name,
            description: description,
            icon: icon,
            password: password,
            isFolder: true,
            children: [],
            creationDate: Date()
        )
        
        if let current = currentFolder {
            updateItemInHierarchy(current.id) { item in
                var updated = item
                updated.children?.append(newFolder)
                return updated
            }
        } else {
            fileItems.append(newFolder)
        }
    }
    
    func addFile(name: String, description: String, fileURL: URL?, icon: String, 
                imageData: Data? = nil, videoURL: URL? = nil, fileSize: Int64? = nil, 
                isVideo: Bool = false, fileExtension: String? = nil) {
        let newFile = FileItem(
            name: name,
            description: description,
            icon: icon,
            password: "",
            isFolder: false,
            children: nil,
            creationDate: Date(),
            fileURL: fileURL,
            imageData: imageData,
            videoURL: videoURL,
            fileSize: fileSize,
            isVideo: isVideo,
            fileExtension: fileExtension
        )
        
        if let current = currentFolder {
            updateItemInHierarchy(current.id) { item in
                var updated = item
                updated.children?.append(newFile)
                return updated
            }
        } else {
            fileItems.append(newFile)
        }
    }
    
    func deleteItem(_ item: FileItem) {
        if let videoURL = item.videoURL {
            try? FileManager.default.removeItem(at: videoURL)
        }
        
        if let current = currentFolder {
            updateItemInHierarchy(current.id) { folder in
                var updated = folder
                updated.children?.removeAll { $0.id == item.id }
                return updated
            }
        } else {
            fileItems.removeAll { $0.id == item.id }
        }
    }
    
    func updateItemPassword(_ item: FileItem, newPassword: String) {
        updateItemInHierarchy(item.id) { oldItem in
            var updated = oldItem
            updated.password = newPassword
            return updated
        }
    }
    
    // MARK: - Download Management
    func downloadFile(from urlString: String, name: String, description: String) {
        guard let url = URL(string: urlString) else { return }
        
        let downloadItem = FileItem(
            name: name,
            description: description,
            icon: "arrow.down.doc.fill",
            password: "",
            isFolder: false,
            children: nil,
            creationDate: Date(),
            fileURL: nil,
            downloadStatus: .downloading
        )
        
        if let downloadsFolder = fileItems.first(where: { $0.name == "Downloads" }) {
            updateItemInHierarchy(downloadsFolder.id) { folder in
                var updated = folder
                updated.children?.append(downloadItem)
                return updated
            }
        }
        
        downloadProgress[downloadItem.id] = 0.0
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            DispatchQueue.main.async {
                if let data = data {
                    self?.updateItemInHierarchy(downloadItem.id) { item in
                        var updated = item
                        updated.downloadStatus = .completed
                        updated.imageData = data
                        updated.fileSize = Int64(data.count)
                        return updated
                    }
                    self?.downloadProgress[downloadItem.id] = 1.0
                } else {
                    self?.updateItemInHierarchy(downloadItem.id) { item in
                        var updated = item
                        updated.downloadStatus = .failed
                        return updated
                    }
                }
            }
        }
        task.resume()
    }
    
    // MARK: - File Management
    func saveVideoToDocuments(_ sourceURL: URL, fileName: String) -> URL? {
        return fileManagerService.saveVideoToDocuments(sourceURL, fileName: fileName)
    }
    
    func saveImageToDocuments(_ imageData: Data, fileName: String) -> URL? {
        return fileManagerService.saveImageToDocuments(imageData, fileName: fileName)
    }
    
    // MARK: - Helper Methods
    private func updateItemInHierarchy(_ id: UUID, update: (FileItem) -> FileItem) {
        func updateRecursive(_ items: [FileItem]) -> [FileItem] {
            items.map { item in
                if item.id == id {
                    return update(item)
                } else if let children = item.children {
                    var updated = item
                    updated.children = updateRecursive(children)
                    return updated
                }
                return item
            }
        }
        fileItems = updateRecursive(fileItems)
        
        if let currentIndex = path.firstIndex(where: { $0.id == id }) {
            path[currentIndex] = update(path[currentIndex])
            currentFolder = path.last
        }
    }
    
    func getCurrentItems() -> [FileItem] {
        if let current = currentFolder {
            return current.children ?? []
        }
        return fileItems
    }
    
    func getDownloadingItems() -> [FileItem] {
        func collectDownloading(_ items: [FileItem]) -> [FileItem] {
            var result: [FileItem] = []
            for item in items {
                if item.downloadStatus == .downloading {
                    result.append(item)
                }
                if let children = item.children {
                    result.append(contentsOf: collectDownloading(children))
                }
            }
            return result
        }
        return collectDownloading(fileItems)
    }
    
    func getCompletedDownloads() -> [FileItem] {
        func collectCompleted(_ items: [FileItem]) -> [FileItem] {
            var result: [FileItem] = []
            for item in items {
                if item.downloadStatus == .completed {
                    result.append(item)
                }
                if let children = item.children {
                    result.append(contentsOf: collectCompleted(children))
                }
            }
            return result
        }
        return collectCompleted(fileItems)
    }
}