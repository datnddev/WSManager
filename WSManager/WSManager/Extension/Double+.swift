//
//  String+.swift
//  WSManager
//
//  Created by datNguyem on 23/11/2021.
//

import Foundation
import UIKit

extension Double {
    func convertToVND() -> String? {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "vi_VN")
        formatter.numberStyle = .currency
        return formatter.string(from: self as NSNumber)
    }
}
