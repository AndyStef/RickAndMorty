//
//  DataResponseError.swift
//  Rick&Morty
//
//  Created by Andriy Stefanchuk on 28.06.18.
//  Copyright © 2018 Andriy Stefanchuk. All rights reserved.
//

import Foundation

enum DataResponseError: Error {
    case network
    case decoding
    case noData

    var reason: String {
        switch self {
        case .network:
            return "An error occurred while fetching data "
        case .decoding:
            return "An error occurred while decoding data"
        case .noData:
            return "An error occurred while getting data"
        }
    }
}
