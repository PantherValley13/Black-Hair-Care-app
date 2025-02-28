////
////  CommunityPostCard.swift
////  Black Hair Care app
////
////  Created by Darius Church on 2/27/25.
////
//
//import SwiftUI
//
//struct CommunityPostCard: View {
//    @State private var isLiked: Bool = false
//    
//    var body: some View {
//        VStack(alignment: .leading, spacing: 8) {
//            HStack {
//                Image("image-5") // Use "image-5.png"
//                    .resizable()
//                    .scaledToFill()
//                    .frame(width: 40, height: 40)
//                    .clipShape(Circle())
//                
//                Text("Jessica")
//                    .font(.system(size: 16, weight: .medium))
//                
//                Spacer()
//                
//                Text("2h ago")
//                    .font(.system(size: 14))
//                    .foregroundColor(.gray)
//            }
//            
//            Text("Check out my new twist-out! Loving these products from the app.")
//                .font(.system(size: 14))
//                .lineSpacing(4) // Improved line spacing
//            
//            Image("image-4") // Keep "image-4"
//                .resizable()
//                .scaledToFill()
//                .frame(height: 160)
//                .cornerRadius(12)
//            
//            HStack {
//                Button(action: {
//                    isLiked.toggle()
//                    print(isLiked ? "Liked" : "Unliked")
//                }) {
//                    Image(systemName: isLiked ? "heart.fill" : "heart")
//                    Text("Like")
//                }
//                
//                Spacer()
//                
//                Button(action: {
//                    print("Commented on post")
//                }) {
//                    Image(systemName: "bubble.right")
//                    Text("Comment")
//                }
//                
//                Spacer()
//                
//                Button(action: {
//                    print("Shared post")
//                }) {
//                    Image(systemName: "arrowshape.turn.up.right")
//                    Text("Share")
//                }
//            }
//            .font(.system(size: 14))
//            .foregroundColor(.gray)
//        }
//        .padding()
//        .background(Color(#colorLiteral(red: 0.95, green: 0.95, blue: 0.97, alpha: 1)))
//        .cornerRadius(12)
//        .shadow(radius: 4)
//    }
//}
//
//struct CommunityPostCard_Previews: PreviewProvider {
//    static var previews: some View {
//        CommunityPostCard()
//            .previewLayout(.sizeThatFits)
//            .padding()
//    }
//}
