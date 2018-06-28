//
//  Gender.swift
//  Rick&Morty
//
//  Created by Andriy Stefanchuk on 28.06.18.
//  Copyright © 2018 Andriy Stefanchuk. All rights reserved.
//

import Foundation

enum Gender: String, Decodable {
    case male = "Male"
    case female = "Female"
    case genderless = "Genderless"
    case unknown
}
