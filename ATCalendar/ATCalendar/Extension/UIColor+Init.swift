//
//  String+init.swift
//  ATCalendar
//
//  Created by Wu hung-yi on 2021/3/6.
//

import UIKit

extension UIColor {
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat = 255) {
        self.init(red: r / 255, green: g / 255, blue: b / 255, alpha: a / 255)
    }
}
