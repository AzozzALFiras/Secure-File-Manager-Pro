//
//  VideoPlayerView.swift
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
import AVKit

struct VideoPlayerView: View {
    let item: FileItem
    @Environment(\.dismiss) var dismiss
    @State private var player: AVPlayer?
    @State private var isPlaying = false
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.black.ignoresSafeArea()
                
                if let videoURL = item.videoURL {
                    VStack {
                        VideoPlayer(player: player)
                            .onAppear {
                                if player == nil {
                                    player = AVPlayer(url: videoURL)
                                }
                            }
                            .onDisappear {
                                player?.pause()
                                player = nil
                            }
                        
                        HStack {
                            Button(action: {
                                if isPlaying {
                                    player?.pause()
                                } else {
                                    player?.play()
                                }
                                isPlaying.toggle()
                            }) {
                                Image(systemName: isPlaying ? "pause.circle.fill" : "play.circle.fill")
                                    .font(.system(size: 30))
                                    .foregroundColor(.white)
                            }
                            
                            Spacer()
                            
                            Text(item.name)
                                .foregroundColor(.white)
                                .font(.headline)
                            
                            Spacer()
                            
                            Button(action: {
                                player?.seek(to: .zero)
                                player?.play()
                                isPlaying = true
                            }) {
                                Image(systemName: "gobackward")
                                    .font(.system(size: 20))
                                    .foregroundColor(.white)
                            }
                        }
                        .padding()
                    }
                } else {
                    VStack {
                        Image(systemName: "video.slash")
                            .font(.system(size: 80))
                            .foregroundColor(.gray)
                        Text("Video not available")
                            .foregroundColor(.white)
                    }
                }
            }
            .navigationTitle(item.name)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Done") {
                        player?.pause()
                        dismiss()
                    }
                    .foregroundColor(.white)
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    if let videoURL = item.videoURL {
                        ShareLink(item: videoURL, preview: SharePreview(item.name)) {
                            Image(systemName: "square.and.arrow.up")
                                .foregroundColor(.white)
                        }
                    }
                }
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    player?.play()
                    isPlaying = true
                }
            }
        }
    }
}