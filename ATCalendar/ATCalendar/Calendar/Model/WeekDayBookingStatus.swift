//
//  WeekDayBookingStatus.swift
//  ATCalendar
//
//  Created by Wu hung-yi on 2021/3/6.
//

import Foundation

class WeekDayBookingStatus {
    let day: WeekdayType
    var availableTime: [Date]
    var bookedTime: [Date]
    var resultTime: [TimeData] = []
    
    var hasTime: Bool {
        return resultTime.count > 0
    }
    
    init(day: WeekdayType, availableTime: [Date], bookedTime: [Date]) {
        self.day = day
        self.availableTime = availableTime
        self.bookedTime = bookedTime
    }
    
    func sortTime() {
        availableTime.forEach {
            resultTime.append(TimeData(time: $0, avalible: true))
        }
        bookedTime.forEach {
            resultTime.append(TimeData(time: $0, avalible: false))
        }
        resultTime = resultTime.sorted {
            $1.time.timeIntervalSince1970 > $0.time.timeIntervalSince1970
        }
    }
    
    func clearData() {
        availableTime.removeAll()
        bookedTime.removeAll()
        resultTime.removeAll()
    }
}

struct TimeData {
    let time: Date
    let avalible: Bool
    
    var expressString: String {
        return time.hhmmTime
    }
}
