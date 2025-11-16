//
//  FileListView.swift
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

struct FileListView: View {
    @ObservedObject var viewModel: FileManagerViewModel
    let onItemTap: (FileItem) -> Void
    let onPasswordChange: (FileItem) -> Void
    let onShare: (FileItem) -> Void
    
    var body: some View {
        List {
            ForEach(viewModel.getCurrentItems()) { item in
                FileItemView(
                    item: item,
                    onTap: { onItemTap(item) },
                    onDelete: { viewModel.deleteItem(item) },
                    onChangePassword: { onPasswordChange(item) },
                    onRemovePassword: { viewModel.updateItemPassword(item, newPassword: "") },
                    onShare: { onShare(item) }
                )
            }
        }
        .listStyle(PlainListStyle())
    }
}