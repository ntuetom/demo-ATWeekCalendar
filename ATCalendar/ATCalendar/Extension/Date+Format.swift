//
//  Date+Format.swift
//  ATCalendar
//
//  Created by Wu hung-yi on 2021/3/6.
//

import Foundation

extension Date {
    var weekDay: Int {
        return Calendar.current.component(.weekday, from: self)-1
    }
    
    var hhmmTime: String {
        let dateFormatter = getDateFormat(format: "HH:mm")
        return dateFormatter.string(from: self)
    }
    
    var ddTime: String {
        let dateFormatter = getDateFormat(format: "dd")
        return dateFormatter.string(from: self)
    }
    
    var yyyyMMddTime: String {
        let dateFormatter = getDateFormat(format: "yyyy/MM/dd")
        return dateFormatter.string(from: self)
    }
    
    var lastDay: Date {
        return getLastDay(of: 1)
    }
    
    fileprivate func getDateFormat(format: String) -> DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter
    }
    
    func getLastDay(of n: Double) -> Date {
        let lastTime: TimeInterval = -(24*60*60)*n
        let lastDate = self.addingTimeInterval(lastTime)
        return lastDate
    }
    
    func getStartOfThisWeek(date: Date) -> Date {
        let calendar = NSCalendar.current
        let components = calendar.dateComponents(
            Set<Calendar.Component>([.yearForWeekOfYear, .weekOfYear]), from: date)
        let startOfWeek = calendar.date(from: components)!
        return startOfWeek
    }
    
}

