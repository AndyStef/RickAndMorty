//
//  LocationLink.swift
//  Rick&Morty
//
//  Created by Andriy Stefanchuk on 28.06.18.
//  Copyright © 2018 Andriy Stefanchuk. All rights reserved.
//

import Foundation

struct LocationLink: Decodable, URLable {
    let name: String
    let urlString: String

    private enum CodingKeys: String, CodingKey {
        case name
        case urlString = "url"
    }
}
