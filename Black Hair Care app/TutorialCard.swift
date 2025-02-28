////
////  TutorialCard.swift
////  Black Hair Care app
////
////  Created by Darius Church on 2/27/25.
////
//
//import SwiftUI
//import AVKit
//
//struct TutorialCard: View {
//    var videoURL: URL
//    @State private var isLiked: Bool = false
//    
//    var body: some View {
//        VStack(alignment: .leading, spacing: 8) {
//            VideoPlayer(player: AVPlayer(url: videoURL))
//                .frame(width: 160, height: 120)
//                .cornerRadius(12)
//            
//            HStack {
//                Text("Protective Styles")
//                    .font(.system(size: 14, weight: .medium))
//                    .foregroundColor(.white)
//                    .padding(8)
//                    .background(Color.black.opacity(0.5))
//                    .cornerRadius(8)
//                
//                Spacer()
//                
//                Button(action: {
//                    isLiked.toggle()
//                    print(isLiked ? "Liked" : "Unliked")
//                }) {
//                    Image(systemName: isLiked ? "heart.fill" : "heart")
//                        .foregroundColor(isLiked ? .red : .gray)
//                        .font(.system(size: 20))
//                }
//            }
//            .padding(8)
//        }
//        .background(Color(.systemBackground))
//        .cornerRadius(12)
//        .shadow(radius: 4)
//    }
//}
//
//struct TutorialCard_Previews: PreviewProvider {
//    static var previews: some View {
//        TutorialCard(videoURL: URL(string: "https://www.sample-videos.com/video123/mp4/720/big_buck_bunny_720p_1mb.mp4")!)
//            .previewLayout(.sizeThatFits)
//            .padding()
//    }
//}
