//
//  Router.swift
//  Pomelo
//
//  Created by Paulo Correa on 20/6/20.
//  Copyright © 2020 Pomelo. All rights reserved.
//

import Foundation
import Alamofire

/**
 Enum that defines all types of available requests
 */
enum Router: URLRequestConvertible {
    case getVenueList(shopId: String)
    
    //MARK: - Create Request

    /// Returns a request for requestManager
    /// - Throws: Error if encode fails
    /// - Returns: URLRequest if all requirements are given
    func asURLRequest() throws -> URLRequest {
        let url = try path.asURL()
        var urlRequest = URLRequest(url: url)

        urlRequest.httpMethod = method.rawValue

        // Common Headers
        urlRequest.setValue(Request.ContentType.json.rawValue,
                            forHTTPHeaderField: Request.HttpHeaderField.contentType.rawValue)
        
        //Encoding
        let encoding: ParameterEncoding = {
            switch method {
            case .get:
                return URLEncoding.default
            default:
                return JSONEncoding.default
            }
        }()
        
        return try encoding.encode(urlRequest, with: parameters)
    }
}

extension Router {
    /// Keys used in params
    private struct Keys {
        // Shop ID
        static let shopId = "shop_id"
    }
    
    //MARK: - Path
    // The path is the part following the base url
    private var path: String {
        switch self {
        case .getVenueList:
            return Path.Venue.list
        }
    }
    
    private var method: HTTPMethod {
        switch self {
        case .getVenueList:
            return .get
        }
    }
    
    // MARK: - Parameters
    private var parameters: Parameters {
        var params = Parameters()
        
        switch self {
        case .getVenueList(let shopId):
            params[Keys.shopId] = shopId
        }
        
        return params
    }
}
