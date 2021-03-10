//
//  Data+Format.swift
//  ATCalendar
//
//  Created by Wu hung-yi on 2021/3/6.
//

import Foundation

extension TimeZone {
    static var offSetFormGMT: String {
        let seconds = TimeZone.current.secondsFromGMT()
        let hours = seconds/3600
        let minutes = abs(seconds/60) % 60
        return String(format: "%+.2d:%.2d", hours, minutes)
    }
    
    static var zoneExpressGMT: String {
        let name = TimeZone.current.localizedName(for: .standard, locale: Locale(identifier: "LOCAL_IDENTIFILER".toLocalize())) ?? ""
        return name + "(" + (TimeZone.current.abbreviation() ?? "") + ")"
    }
}
