//
//  AddFolderView.swift
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

struct AddFolderView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: FileManagerViewModel
    
    @State private var folderName = ""
    @State private var folderDescription = ""
    @State private var password = ""
    @State private var selectedIcon = "folder.fill"
    
    let icons = ["folder.fill", "photo.on.rectangle", "doc.fill", "hammer.fill", "heart.fill", "star.fill", "bookmark.fill", "briefcase.fill", "book.fill"]
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Folder Details")) {
                    TextField("Folder Name", text: $folderName)
                    TextField("Description", text: $folderDescription)
                }
                
                Section(header: Text("Security (Optional)")) {
                    SecureField("Password", text: $password)
                    Text("Leave empty for no password")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                
                Section(header: Text("Icon")) {
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 50))], spacing: 15) {
                        ForEach(icons, id: \.self) { icon in
                            Image(systemName: icon)
                                .font(.title2)
                                .foregroundColor(selectedIcon == icon ? .blue : .gray)
                                .padding(10)
                                .background(selectedIcon == icon ? Color.blue.opacity(0.1) : Color.clear)
                                .cornerRadius(8)
                                .onTapGesture {
                                    selectedIcon = icon
                                }
                        }
                    }
                    .padding(.vertical, 8)
                }
                
                Section {
                    Button("Create Folder") {
                        viewModel.addFolder(
                            name: folderName,
                            description: folderDescription,
                            password: password,
                            icon: selectedIcon
                        )
                        dismiss()
                    }
                    .disabled(folderName.isEmpty)
                }
            }
            .navigationTitle("New Folder")
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