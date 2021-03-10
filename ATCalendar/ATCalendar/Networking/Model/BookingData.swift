//
//  BookingData.swift
//  ATCalendar
//
//  Created by Wu hung-yi on 2021/3/6.
//

import Foundation

class BookingData: Decodable {
    let available: [TimeFormat]
    let booked: [TimeFormat]
}

class TimeFormat: Decodable {
    let start: String
    let end: String
}
