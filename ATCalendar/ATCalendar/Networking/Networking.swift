//
//  Networking.swift
//  ATCalendar
//
//  Created by Wu hung-yi on 2021/3/6.
//

import Foundation

typealias ErrorHandler = (_ error: String) -> Void

protocol GYNetwork_Protocol {
    func request(path: String, onSuccess: (_ data: Data) ->Void, onFailed: ErrorHandler)
}

class Networking: GYNetwork_Protocol {

    let isMock: Bool
    
    init(is_mock: Bool = true) {
        isMock = is_mock
    }
    
    func request(path: String, onSuccess: (_ data: Data) ->Void, onFailed: ErrorHandler) {
        if isMock {
            mockflow(path: path, onSuccess: onSuccess, onFailed: onFailed)
        } else {
            
        }
    }
    
    func mockflow(path: String, onSuccess: (_ data: Data) ->Void, onFailed: ErrorHandler) {
        if let path = Bundle.main.path(forResource: path, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                onSuccess(data)
            } catch let error{
                onFailed(error.localizedDescription)
            }
        } else {
            onFailed("Error: Path Not Found")
        }
    }
    
}
