//
//  Episode.swift
//  Rick&Morty
//
//  Created by Andriy Stefanchuk on 28.06.18.
//  Copyright © 2018 Andriy Stefanchuk. All rights reserved.
//

import Foundation

struct Episode: Decodable, URLable {
    let id: String
    let name: String
    let airDate: String
    let code: String
    let characters: [String]
    let created: String
    private (set) let urlString: String

    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case airDate = "air_date"
        case code = "episode"
        case characters
        case created
        case urlString = "url"
    }
}
