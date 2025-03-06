import SwiftUI

struct OnboardingView: View {
    @State private var currentPage = 0
    @State private var navigateToMainApp = false
    
    // Onboarding content
    let pages = [
        OnboardingPage(
            title: "Welcome to Your Hair Journey",
            description: "Discover personalized hair care routines, products, and tips tailored to your unique hair type.",
            imageName: "figure.hair.salon",
            backgroundColor: Color.blue.opacity(0.7)
        ),
        OnboardingPage(
            title: "Find Your Hair Type",
            description: "Take our assessment to understand your hair type and get recommendations that actually work for you.",
            imageName: "magnifyingglass",
            backgroundColor: Color.purple.opacity(0.7)
        ),
        OnboardingPage(
            title: "Learn From Experts",
            description: "Watch tutorials from professionals and get step-by-step guidance for any hair style.",
            imageName: "play.circle",
            backgroundColor: Color.green.opacity(0.7)
        ),
        OnboardingPage(
            title: "Join Our Community",
            description: "Connect with others, share your progress, and get inspired by real results.",
            imageName: "person.3",
            backgroundColor: Color.orange.opacity(0.7)
        )
    ]
    
    var body: some View {
        NavigationView {
            ZStack {
                // Background gradient
                LinearGradient(
                    gradient: Gradient(colors: [pages[currentPage].backgroundColor, pages[currentPage].backgroundColor.opacity(0.6)]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                // Main content
                VStack {
                    // Page indicator and skip button
                    HStack {
                        PageIndicator(currentPage: currentPage, totalPages: pages.count)
                        
                        Spacer()
                        
                        if currentPage < pages.count - 1 {
                            SkipButton(action: { navigateToMainApp = true })
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top, 30)
                    
                    Spacer()
                    
                    // Image and text content
                    OnboardingContent(page: pages[currentPage])
                    
                    Spacer()
                    
                    // Navigation buttons
                    HStack {
                        if currentPage > 0 {
                            NavigationButton(direction: .previous) {
                                withAnimation(.easeInOut) {
                                    currentPage -= 1
                                }
                            }
                        }
                        
                        Spacer()
                        
                        if currentPage < pages.count - 1 {
                            NavigationButton(direction: .next) {
                                withAnimation(.easeInOut) {
                                    currentPage += 1
                                }
                            }
                        } else {
                            GetStartedButton(backgroundColor: pages[currentPage].backgroundColor) {
                                navigateToMainApp = true
                            }
                        }
                    }
                    .padding(.horizontal, 40)
                    .padding(.bottom, 50)
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
}

// MARK: - Reusable Components

// Page indicator
struct PageIndicator: View {
    let currentPage: Int
    let totalPages: Int
    
    var body: some View {
        HStack {
            ForEach(0..<totalPages, id: \.self) { index in
                Capsule()
                    .fill(currentPage == index ? Color.white : Color.white.opacity(0.3))
                    .frame(width: currentPage == index ? 20 : 10, height: 10)
                    .animation(.easeInOut, value: currentPage)
            }
        }
    }
}

// Skip button
struct SkipButton: View {
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text("Skip")
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(.white)
        }
    }
}

// Onboarding content (image and text)
struct OnboardingContent: View {
    let page: OnboardingPage
    
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: page.imageName)
                .font(.system(size: 120))
                .foregroundColor(.white)
                .padding()
                .background(
                    Circle()
                        .fill(Color.white.opacity(0.2))
                        .frame(width: 200, height: 200)
                )
                .padding(.bottom, 50)
            
            Text(page.title)
                .font(.system(size: 28, weight: .bold))
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
            
            Text(page.description)
                .font(.system(size: 16))
                .foregroundColor(.white.opacity(0.9))
                .multilineTextAlignment(.center)
                .padding(.horizontal, 32)
        }
    }
}

// Navigation buttons (previous/next)
struct NavigationButton: View {
    enum Direction {
        case previous, next
    }
    
    let direction: Direction
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Image(systemName: direction == .previous ? "arrow.left" : "arrow.right")
                .font(.system(size: 20, weight: .semibold))
                .frame(width: 60, height: 60)
                .foregroundColor(.white)
                .background(Color.white.opacity(0.2))
                .clipShape(Circle())
        }
    }
}

// Get Started button
struct GetStartedButton: View {
    let backgroundColor: Color
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text("Get Started")
                .font(.system(size: 18, weight: .semibold))
                .foregroundColor(backgroundColor)
                .frame(width: 200, height: 60)
                .background(Color.white)
                .cornerRadius(30)
                .shadow(radius: 10)
        }
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
