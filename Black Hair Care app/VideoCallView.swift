//
//  VideoCallView.swift
//  Black Hair Care app
//
//  Created by Darius Church on 2/28/25.
//

import SwiftUI
import WebRTC
import AVKit // Import AVKit for VideoPlayer

struct VideoCallView: View {
    @StateObject private var webRTCManager = WebRTCManager()
    
    var body: some View {
        VStack {
            Text("Video Call")
                .font(.largeTitle)
                .padding()
            
            if let remoteVideoURL = webRTCManager.remoteVideoURL {
                // Use VideoPlayer from AVKit
                VideoPlayer(player: AVPlayer(url: remoteVideoURL))
                    .frame(height: 300)
            } else {
                Text("Waiting for remote video...")
            }
            
            Button(action: {
                webRTCManager.createOffer()
            }) {
                Text("Start Call")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
        }
        .padding()
    }
}
