//
//  FileItem.swift
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

struct FileItem: Identifiable, Codable {
    var id = UUID()
    var name: String
    var description: String
    var icon: String
    var password: String
    var isFolder: Bool
    var children: [FileItem]?
    var creationDate: Date
    var fileURL: URL?
    var imageData: Data?
    var videoURL: URL?
    var fileSize: Int64?
    var downloadStatus: DownloadStatus?
    var isVideo: Bool
    var fileExtension: String?
    
    init(id: UUID = UUID(), name: String, description: String, icon: String, password: String, 
         isFolder: Bool, children: [FileItem]? = nil, creationDate: Date, fileURL: URL? = nil, 
         imageData: Data? = nil, videoURL: URL? = nil, fileSize: Int64? = nil, 
         downloadStatus: DownloadStatus? = nil, isVideo: Bool = false, fileExtension: String? = nil) {
        self.id = id
        self.name = name
        self.description = description
        self.icon = icon
        self.password = password
        self.isFolder = isFolder
        self.children = children
        self.creationDate = creationDate
        self.fileURL = fileURL
        self.imageData = imageData
        self.videoURL = videoURL
        self.fileSize = fileSize
        self.downloadStatus = downloadStatus
        self.isVideo = isVideo
        self.fileExtension = fileExtension
    }
}