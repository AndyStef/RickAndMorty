//
//  ApiRouter.swift
//  Rick&Morty
//
//  Created by Andriy Stefanchuk on 28.06.18.
//  Copyright © 2018 Andriy Stefanchuk. All rights reserved.
//

import Alamofire

enum ApiRouter: URLRequestConvertible {
    enum Constatnts {
        static let baseUrlPath = "https://rickandmortyapi.com/api"
        static let timeoutInterval = TimeInterval(10 * 1000)
    }

    case characters
    case locations
    case episodes

    var method: HTTPMethod {
        switch self {
        case .characters, .locations, .episodes:
            return .get
        }
    }

    var path: String {
        switch self {
        case .characters:
            return "/character"
        case .locations:
            return "/location"
        case .episodes:
            return "/episode"
        }
    }

    var parameters: [String: Any] {
        switch self {
        default:
            return [:]
        }
    }

    func asURLRequest() throws -> URLRequest {
        let url = try Constatnts.baseUrlPath.asURL()
        var request = URLRequest(url: url.appendingPathComponent(path))
        request.httpMethod = method.rawValue
        request.timeoutInterval = Constatnts.timeoutInterval

        return try URLEncoding.default.encode(request, with: parameters)
    }
}
