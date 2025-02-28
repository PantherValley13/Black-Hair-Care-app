import SwiftUI
import AVKit // Import AVKit for video playback

// MARK: - Tutorial Detail View
struct TutorialDetailView: View {
    @State private var isFavorite: Bool = false
    @State private var userRating: Int = 0
    @State private var userComment: String = ""
    @State private var comments: [String] = [
        "This tutorial was amazing!",
        "Very helpful, thank you!",
    ]
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                // MARK: - Video Player
                VideoPlayer(player: AVPlayer(url: URL(string: "https://www.sample-videos.com/video123/mp4/720/big_buck_bunny_720p_1mb.mp4")!))
                    .frame(height: 200)
                    .cornerRadius(12)
                    .padding(.horizontal, 16)
                
                // MARK: - Tutorial Title
                Text("Protective Styles for Natural Hair")
                    .font(.system(size: 24, weight: .bold))
                    .padding(.horizontal, 16)
                
                // MARK: - Tutorial Description
                Text("Learn how to create beautiful protective styles like braids, twists, and updos using natural hair products.")
                    .font(.system(size: 17, weight: .medium))
                    .padding(.horizontal, 16)
                
                // MARK: - Step-by-Step Guide
                Text("Step-by-Step Guide")
                    .font(.system(size: 20, weight: .bold))
                    .padding(.horizontal, 16)
                
                ForEach(1..<6) { step in
                    HStack {
                        Text("Step \(step)")
                            .font(.system(size: 16, weight: .medium))
                        Spacer()
                    }
                    .padding(.horizontal, 16)
                }
                
                // MARK: - Save to Favorites Button
                Button(action: {
                    isFavorite.toggle()
                    print(isFavorite ? "Saved to favorites" : "Removed from favorites")
                }) {
                    Text(isFavorite ? "Remove from Favorites" : "Save to Favorites")
                        .font(.system(size: 16, weight: .medium))
                        .frame(maxWidth: .infinity, minHeight: 40)
                        .background(isFavorite ? Color.red : Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }
                .padding(.horizontal, 16)
                
                // MARK: - Download Resources Button
                Button(action: {
                    print("Downloading resources...")
                }) {
                    Text("Download Resources")
                        .font(.system(size: 16, weight: .medium))
                        .frame(maxWidth: .infinity, minHeight: 40)
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }
                .padding(.horizontal, 16)
                
                // MARK: - User Rating
                Text("Rate this tutorial:")
                    .font(.system(size: 18, weight: .bold))
                    .padding(.horizontal, 16)
                
                HStack {
                    ForEach(1..<6) { star in
                        Button(action: {
                            userRating = star
                        }) {
                            Image(systemName: star <= userRating ? "star.fill" : "star")
                                .foregroundColor(.yellow)
                                .font(.system(size: 24))
                        }
                    }
                }
                .padding(.horizontal, 16)
                
                // MARK: - User Comments
                Text("Comments")
                    .font(.system(size: 18, weight: .bold))
                    .padding(.horizontal, 16)
                
                ForEach(comments, id: \.self) { comment in
                    HStack {
                        Text(comment)
                            .font(.system(size: 14))
                        Spacer()
                    }
                    .padding(.horizontal, 16)
                }
                
                // MARK: - Add Comment
                TextField("Add a comment...", text: $userComment)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal, 16)
                
                Button(action: {
                    if !userComment.isEmpty {
                        comments.append(userComment)
                        userComment = ""
                        print("Comment added")
                    }
                }) {
                    Text("Post Comment")
                        .font(.system(size: 16, weight: .medium))
                        .frame(maxWidth: .infinity, minHeight: 40)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }
                .padding(.horizontal, 16)
            }
            .padding(.vertical, 16)
        }
        .navigationTitle("Tutorial Details")
    }
}

struct TutorialDetailView_Previews: PreviewProvider {
    static var previews: some View {
        TutorialDetailView()
    }
}

#Preview {
    TutorialDetailView()
}
