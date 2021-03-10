//
//  FakeAPIManager.swift
//  ATCalendar
//
//  Created by Wu hung-yi on 2021/3/6.
//

import UIKit

protocol BookingDatable: NSObjectProtocol {
    func getBookingData(success: (BookingData) -> Void, fail: ErrorHandler)
}

extension BookingDatable {
    
    func getBookingData(success: (BookingData) -> Void, fail: ErrorHandler) {
        let network: Networking = Networking()
        let path = "FakeBookingData"
        
        network.request(path: path, onSuccess: { data in
            if let jsonObj = try? JSONDecoder().decode(BookingData.self, from: data) {
                success(jsonObj)
            } else {
                fail("JSONDecoder Fail")
            }
        }, onFailed: { error in
            fail(error)
        })
        
    }
}
