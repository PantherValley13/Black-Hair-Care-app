import SwiftUI

struct OnboardingView: View {
    @State private var currentPage = 0
    @State private var navigateToMainApp = false
    
    // Onboarding content
    let pages = [
        OnboardingPage(
            title: "Hair Care Made Simple",
            description: "Discover personalized routines tailored to your unique hair type.",
            imageName: "figure.hair.salon",
            backgroundColor: Color(hex: "7857FF")
        ),
        OnboardingPage(
            title: "Find Your Hair Type",
            description: "Take our assessment to understand what products actually work for you.",
            imageName: "magnifyingglass",
            backgroundColor: Color(hex: "6040E0")
        ),
        OnboardingPage(
            title: "Learn From Experts",
            description: "Watch tutorials from professionals for any hair style.",
            imageName: "play.circle.fill",
            backgroundColor: Color(hex: "4930C0")
        ),
        OnboardingPage(
            title: "Join Our Community",
            description: "Connect with others and get inspired by real results.",
            imageName: "person.3.fill",
            backgroundColor: Color(hex: "3825A0")
        )
    ]
    
    var body: some View {
        NavigationView {
            ZStack {
                // Background gradient
                LinearGradient(
                    gradient: Gradient(colors: [
                        pages[currentPage].backgroundColor,
                        pages[currentPage].backgroundColor.opacity(0.8),
                        pages[currentPage].backgroundColor.opacity(0.6)
                    ]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                // Decorative elements
                VStack {
                    ZStack {
                        Circle()
                            .fill(Color.white.opacity(0.08))
                            .frame(width: 250, height: 250)
                            .offset(x: 170, y: -80)
                        
                        Circle()
                            .fill(Color.white.opacity(0.05))
                            .frame(width: 200, height: 200)
                            .offset(x: 120, y: -50)
                    }
                    
                    Spacer()
                    
                    ZStack {
                        Circle()
                            .fill(Color.white.opacity(0.05))
                            .frame(width: 250, height: 250)
                            .offset(x: -170, y: 50)
                        
                        Circle()
                            .fill(Color.white.opacity(0.08))
                            .frame(width: 180, height: 180)
                            .offset(x: -150, y: 80)
                    }
                }
                .ignoresSafeArea()
                
                // Main content
                VStack(spacing: 0) {
                    // App logo and skip button
                    HStack {
                        HStack(spacing: 8) {
                            Image(systemName: "scissors")
                                .font(.system(size: 20, weight: .bold))
                                .foregroundColor(.white)
                            
                            Text("HairJourney")
                                .font(.system(size: 24, weight: .bold))
                                .foregroundColor(.white)
                        }
                        .shadow(color: .black.opacity(0.2), radius: 3, x: 1, y: 2)
                        
                        Spacer()
                        
                        if currentPage < pages.count - 1 {
                            Button(action: { navigateToMainApp = true }) {
                                Text("Skip")
                                    .font(.system(size: 16, weight: .medium))
                                    .foregroundColor(.white.opacity(0.8))
                                    .padding(.horizontal, 16)
                                    .padding(.vertical, 8)
                                    .background(Color.white.opacity(0.15))
                                    .cornerRadius(20)
                            }
                        }
                    }
                    .padding(.horizontal, 24)
                    .padding(.top, 60)
                    
                    Spacer()
                    
                    // Image and text content
                    VStack(spacing: 30) {
                        // Page indicator dots (moved to top)
                        HStack(spacing: 8) {
                            ForEach(0..<pages.count, id: \.self) { index in
                                Capsule()
                                    .fill(currentPage == index ? Color.white : Color.white.opacity(0.3))
                                    .frame(width: currentPage == index ? 20 : 8, height: 8)
                                    .animation(.easeInOut(duration: 0.3), value: currentPage)
                            }
                        }
                        .padding(.bottom, 20)
                        
                        ZStack {
                            Circle()
                                .fill(Color.white.opacity(0.15))
                                .frame(width: 160, height: 160)
                                .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 5)
                            
                            Circle()
                                .fill(Color.white.opacity(0.1))
                                .frame(width: 140, height: 140)
                            
                            Image(systemName: pages[currentPage].imageName)
                                .font(.system(size: 70, weight: .light))
                                .foregroundColor(.white)
                        }
                        .padding(.bottom, 30)
                        
                        // Title with decorative element
                        VStack(spacing: 16) {
                            Text(pages[currentPage].title)
                                .font(.system(size: 32, weight: .heavy))
                                .foregroundColor(.white)
                                .shadow(color: .black.opacity(0.15), radius: 2, x: 1, y: 1)
                                .multilineTextAlignment(.center)
                            
                            Rectangle()
                                .fill(Color.white.opacity(0.5))
                                .frame(width: 50, height: 3)
                                .padding(.bottom, 8)
                            
                            Text(pages[currentPage].description)
                                .font(.system(size: 18, weight: .medium))
                                .foregroundColor(.white.opacity(0.9))
                                .multilineTextAlignment(.center)
                                .fixedSize(horizontal: false, vertical: true)
                                .padding(.horizontal, 40)
                        }
                    }
                    .padding(.bottom, 60)
                    
                    // Featured card
                    VStack(alignment: .leading, spacing: 16) {
                        HStack {
                            VStack(alignment: .leading, spacing: 4) {
                                Text("0\(currentPage + 1)")
                                    .font(.system(size: 32, weight: .bold))
                                    .foregroundColor(.black)
                                
                                Text(pageFeatureText(for: currentPage))
                                    .font(.system(size: 22, weight: .semibold))
                                    .foregroundColor(.black)
                            }
                            
                            Spacer()
                            
                            Text("FEATURED")
                                .font(.system(size: 12, weight: .heavy))
                                .foregroundColor(.black.opacity(0.6))
                                .padding(.vertical, 6)
                                .padding(.horizontal, 12)
                                .background(
                                    Capsule()
                                        .fill(Color.black.opacity(0.07))
                                )
                        }
                        
                        // Feature highlight
                        HStack {
                            Text(featureHighlight(for: currentPage))
                                .font(.system(size: 16))
                                .foregroundColor(.black.opacity(0.7))
                                .padding(.bottom, 16)
                            
                            Spacer()
                        }
                        
                        // Navigation buttons
                        HStack(spacing: 16) {
                            if currentPage > 0 {
                                Button(action: {
                                    withAnimation(.easeInOut(duration: 0.3)) {
                                        currentPage -= 1
                                    }
                                }) {
                                    Image(systemName: "arrow.left")
                                        .font(.system(size: 16, weight: .semibold))
                                        .foregroundColor(.black)
                                        .padding(16)
                                        .background(Color.black.opacity(0.05))
                                        .clipShape(Circle())
                                }
                            }
                            
                            Spacer()
                            
                            if currentPage < pages.count - 1 {
                                Button(action: {
                                    withAnimation(.easeInOut(duration: 0.3)) {
                                        currentPage += 1
                                    }
                                }) {
                                    Image(systemName: "arrow.right")
                                        .font(.system(size: 16, weight: .semibold))
                                        .foregroundColor(.white)
                                        .padding(16)
                                        .background(pages[currentPage].backgroundColor)
                                        .clipShape(Circle())
                                        .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 3)
                                }
                            } else {
                                Button(action: {
                                    navigateToMainApp = true
                                }) {
                                    Text("Get Started")
                                        .font(.system(size: 18, weight: .bold))
                                        .foregroundColor(.white)
                                        .frame(maxWidth: .infinity)
                                        .padding(.vertical, 16)
                                        .background(
                                            LinearGradient(
                                                gradient: Gradient(colors: [
                                                    pages[currentPage].backgroundColor,
                                                    pages[currentPage].backgroundColor.opacity(0.8)
                                                ]),
                                                startPoint: .leading,
                                                endPoint: .trailing
                                            )
                                        )
                                        .cornerRadius(25)
                                        .shadow(color: pages[currentPage].backgroundColor.opacity(0.4), radius: 8, x: 0, y: 4)
                                }
                            }
                        }
                    }
                    .padding(30)
                    .background(
                        Color.white
                            .cornerRadius(34, corners: [.topLeft, .topRight])
                            .shadow(color: Color.black.opacity(0.15), radius: 15, x: 0, y: -10)
                    )
                }
                
                // Hidden navigation link
                NavigationLink(
                    destination: ContentView()
                        .navigationBarBackButtonHidden(true),
                    isActive: $navigateToMainApp
                ) {
                    EmptyView()
                }
            }
            .navigationBarHidden(true)
        }
    }
    
    // Helper function to get feature text based on page
    func pageFeatureText(for page: Int) -> String {
        switch page {
        case 0:
            return "Hair-care Discover"
        case 1:
            return "Quiz & Assessment"
        case 2:
            return "Video Tutorials"
        case 3:
            return "Community Connect"
        default:
            return ""
        }
    }
    
    // Helper function to get feature highlight text
    func featureHighlight(for page: Int) -> String {
        switch page {
        case 0:
            return "Find the perfect products and routines for your unique hair type and needs"
        case 1:
            return "Answer a few questions to get personalized recommendations based on science"
        case 2:
            return "Learn professional techniques from certified stylists and hair care experts"
        case 3:
            return "Share your journey and connect with others who have similar hair goals"
        default:
            return ""
        }
    }
}

// MARK: - Helper Extensions

// Extension for Color from hex
extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

// Extension for rounded specific corners
extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}

// Model for onboarding pages
struct OnboardingPage {
    let title: String
    let description: String
    let imageName: String
    let backgroundColor: Color
}

// MARK: - Preview
#Preview {
    OnboardingView()
}
