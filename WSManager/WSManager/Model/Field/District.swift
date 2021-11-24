//
//  District.swift
//  WSManager
//
//  Created by datNguyem on 22/11/2021.
//

import Foundation

struct District: Codable {
    var id: String
    var name: String
    
    private enum CodingKeys: String, CodingKey {
        case id = "code"
        case name = "name_with_type"
    }
}
