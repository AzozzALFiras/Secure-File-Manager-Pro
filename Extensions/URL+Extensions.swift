//
//  URL+Extensions.swift
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

extension URL {
    var fileSize: Int64? {
        do {
            let resources = try resourceValues(forKeys: [.fileSizeKey])
            return Int64(resources.fileSize ?? 0)
        } catch {
            print("Error getting file size: \(error)")
            return nil
        }
    }
    
    var containsVideo: Bool {
        let videoExtensions = ["mp4", "mov", "m4v", "avi", "mkv", "wmv", "flv", "webm"]
        return videoExtensions.contains(self.pathExtension.lowercased())
    }
    
    var containsImage: Bool {
        let imageExtensions = ["jpg", "jpeg", "png", "gif", "bmp", "tiff", "heic"]
        return imageExtensions.contains(self.pathExtension.lowercased())
    }
}