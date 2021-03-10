//
//  CollectionViewCellViewModel.swift
//  ATCalendar
//
//  Created by Wu hung-yi on 2021/3/7.
//

import Foundation

class CollectionViewCellViewModel: NSObject {
    
    let bookingData: WeekDayBookingStatus
    let headerData: HeaderData
    let passed: Bool
    
    init(bookingData: WeekDayBookingStatus, headerData: HeaderData, passed: Bool) {
        self.bookingData = bookingData
        self.headerData = headerData
        self.passed = passed
    }
}
