//
//  Price.swift
//  WSManager
//
//  Created by datNguyem on 23/11/2021.
//

import Foundation

struct Price: Codable {
    var start: String
    var end: String
    var price: Double
}

extension Price {
    static func dummyDate() -> [Price] {
        return [
            Price(start: "7:00", end: "10:00", price: 120000),
            Price(start: "11:00", end: "15:00", price: 3000000)
        ]
    }
}
