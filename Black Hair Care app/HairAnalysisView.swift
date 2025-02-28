import SwiftUI

// MARK: - Hair Analysis View
struct HairAnalysisView: View {
    @State private var isAppearing = false
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                // Header Section
                HeaderSection()
                
                // Greeting and Value Proposition
                GreetingSection()
                    .opacity(isAppearing ? 1 : 0)
                    .offset(y: isAppearing ? 0 : 20)
                    .animation(.easeOut(duration: 0.5).delay(0.1), value: isAppearing)
                
                // AI Interaction Section
                AIInteractionSection()
                    .opacity(isAppearing ? 1 : 0)
                    .offset(y: isAppearing ? 0 : 20)
                    .animation(.easeOut(duration: 0.5).delay(0.2), value: isAppearing)
                
                // Hair Analysis Results
                HairAnalysisResultsSection()
                    .opacity(isAppearing ? 1 : 0)
                    .offset(y: isAppearing ? 0 : 20)
                    .animation(.easeOut(duration: 0.5).delay(0.3), value: isAppearing)
                
                // Personalized Recommendations
                PersonalizedRecommendationsSection()
                    .opacity(isAppearing ? 1 : 0)
                    .offset(y: isAppearing ? 0 : 20)
                    .animation(.easeOut(duration: 0.5).delay(0.4), value: isAppearing)
                
                // Bestsellers Section
                BestsellersSection()
                    .opacity(isAppearing ? 1 : 0)
                    .offset(y: isAppearing ? 0 : 20)
                    .animation(.easeOut(duration: 0.5).delay(0.5), value: isAppearing)
                
                // Hair Type and Concerns
                HairTypeAndConcernsSection()
                    .opacity(isAppearing ? 1 : 0)
                    .offset(y: isAppearing ? 0 : 20)
                    .animation(.easeOut(duration: 0.5).delay(0.6), value: isAppearing)
            }
            .padding(.vertical, 24)
            .padding(.horizontal, 16)
        }
        .background(Color(.systemBackground))
        .navigationTitle("Hair Analysis")
        .onAppear {
            withAnimation {
                isAppearing = true
            }
        }
    }
}

// MARK: - Header Section
struct HeaderSection: View {
    var body: some View {
        HStack {
            Text("13:13")
                .font(.caption)
                .foregroundColor(.gray)
            
            Spacer()
            
            Image(systemName: "bell")
                .foregroundColor(.gray)
        }
    }
}

// MARK: - Greeting Section
struct GreetingSection: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Hi Jessica")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Text("Elevate your hair care routine")
                .font(.title2)
                .fontWeight(.medium)
            
            Text("Discover beauty essentials for healthy, glowing hair.")
                .font(.subheadline)
                .foregroundColor(.gray)
        }
    }
}

// MARK: - AI Interaction Section
struct AIInteractionSection: View {
    @State private var isScanning = true
    @State private var isComplete = false
    
    var body: some View {
        VStack(spacing: 16) {
            Text("Use AI to analyze your hair")
                .font(.headline)
            
            if isScanning {
                Text("Scanning your hair...")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .transition(.opacity)
            }
            
            if isComplete {
                Text("The analysis of your hair is complete 😊")
                    .font(.subheadline)
                    .foregroundColor(.green)
                    .transition(.scale.combined(with: .opacity))
            }
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(10)
        .onAppear {
            // Simulate scanning process
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                withAnimation {
                    isScanning = false
                    
                    // Add a small delay before showing completion
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        withAnimation {
                            isComplete = true
                        }
                    }
                }
            }
        }
    }
}

// MARK: - Hair Analysis Results Section
struct HairAnalysisResultsSection: View {
    @State private var showResults = false
    
    var body: some View {
        VStack(spacing: 16) {
            AnalysisResultRow(title: "Moisture Level", value: "76%", delay: 0.1)
            AnalysisResultRow(title: "Scalp Health", value: "58%", delay: 0.2)
            AnalysisResultRow(title: "Strength", value: "87%", delay: 0.3)
            AnalysisResultRow(title: "Split Ends", value: "63%", delay: 0.4)
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(10)
        .onAppear {
            withAnimation(.easeOut(duration: 0.5)) {
                showResults = true
            }
        }
    }
}

struct AnalysisResultRow: View {
    var title: String
    var value: String
    var delay: Double
    
    @State private var showBar = false
    
    private var percentage: Double {
        return Double(value.replacingOccurrences(of: "%", with: "")) ?? 0
    }
    
    var body: some View {
        VStack(spacing: 4) {
            HStack {
                Text(title)
                Spacer()
                Text(value)
                    .fontWeight(.bold)
            }
            
            // Progress bar
            ZStack(alignment: .leading) {
                Rectangle()
                    .frame(height: 8)
                    .foregroundColor(Color(.systemGray5))
                    .cornerRadius(4)
                
                Rectangle()
                    .frame(width: showBar ? CGFloat(percentage / 100) * UIScreen.main.bounds.width * 0.8 : 0, height: 8)
                    .foregroundColor(.blue)
                    .cornerRadius(4)
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                withAnimation(.spring(response: 0.8, dampingFraction: 0.7)) {
                    showBar = true
                }
            }
        }
    }
}

// MARK: - Personalized Recommendations Section
struct PersonalizedRecommendationsSection: View {
    @State private var selectedFilter = "All"
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Personalized recommendations:")
                .font(.headline)
            
            HStack(spacing: 12) {
                FilterButton(title: "All", isSelected: selectedFilter == "All") {
                    withAnimation {
                        selectedFilter = "All"
                    }
                }
                
                FilterButton(title: "Haircare", isSelected: selectedFilter == "Haircare") {
                    withAnimation {
                        selectedFilter = "Haircare"
                    }
                }
                
                FilterButton(title: "Styling", isSelected: selectedFilter == "Styling") {
                    withAnimation {
                        selectedFilter = "Styling"
                    }
                }
            }
            
            Text("Guide to properly washing your hair")
                .font(.subheadline)
                .foregroundColor(.blue)
        }
    }
}

struct FilterButton: View {
    var title: String
    var isSelected: Bool
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.subheadline)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(isSelected ? Color.blue : Color.blue.opacity(0.3))
                .foregroundColor(isSelected ? .white : .blue)
                .cornerRadius(12)
                .animation(.spring(), value: isSelected)
        }
    }
}

// MARK: - Bestsellers Section
struct BestsellersSection: View {
    @State private var hoverItem: Int? = nil
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Bestsellers:")
                .font(.headline)
            
            VStack(alignment: .leading, spacing: 8) {
                bestsellersRow(index: 0, title: "Shea Moisture Shampoo")
                bestsellersRow(index: 1, title: "Cantu Leave-In Conditioner")
            }
            
            Button("View More") { print("View more bestsellers tapped") }
                .font(.subheadline)
                .foregroundColor(.blue)
                .padding(.top, 4)
        }
    }
    
    @ViewBuilder
    private func bestsellersRow(index: Int, title: String) -> some View {
        Text(title)
            .font(.subheadline)
            .padding(.vertical, 8)
            .padding(.horizontal, 12)
            .background(hoverItem == index ? Color(.systemGray5) : Color.clear)
            .cornerRadius(8)
            .onHover { isHovered in
                withAnimation(.easeIn(duration: 0.2)) {
                    hoverItem = isHovered ? index : nil
                }
            }
    }
}

// MARK: - Hair Type and Concerns Section
struct HairTypeAndConcernsSection: View {
    @State private var selectedType: String? = "4A"
    @State private var selectedConcerns = Set<String>()
    
    private let hairTypes = ["4A", "4B", "4C", "3C"]
    private let concerns = ["Dryness", "Breakage"]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Hair Type")
                .font(.headline)
            
            HStack(spacing: 12) {
                ForEach(hairTypes, id: \.self) { type in
                    hairTypeButton(type)
                }
            }
            
            Text("Concerns")
                .font(.headline)
                .padding(.top, 4)
            
            HStack(spacing: 12) {
                ForEach(concerns, id: \.self) { concern in
                    concernButton(concern)
                }
            }
        }
    }
    
    private func hairTypeButton(_ type: String) -> some View {
        Text(type)
            .font(.subheadline)
            .foregroundColor(selectedType == type ? .white : .gray)
            .padding(.horizontal, 12)
            .padding(.vertical, 6)
            .background(selectedType == type ? Color.blue : Color.clear)
            .cornerRadius(8)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.gray.opacity(0.5), lineWidth: selectedType == type ? 0 : 1)
            )
            .onTapGesture {
                withAnimation(.spring()) {
                    selectedType = type
                }
            }
    }
    
    private func concernButton(_ concern: String) -> some View {
        let isSelected = selectedConcerns.contains(concern)
        
        return Text(concern)
            .font(.subheadline)
            .foregroundColor(isSelected ? .white : .gray)
            .padding(.horizontal, 12)
            .padding(.vertical, 6)
            .background(isSelected ? Color.blue : Color.clear)
            .cornerRadius(8)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.gray.opacity(0.5), lineWidth: isSelected ? 0 : 1)
            )
            .onTapGesture {
                withAnimation(.spring()) {
                    if isSelected {
                        selectedConcerns.remove(concern)
                    } else {
                        selectedConcerns.insert(concern)
                    }
                }
            }
    }
}

#Preview {
    HairAnalysisView()
}
