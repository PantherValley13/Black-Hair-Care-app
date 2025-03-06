//
//  circular calendar.swift
//  Black Hair Care app
//
//  Created by Darius Church on 3/6/25.
//

import SwiftUI

struct CircularCalendarView: View {
    @State private var currentDate = Date()
    @State private var currentMonth = 0
    
    var body: some View {
        VStack {
            // Month and Year Header
            Text(monthYearFormatter.string(from: currentDate))
                .font(.title)
                .padding()
            
            // Weekday Labels
            HStack {
                ForEach(weekdaySymbols, id: \.self) { day in
                    Text(day)
                        .font(.caption)
                        .frame(maxWidth: .infinity)
                }
            }
            .padding(.horizontal)
            
            // Days Grid
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7), spacing: 10) {
                ForEach(daysInMonth(), id: \.self) { day in
                    if day == 0 {
                        Text("")
                    } else {
                        Circle()
                            .fill(isCurrentDay(day) ? Color.blue : Color.clear)
                            .frame(width: 40, height: 40)
                            .overlay(
                                Text("\(day)")
                                    .foregroundColor(isCurrentDay(day) ? .white : .primary)
                            )
                    }
                }
            }
            .padding()
            
            // Navigation Buttons
            HStack {
                Button(action: { changeMonth(by: -1) }) {
                    Image(systemName: "chevron.left")
                        .padding()
                }
                
                Spacer()
                
                Button(action: { changeMonth(by: 1) }) {
                    Image(systemName: "chevron.right")
                        .padding()
                }
            }
            .padding(.horizontal)
        }
    }
    
    // Helper Functions
    
    private var weekdaySymbols: [String] {
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        return formatter.shortWeekdaySymbols
    }
    
    private var monthYearFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return formatter
    }
    
    private func daysInMonth() -> [Int] {
        let calendar = Calendar.current
        let range = calendar.range(of: .day, in: .month, for: currentDate)!
        let firstDayOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: currentDate))!
        let firstWeekday = calendar.component(.weekday, from: firstDayOfMonth)
        
        var days = Array(repeating: 0, count: firstWeekday - 1)
        days += Array(1..<range.count + 1)
        return days
    }
    
    private func isCurrentDay(_ day: Int) -> Bool {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: currentDate)
        return components.day == day
    }
    
    private func changeMonth(by value: Int) {
        let calendar = Calendar.current
        if let newDate = calendar.date(byAdding: .month, value: value, to: currentDate) {
            currentDate = newDate
        }
    }
}
#Preview {
    
}
