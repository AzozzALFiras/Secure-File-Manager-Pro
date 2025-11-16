//
//  FileItemView.swift
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

struct FileItemView: View {
    let item: FileItem
    let onTap: () -> Void
    let onDelete: () -> Void
    let onChangePassword: () -> Void
    let onRemovePassword: () -> Void
    let onShare: () -> Void
    
    @State private var showingDeleteAlert = false
    
    var body: some View {
        HStack(spacing: 15) {
            fileIcon
            
            fileDetails
            
            Spacer()
            
            if item.isFolder {
                Image(systemName: "chevron.right")
                    .foregroundColor(.gray)
            }
        }
        .padding(.vertical, 8)
        .contentShape(Rectangle())
        .onTapGesture {
            onTap()
        }
        .contextMenu {
            contextMenuItems
        }
        .alert("Delete \(item.isFolder ? "Folder" : "File")", isPresented: $showingDeleteAlert) {
            Button("Cancel", role: .cancel) { }
            Button("Delete", role: .destructive) {
                onDelete()
            }
        } message: {
            Text(item.isFolder ?
                 "Are you sure you want to delete '\(item.name)' and all its contents?" :
                 "Are you sure you want to delete '\(item.name)'?")
        }
    }
    
    private var fileIcon: some View {
        Group {
            if let imageData = item.imageData, let uiImage = UIImage(data: imageData) {
                Image(uiImage: uiImage)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 50, height: 50)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
            } else if item.isVideo {
                ZStack {
                    Rectangle()
                        .fill(Color.blue.opacity(0.3))
                        .frame(width: 50, height: 50)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                    
                    Image(systemName: "play.circle.fill")
                        .font(.title2)
                        .foregroundColor(.white)
                }
            } else {
                Image(systemName: item.icon)
                    .font(.title2)
                    .foregroundColor(item.isFolder ? .blue : .gray)
                    .frame(width: 50)
            }
        }
    }
    
    private var fileDetails: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(item.name)
                .font(.headline)
                .foregroundColor(.primary)
            
            Text(item.description)
                .font(.caption)
                .foregroundColor(.secondary)
                .lineLimit(2)
            
            fileStatusTags
            
            HStack {
                Text("Created: \(item.creationDate, style: .date)")
                    .font(.caption2)
                    .foregroundColor(.secondary)
                
                if let fileSize = item.fileSize {
                    Text("• \(ByteCountFormatter.string(fromByteCount: fileSize, countStyle: .file))")
                        .font(.caption2)
                        .foregroundColor(.secondary)
                }
            }
        }
    }
    
    private var fileStatusTags: some View {
        HStack(spacing: 8) {
            if !item.password.isEmpty {
                HStack {
                    Image(systemName: "lock.fill")
                        .font(.system(size: 10))
                    Text("Protected")
                        .font(.caption2)
                }
                .foregroundColor(.orange)
            }
            
            if let status = item.downloadStatus {
                HStack {
                    Image(systemName: status == .downloading ? "arrow.down.circle" : status == .completed ? "checkmark.circle.fill" : "xmark.circle.fill")
                        .font(.system(size: 10))
                    Text(status.rawValue.capitalized)
                        .font(.caption2)
                }
                .foregroundColor(status == .downloading ? .blue : status == .completed ? .green : .red)
            }
            
            if item.isVideo {
                HStack {
                    Image(systemName: "video.fill")
                        .font(.system(size: 10))
                    Text(item.fileExtension?.uppercased() ?? "VID")
                        .font(.caption2)
                }
                .foregroundColor(.purple)
            }
        }
    }
    
    private var contextMenuItems: some View {
        Group {
            if item.imageData != nil || item.videoURL != nil || item.fileURL != nil {
                Button(action: onShare) {
                    Label("Share", systemImage: "square.and.arrow.up")
                }
            }
            
            if item.isFolder {
                Button(action: onChangePassword) {
                    Label(item.password.isEmpty ? "Set Password" : "Change Password", systemImage: "lock.rotation")
                }
                
                if !item.password.isEmpty {
                    Button(action: onRemovePassword) {
                        Label("Remove Password", systemImage: "lock.open")
                    }
                }
            }
            
            Button(role: .destructive, action: {
                showingDeleteAlert = true
            }) {
                Label("Delete", systemImage: "trash")
            }
        }
    }
}