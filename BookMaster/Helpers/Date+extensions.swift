//
//  Date+extensions.swift
//  BookMaster
//
//  Created by Максим Шишлов on 02.12.2024.
//

import Foundation

extension Date {
    
    var isToday: Bool {
        Calendar.current.isDateInToday(self)
    }
    
    var isTheSameHour: Bool {
        Calendar.current.compare(self, to: Date(), toGranularity: .hour) == .orderedSame
    }
    
    var isPastDay: Bool {
        Calendar.current.compare(self, to: Date(), toGranularity: .hour) == .orderedAscending
    }
    
    var isFutureDay: Bool {
        Calendar.current.compare(self, to: Date(), toGranularity: .hour) == .orderedDescending
    }
    
    func format(_ format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
    
    func fetchCurrentWeek(_ date: Date = Date()) -> [WeekDay] {
        let calendar = Calendar.current
        let startOfDate = calendar.startOfDay(for: date)
        var week: [WeekDay] = []
        let weekForDate = calendar.dateInterval(of: .weekOfMonth, for: startOfDate)
        
        guard let startOfWeek = weekForDate?.start else { return week }
        
        (0..<7).forEach { index in
            if let weekDayDate = calendar.date(bySetting: .day, value: index, of: startOfWeek) {
                week.append(WeekDay(date: weekDayDate))
            }
        }
        
        return week
    }
    
    func createNextWeek() -> [WeekDay] {
        let calendar = Calendar.current
        let startOfDate = calendar.startOfDay(for: self)
        guard let nextDate = calendar.date(byAdding: .day, value: 1, to: startOfDate) else { return [] }
        return fetchCurrentWeek(nextDate)
    }
    
    func createPrefWeek() -> [WeekDay] {
        let calendar = Calendar.current
        let startOfDate = calendar.startOfDay(for: self)
        guard let prefDate = calendar.date(byAdding: .day, value: -1, to: startOfDate) else { return [] }
        return fetchCurrentWeek(prefDate)
    }
    
    struct WeekDay: Identifiable {
        var id: UUID = .init()
        var date: Date
    }
    
}
