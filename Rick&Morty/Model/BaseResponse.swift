//
//  BaseResponse.swift
//  Rick&Morty
//
//  Created by Andriy Stefanchuk on 28.06.18.
//  Copyright © 2018 Andriy Stefanchuk. All rights reserved.
//

import Foundation

struct BaseResponse<Type>: Decodable where Type: Decodable {
    let info: PagingInfo
    let results: [Type]

    private enum CodingKeys: String, CodingKey {
        case info
        case results
    }
}

struct PagingInfo: Decodable {
    let generalCount: Int
    let pagesCount: Int
    let nextUrlString: String
    let previousUrlString: String

    private enum CodingKeys: String, CodingKey {
        case generalCount = "count"
        case pagesCount = "pages"
        case nextUrlString = "next"
        case previousUrlString = "prev"
    }
}
