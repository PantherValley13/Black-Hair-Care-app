//
//  HairTypeQuizView.swift
//  Black Hair Care app
//
//  Created by Darius Church on 2/28/25.
//

import SwiftUI

struct HairTypeQuizView: View {
    @State private var currentQuestionIndex: Int = 0
    @State private var selectedAnswer: String? = nil
    @State private var quizResults: [String] = []
    
    // Quiz questions and answers
    let questions = [
        "What is your hair texture?",
        "How often do you wash your hair?",
        "What is your primary hair concern?"
    ]
    
    let answers = [
        ["4A", "4B", "4C", "3C"],
        ["Daily", "Weekly", "Bi-Weekly", "Monthly"],
        ["Dryness", "Breakage", "Frizz", "Scalp Issues"]
    ]
    
    var body: some View {
        VStack(spacing: 20) {
            if currentQuestionIndex < questions.count {
                // Display the current question
                Text(questions[currentQuestionIndex])
                    .font(.system(size: 22, weight: .semibold))
                    .multilineTextAlignment(.center)
                    .padding()
                
                // Display answer options
                ForEach(answers[currentQuestionIndex], id: \.self) { answer in
                    Button(action: {
                        selectedAnswer = answer
                        print("Selected answer: \(answer)")
                    }) {
                        Text(answer)
                            .font(.system(size: 16, weight: .medium))
                            .frame(maxWidth: .infinity, minHeight: 48)
                            .background(selectedAnswer == answer ? Color.blue : Color.gray.opacity(0.2))
                            .foregroundColor(selectedAnswer == answer ? .white : .black)
                            .cornerRadius(12)
                    }
                }
                
                // Next or Finish button
                Button(action: {
                    if let answer = selectedAnswer {
                        quizResults.append(answer)
                        selectedAnswer = nil
                        currentQuestionIndex += 1
                        print("Next question: \(currentQuestionIndex)")
                    }
                }) {
                    Text(currentQuestionIndex == questions.count - 1 ? "Finish" : "Next")
                        .font(.system(size: 16, weight: .medium))
                        .frame(maxWidth: .infinity, minHeight: 48)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }
                .disabled(selectedAnswer == nil)
            } else {
                // Quiz completion screen
                VStack(spacing: 16) {
                    Text("Quiz Complete!")
                        .font(.system(size: 22, weight: .bold))
                    
                    Text("Your recommended hair type is: \(quizResults.joined(separator: ", "))")
                        .font(.system(size: 16))
                        .multilineTextAlignment(.center)
                        .padding()
                    
                    Button(action: {
                        // Reset the quiz
                        currentQuestionIndex = 0
                        quizResults.removeAll()
                        selectedAnswer = nil
                    }) {
                        Text("Restart Quiz")
                            .font(.system(size: 16, weight: .medium))
                            .frame(maxWidth: .infinity, minHeight: 48)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(12)
                    }
                }
            }
        }
        .padding()
        .navigationTitle("Hair Type Quiz")
    }
}

// MARK: - Preview
#Preview {
    HairTypeQuizView()
}
