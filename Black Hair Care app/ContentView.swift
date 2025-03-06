import SwiftUI
import AVKit // Import AVKit for video playback

struct ContentView: View {
    @State private var isRefreshing = false // State to track refresh status
    @State private var selectedTab = 0 // State to track the selected tab

    var body: some View {
        TabView(selection: $selectedTab) {
            // Home Tab
            NavigationView {
                ScrollView {
                    VStack(spacing: 24) {
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
                        VStack(spacing: 12) {
                            NavigationLink(destination: ProductDetailView()) {
                                Text("Go to Product Detail")
                                    .font(.system(size: 16, weight: .medium))
                                    .frame(maxWidth: .infinity, minHeight: 48)
                                    .background(Color.theme.primary)
                                    .foregroundColor(.white)
                                    .cornerRadius(12)
                            }
                            
                            NavigationLink(destination: TutorialDetailView()) {
                                Text("Go to Tutorial Detail")
                                    .font(.system(size: 16, weight: .medium))
                                    .frame(maxWidth: .infinity, minHeight: 48)
                                    .background(Color.theme.secondary)
                                    .foregroundColor(.white)
                                    .cornerRadius(12)
                            }
                            
                            NavigationLink(destination: CommunityPostDetailView()) {
                                Text("Go to Community Post Detail")
                                    .font(.system(size: 16, weight: .medium))
                                    .frame(maxWidth: .infinity, minHeight: 48)
                                    .background(Color.theme.accent)
                                    .foregroundColor(.white)
                                    .cornerRadius(12)
                            }
                            
                            NavigationLink(destination: UserProfileView()) {
                                Text("Go to User Profile")
                                    .font(.system(size: 16, weight: .medium))
                                    .frame(maxWidth: .infinity, minHeight: 48)
                                    .background(Color.theme.tertiary)
                                    .foregroundColor(.white)
                                    .cornerRadius(12)
                            }
                            
                            // MARK: - Hair Analysis Link
                            NavigationLink(destination: HairAnalysisView()) {
                                Text("Go to Hair Analysis")
                                    .font(.system(size: 16, weight: .medium))
                                    .frame(maxWidth: .infinity, minHeight: 48)
                                    .background(Color.theme.highlight)
                                    .foregroundColor(.white)
                                    .cornerRadius(12)
                            }
                        }
                        .padding(.horizontal, 16)
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 16)
                }
                .refreshable {
                    // Call the refresh function
                    await refreshData()
                }
                .navigationTitle("Your Hair Journey")
                .navigationBarTitleDisplayMode(.large)
                .background(Color.theme.background)
            }
            .tabItem {
                Image(systemName: "house.fill")
                Text("Home")
            }
            .tag(0)

            // Profile Tab
            UserProfileView()
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("Profile")
                }
                .tag(1)

            // Settings Tab
            SettingsView()
                .tabItem {
                    Image(systemName: "gear")
                    Text("Settings")
                }
                .tag(2)
        }
    }

    // Function to simulate refreshing data
    private func refreshData() async {
        isRefreshing = true
        // Simulate a network call or data refresh
        try? await Task.sleep(nanoseconds: 2_000_000_000) // 2 seconds delay
        isRefreshing = false
        print("Data refreshed!")
    }
}

// MARK: - Settings View (Example)


// MARK: - Color Theme Extension
extension Color {
    static let theme = ColorTheme()
}

struct ColorTheme {
    let primary = Color(#colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)) // Purple
    let secondary = Color(#colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)) // Pink
    let accent = Color(#colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666805, alpha: 1)) // Green
    let tertiary = Color(#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)) // Blue
    let highlight = Color(#colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1)) // Orange
    let background = Color(#colorLiteral(red: 0.9725490196, green: 0.9725490196, blue: 0.9803921569, alpha: 1)) // Light Gray
    let cardBackground = Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)) // White
    let text = Color(#colorLiteral(red: 0.1294117647, green: 0.1294117647, blue: 0.1411764706, alpha: 1)) // Dark Gray
    let subText = Color(#colorLiteral(red: 0.5019607843, green: 0.5019607843, blue: 0.5019607843, alpha: 1)) // Medium Gray
}

// MARK: - Hero Section
struct HeroSection: View {
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [Color.theme.primary, Color.theme.secondary]),
                startPoint: .leading,
                endPoint: .trailing
            )
            .frame(height: 140)
            .cornerRadius(16)
            
            Text("Discover Your Perfect Hair Care Routine")
                .font(.system(size: 22, weight: .bold))
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .padding()
        }
    }
}

// MARK: - Hair Type Assessment
struct HairTypeAssessmentSection: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Hair Type Assessment")
                .font(.system(size: 22, weight: .semibold))
                .foregroundColor(Color.theme.text)
            
            Text("Take a quick quiz to find the best products for your hair type.")
                .font(.system(size: 14))
                .foregroundColor(Color.theme.subText)
            
            NavigationLink(destination: HairTypeQuizView()) {
                Text("Start Quiz")
                    .font(.system(size: 16, weight: .medium))
                    .frame(maxWidth: .infinity, minHeight: 48)
                    .background(Color.theme.primary)
                    .foregroundColor(.white)
                    .cornerRadius(12)
            }
        }
    }
}

// MARK: - Product Recommendations
struct ProductRecommendationsSection: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Recommended Products")
                .font(.system(size: 22, weight: .semibold))
                .foregroundColor(Color.theme.text)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(0..<5) { index in
                        ProductCard()
                    }
                }
                .padding(.vertical, 8)
            }
        }
    }
}

struct ProductCard: View {
    @State private var isLiked: Bool = false
    
    var body: some View {
        NavigationLink(destination: ProductDetailView()) {
            VStack(alignment: .leading, spacing: 8) {
                Image("image") // Use "image.png"
                    .resizable()
                    .scaledToFill()
                    .frame(width: 160, height: 160)
                    .cornerRadius(12)
                
                Text("Shea Moisture Shampoo")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(Color.theme.text)
                
                Text("$12.99")
                    .font(.system(size: 14))
                    .foregroundColor(Color.theme.subText)
                
                HStack {
                    Button(action: {
                        isLiked.toggle()
                        print(isLiked ? "Liked" : "Unliked")
                    }) {
                        Image(systemName: isLiked ? "heart.fill" : "heart")
                            .foregroundColor(isLiked ? Color.theme.secondary : Color.theme.subText)
                            .font(.system(size: 20))
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        print("Add to cart")
                    }) {
                        Image(systemName: "cart.badge.plus")
                            .foregroundColor(Color.theme.primary)
                    }
                }
            }
            .frame(width: 160)
            .padding(12)
            .background(Color.theme.cardBackground)
            .cornerRadius(12)
            .shadow(color: Color.black.opacity(0.05), radius: 4, x: 0, y: 2)
        }
        .buttonStyle(PlainButtonStyle()) // Ensures the entire card is tappable without styling issues
    }
}

// MARK: - Tutorial Library
struct TutorialLibrarySection: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Tutorial Library")
                .font(.system(size: 22, weight: .semibold))
                .foregroundColor(Color.theme.text)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(0..<5) { index in
                        TutorialCard(videoURL: URL(string: "https://www.sample-videos.com/video123/mp4/720/big_buck_bunny_720p_1mb.mp4")!)
                    }
                }
                .padding(.vertical, 8)
            }
        }
    }
}

struct TutorialCard: View {
    var videoURL: URL
    @State private var isLiked: Bool = false
    
    var body: some View {
        NavigationLink(destination: TutorialDetailView()) {
            VStack(alignment: .leading, spacing: 0) {
                VideoPlayer(player: AVPlayer(url: videoURL))
                    .frame(width: 180, height: 120)
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
                            .foregroundColor(isLiked ? Color.theme.secondary : .white)
                            .font(.system(size: 20))
                    }
                }
                .padding(8)
            }
            .background(Color.theme.cardBackground)
            .cornerRadius(12)
            .shadow(color: Color.black.opacity(0.05), radius: 4, x: 0, y: 2)
        }
        .buttonStyle(PlainButtonStyle()) // Ensures the entire card is tappable without styling issues
    }
}

// MARK: - Community Feed
struct CommunityFeedSection: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Community Feed")
                .font(.system(size: 22, weight: .semibold))
                .foregroundColor(Color.theme.text)
            
            ForEach(0..<3) { index in
                CommunityPostCard()
                    .padding(.vertical, 4)
            }
        }
    }
}

// MARK: - Preview

#Preview {
    ContentView()
}
