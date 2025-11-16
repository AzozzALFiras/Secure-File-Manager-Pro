//
//  FileManagerService.swift
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

class FileManagerService {
    private let documentsDirectory: URL
    
    init() {
        self.documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
    
    func saveVideoToDocuments(_ sourceURL: URL, fileName: String) -> URL? {
        let fileExtension = sourceURL.pathExtension
        let destinationURL = documentsDirectory.appendingPathComponent("\(fileName).\(fileExtension)")
        
        do {
            if FileManager.default.fileExists(atPath: destinationURL.path) {
                try FileManager.default.removeItem(at: destinationURL)
            }
            try FileManager.default.copyItem(at: sourceURL, to: destinationURL)
            return destinationURL
        } catch {
            print("Error saving video: \(error)")
            return nil
        }
    }
    
    func saveImageToDocuments(_ imageData: Data, fileName: String) -> URL? {
        let destinationURL = documentsDirectory.appendingPathComponent("\(fileName).jpg")
        
        do {
            if FileManager.default.fileExists(atPath: destinationURL.path) {
                try FileManager.default.removeItem(at: destinationURL)
            }
            try imageData.write(to: destinationURL)
            return destinationURL
        } catch {
            print("Error saving image: \(error)")
            return nil
        }
    }
    
    func deleteFile(at url: URL) throws {
        try FileManager.default.removeItem(at: url)
    }
}