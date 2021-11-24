//
//  FieldType.swift
//  WSManager
//
//  Created by datNguyem on 22/11/2021.
//

import Foundation

struct FieldType: Codable {
    var id: String
    var type: String
    var icon: String?
}

extension FieldType {
    static func dummyData() -> [FieldType] {
        return [
            FieldType(id: "0", type: "Bóng đá"),
            FieldType(id: "1", type: "Bóng chuyền"),
            FieldType(id: "2", type: "Bóng rổ"),
            FieldType(id: "3", type: "Bóng tennis"),
        ]
    }
}
