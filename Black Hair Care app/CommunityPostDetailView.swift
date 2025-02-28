import SwiftUI
import UIKit

struct CommunityPostDetailView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var isLiked: Bool = false
    @State private var likes: Int = 120
    @State private var comments: [String] = ["This looks amazing!", "Love it!", "Great job!"]
    @State private var newComment: String = ""
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                // Back Button
                BackButton(action: { presentationMode.wrappedValue.dismiss() })
                
                // Post Header
                PostHeader(username: "Jessica", timeAgo: "2h ago", imageName: "image-3")
                
                // Post Content
                PostContent(text: "Check out my new twist-out! Loving these products from the app.", imageName: "image-4")
                
                // Like, Comment, Share Buttons
                ActionButtons(isLiked: $isLiked, likes: $likes, shareAction: sharePost)
                
                // Comments Section
                CommentsSection(comments: $comments, newComment: $newComment)
            }
            .padding(.vertical, 16)
        }
        .navigationTitle("Post Details")
        .navigationBarBackButtonHidden(true)
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

// MARK: - Subviews

struct BackButton: View {
    var action: () -> Void
    
    var body: some View {
        HStack {
            Button(action: action) {
                HStack {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.blue)
                    Text("Back")
                        .foregroundColor(.blue)
                }
            }
            Spacer()
        }
        .padding(.horizontal, 16)
    }
}

struct PostHeader: View {
    var username: String
    var timeAgo: String
    var imageName: String
    
    var body: some View {
        HStack {
            Image(imageName)
                .resizable()
                .scaledToFill()
                .frame(width: 40, height: 40)
                .clipShape(Circle())
            
            VStack(alignment: .leading) {
                Text(username)
                    .font(.headline)
                Text(timeAgo)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            
            Spacer()
        }
        .padding(.horizontal, 16)
    }
}

struct PostContent: View {
    var text: String
    var imageName: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(text)
                .font(.body)
                .lineLimit(nil)
                .fixedSize(horizontal: false, vertical: true)
            
            Image(imageName)
                .resizable()
                .scaledToFill()
                .frame(height: 200)
                .cornerRadius(12)
        }
        .padding(.horizontal, 16)
    }
}

struct ActionButtons: View {
    @Binding var isLiked: Bool
    @Binding var likes: Int
    var shareAction: () -> Void
    
    var body: some View {
        HStack {
            Button(action: {
                isLiked.toggle()
                likes += isLiked ? 1 : -1
            }) {
                HStack {
                    Image(systemName: isLiked ? "heart.fill" : "heart")
                        .foregroundColor(isLiked ? .red : .gray)
                    Text("\(likes)")
                        .foregroundColor(.gray)
                }
            }
            
            Spacer()
            
            Button(action: {}) {
                HStack {
                    Image(systemName: "bubble.right")
                    Text("Comment")
                }
            }
            
            Spacer()
            
            Button(action: shareAction) {
                HStack {
                    Image(systemName: "arrowshape.turn.up.right")
                    Text("Share")
                }
            }
        }
        .font(.subheadline)
        .foregroundColor(.gray)
        .padding(.horizontal, 16)
    }
}

struct CommentsSection: View {
    @Binding var comments: [String]
    @Binding var newComment: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Comments (\(comments.count))")
                .font(.headline)
                .padding(.horizontal, 16)
            
            HStack {
                TextField("Add a comment...", text: $newComment)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .font(.subheadline)
                
                Button(action: {
                    if !newComment.isEmpty {
                        comments.append(newComment)
                        newComment = ""
                    }
                }) {
                    Text("Post")
                        .font(.subheadline)
                        .foregroundColor(.blue)
                }
            }
            .padding(.horizontal, 16)
            
            ForEach(comments, id: \.self) { comment in
                CommentRow(comment: comment, imageName: "image-3")
            }
        }
    }
}

struct CommentRow: View {
    var comment: String
    var imageName: String
    
    var body: some View {
        HStack(alignment: .top) {
            Image(imageName)
                .resizable()
                .scaledToFill()
                .frame(width: 30, height: 30)
                .clipShape(Circle())
            
            VStack(alignment: .leading, spacing: 4) {
                Text("User123")
                    .font(.subheadline)
                    .fontWeight(.medium)
                Text(comment)
                    .font(.subheadline)
            }
            
            Spacer()
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
    }
}

// MARK: - Preview

struct CommunityPostDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CommunityPostDetailView()
    }
}
