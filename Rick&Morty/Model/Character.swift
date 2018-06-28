//
//  Character.swift
//  Rick&Morty
//
//  Created by Andriy Stefanchuk on 28.06.18.
//  Copyright © 2018 Andriy Stefanchuk. All rights reserved.
//

import Foundation

struct `Character`: Decodable, URLable {
    let id: Int
    let name: String
    let status: CharacterStatus
    let species: String
    let type: String
    let gender: Gender
    let origin: LocationLink
    let location: LocationLink
    let episodes: [String]
    let creationDate: String
    let urlString: String
    private let imageUrlString: String

    var imageUrl: URL? {
        return URL(string: imageUrlString)
    }

    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case status
        case species
        case type
        case gender
        case origin
        case location
        case episodes = "episode"
        case creationDate = "created"
        case urlString = "url"
        case imageUrlString = "image"
    }
}


