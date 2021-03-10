//
//  String+localized.swift
//  ATCalendar
//
//  Created by Wu hung-yi on 2021/3/6.
//

import Foundation

extension String {
    
    var toDate: Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let date = dateFormatter.date(from: self)
        return date!
    }
    
    func toLocalize(tableName: String = "Localizable", paremers: String...) -> String {
        let key = NSLocalizedString(self, tableName: tableName, comment: "")
        return String(format: key, arguments: paremers)
    }
    
}
