import SwiftUI
import AVKit // Import AVKit for video playback

struct ContentView: View {
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 24) { // Increased spacing between sections
                    // MARK: - Hero Section
                    HeroSection()
                    
                    // MARK: - Hair Type Assessment
                    HairTypeAssessmentSection()
                    
                    // MARK: - Product Recommendations
                    ProductRecommendationsSection()
                    
                    // MARK: - Tutorial Library
                    TutorialLibrarySection()
                    
                    // MARK: - Community Feed
                    CommunityFeedSection()
                    
                    // MARK: - Navigation Links to Other Screens
                    VStack(spacing: 12) { // Group navigation links closer together
                        NavigationLink(destination: ProductDetailView()) {
                            Text("Go to Product Detail")
                                .modifier(StandardButtonStyle(backgroundColor: .blue))
                        }
                        
                        NavigationLink(destination: TutorialDetailView()) {
                            Text("Go to Tutorial Detail")
                                .modifier(StandardButtonStyle(backgroundColor: .green))
                        }
                        
                        NavigationLink(destination: CommunityPostDetailView()) {
                            Text("Go to Community Post Detail")
                                .modifier(StandardButtonStyle(backgroundColor: .orange))
                        }
                        
                        NavigationLink(destination: UserProfileView()) {
                            Text("Go to User Profile")
                                .modifier(StandardButtonStyle(backgroundColor: .purple))
                        }
                        
                        NavigationLink(destination: HairAnalysisView()) {
                            Text("Go to Hair Analysis")
                                .modifier(StandardButtonStyle(backgroundColor: .pink))
                        }
                        
                        // MARK: - Add Video Call Navigation Link
                        NavigationLink(destination: VideoCallView()) {
                            Text("Start Video Call")
                                .modifier(StandardButtonStyle(backgroundColor: .red))
                        }
                    }
                    .padding(.horizontal, 16)
                }
                .padding(.horizontal, 20)
            }
            .navigationTitle("Your Hair Journey")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

// MARK: - Standard Button Style
struct StandardButtonStyle: ViewModifier {
    var backgroundColor: Color
    
    func body(content: Content) -> some View {
        content
            .font(.system(size: 16, weight: .medium))
            .frame(maxWidth: .infinity, minHeight: 48)
            .background(backgroundColor)
            .foregroundColor(.white)
            .cornerRadius(12)
    }
}

// MARK: - Hero Section
struct HeroSection: View {
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]), startPoint: .leading, endPoint: .trailing)
                .frame(height: 120)
                .cornerRadius(16)
            
            Text("Discover Your Perfect Hair Care Routine")
                .font(.system(size: 22, weight: .bold))
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .padding()
                .background(Color.black.opacity(0.3)) // Semi-transparent overlay
                .cornerRadius(16)
        }
    }
}

// MARK: - Hair Type Assessment
struct HairTypeAssessmentSection: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Hair Type Assessment")
                .font(.system(size: 22, weight: .semibold))
                .padding(.bottom, 8) // Consistent padding
            
            Text("Take a quick quiz to find the best products for your hair type.")
                .font(.system(size: 14))
                .foregroundColor(.gray)
            
            NavigationLink(destination: HairTypeQuizView()) {
                Text("Start Quiz")
                    .modifier(StandardButtonStyle(backgroundColor: .blue))
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(12)
        .shadow(radius: 5)
    }
}

// MARK: - Product Recommendations
struct ProductRecommendationsSection: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Recommended Products")
                .font(.system(size: 22, weight: .semibold))
                .padding(.bottom, 8) // Consistent padding
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(0..<5) { _ in
                        ProductCard()
                            .frame(width: 160) // Consistent width for all cards
                    }
                }
            }
        }
    }
}

// MARK: - Product Card
struct ProductCard: View {
    @State private var isLiked: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Image("image") // Use "image.png"
                .resizable()
                .scaledToFill()
                .frame(width: 160, height: 160)
                .cornerRadius(12)
            
            Text("Shea Moisture Shampoo")
                .font(.system(size: 16, weight: .medium))
            
            Text("$12.99")
                .font(.system(size: 14))
                .foregroundColor(.gray)
            
            HStack {
                Button(action: {
                    isLiked.toggle()
                    print(isLiked ? "Liked" : "Unliked")
                }) {
                    Image(systemName: isLiked ? "heart.fill" : "heart")
                        .foregroundColor(isLiked ? .red : .gray)
                        .font(.system(size: 20))
                }
                
                Spacer()
                
                Button(action: {
                    print("Add to cart")
                }) {
                    Image(systemName: "cart.badge.plus")
                }
            }
        }
        .frame(width: 160)
    }
}

// MARK: - Tutorial Library
struct TutorialLibrarySection: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Tutorial Library")
                .font(.system(size: 22, weight: .semibold))
                .padding(.bottom, 8) // Consistent padding
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(0..<5) { _ in
                        TutorialCard(videoURL: URL(string: "https://www.sample-videos.com/video123/mp4/720/big_buck_bunny_720p_1mb.mp4")!)
                            .frame(width: 160) // Consistent width for all cards
                    }
                }
            }
        }
    }
}

// MARK: - Tutorial Card
struct TutorialCard: View {
    var videoURL: URL
    @State private var isLiked: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            VideoPlayer(player: AVPlayer(url: videoURL))
                .frame(width: 160, height: 120)
                .cornerRadius(12)
            
            HStack {
                Text("Protective Styles")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.white)
                    .padding(8)
                    .background(Color.black.opacity(0.5))
                    .cornerRadius(8)
                
                Spacer()
                
                Button(action: {
                    isLiked.toggle()
                    print(isLiked ? "Liked" : "Unliked")
                }) {
                    Image(systemName: isLiked ? "heart.fill" : "heart")
                        .foregroundColor(isLiked ? .red : .gray)
                        .font(.system(size: 20))
                }
            }
            .padding(8)
        }
    }
}

// MARK: - Community Feed
struct CommunityFeedSection: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Community Feed")
                .font(.system(size: 22, weight: .semibold))
                .padding(.bottom, 8) // Consistent padding
            
            ForEach(0..<3) { _ in
                CommunityPostCard()
                    .padding(.vertical, 8)
            }
        }
    }
}

// MARK: - Community Post Card
struct CommunityPostCard: View {
    @State private var isLiked: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Image("image-5") // Use "image-5.png"
                    .resizable()
                    .scaledToFill()
                    .frame(width: 40, height: 40)
                    .clipShape(Circle())
                
                Text("Jessica")
                    .font(.system(size: 16, weight: .medium))
                
                Spacer()
                
                Text("2h ago")
                    .font(.system(size: 14))
                    .foregroundColor(.gray)
            }
            
            Text("Check out my new twist-out! Loving these products from the app.")
                .font(.system(size: 14))
            
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
                    Image(systemName: isLiked ? "heart.fill" : "heart")
                    Text("Like")
                }
                
                Spacer()
                
                Button(action: {
                    print("Commented on post")
                }) {
                    Image(systemName: "bubble.right")
                    Text("Comment")
                }
                
                Spacer()
                
                Button(action: {
                    print("Shared post")
                }) {
                    Image(systemName: "arrowshape.turn.up.right")
                    Text("Share")
                }
            }
            .font(.system(size: 14))
            .foregroundColor(.gray)
        }
        .padding()
        .background(Color(#colorLiteral(red: 0.95, green: 0.95, blue: 0.97, alpha: 1)))
        .cornerRadius(12)
    }
}

// MARK: - Preview
#Preview {
    ContentView()
}
