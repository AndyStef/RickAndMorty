//
//  URLable.swift
//  Rick&Morty
//
//  Created by Andriy Stefanchuk on 28.06.18.
//  Copyright © 2018 Andriy Stefanchuk. All rights reserved.
//

import Foundation

protocol URLable {

    var urlString: String { get }
}

extension URLable {
    var url: URL? {
        return URL(string: urlString)
    }
}
