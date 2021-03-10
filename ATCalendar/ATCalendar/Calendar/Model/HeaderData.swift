//
//  HeaderData.swift
//  ATCalendar
//
//  Created by Wu hung-yi on 2021/3/7.
//

import Foundation

class HeaderData {
    let day: WeekdayType
    let date: Date
    
    var ddString: String {
        return date.ddTime
    }
    
    var expressionString: String {
        return day.title + "\n" + ddString
    }
    
    init(date: Date) {
        self.date = date
        self.day = WeekdayType.allCases[date.weekDay]
    }
}
