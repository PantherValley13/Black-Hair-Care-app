import SwiftUI
import UIKit

struct CommunityPostCard: View {
    @State private var isLiked: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Image("image-5") // Use "image-5.png"
                    .resizable()
                    .scaledToFill()
                    .frame(width: 40, height: 40)
                    .clipShape(Circle())
                
                Text("Jessica")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(Color.theme.text)
                
                Spacer()
                
                Text("2h ago")
                    .font(.system(size: 14))
                    .foregroundColor(Color.theme.subText)
            }
            
            Text("Check out my new twist-out! Loving these products from the app.")
                .font(.system(size: 14))
                .foregroundColor(Color.theme.text)
            
            Image("image-4") // Keep "image-4"
                .resizable()
                .scaledToFill()
                .frame(height: 160)
                .cornerRadius(12)
            
            HStack {
                Button(action: {
                    isLiked.toggle()
                    print(isLiked ? "Liked" : "Unliked")
                }) {
                    HStack(spacing: 4) {
                        Image(systemName: isLiked ? "heart.fill" : "heart")
                        Text("Like")
                    }
                    .foregroundColor(isLiked ? Color.theme.secondary : Color.theme.subText)
                }
                
                Spacer()
                
                Button(action: {
                    print("Commented on post")
                }) {
                    HStack(spacing: 4) {
                        Image(systemName: "bubble.right")
                        Text("Comment")
                    }
                    .foregroundColor(Color.theme.subText)
                }
                
                Spacer()
                
                // Replace the existing Share button with a share action
                Button(action: sharePost) {
                    HStack(spacing: 4) {
                        Image(systemName: "arrowshape.turn.up.right")
                        Text("Share")
                    }
                    .foregroundColor(Color.theme.subText)
                }
            }
            .font(.system(size: 14))
        }
        .padding(16)
        .background(Color.theme.cardBackground)
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.05), radius: 4, x: 0, y: 2)
    }
    
    // Share Post Function
    private func sharePost() {
        let postText = "Check out my new twist-out! Loving these products from the app."
        let postImage = UIImage(named: "image-4")!
        let activityViewController = UIActivityViewController(
            activityItems: [postText, postImage],
            applicationActivities: nil
        )
        
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let rootViewController = windowScene.windows.first?.rootViewController {
            rootViewController.present(activityViewController, animated: true, completion: nil)
        }
    }
}
#Preview {
}
