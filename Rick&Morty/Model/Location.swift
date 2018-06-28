//
//  Location.swift
//  Rick&Morty
//
//  Created by Andriy Stefanchuk on 28.06.18.
//  Copyright © 2018 Andriy Stefanchuk. All rights reserved.
//

import Foundation

struct Location: Decodable, URLable {
    let id: Int
    let name: String
    let type: String
    let dimension: String
    let residents: [String]
    let created: String
    private (set) let urlString: String

    var url: URL? {
        return URL(string: urlString)
    }

    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case type
        case dimension
        case residents
        case created
        case urlString = "url"
    }
}
