//
//  Path.swift
//  Pomelo
//
//  Created by Paulo Correa on 20/6/20.
//  Copyright © 2020 Pomelo. All rights reserved.
//

import Foundation

/**
 Paths for all requests
 */
struct Path {
    static let apiPath = "https://run.mocky.io/v3/a3c9a434-822c-40db-a778-f8dcd03b0844"
    //static let apiPath = "http://api-staging.pmlo.co/v3"
    
    struct Venue {
        static let list = apiPath + "/pickup-locations"
    }
}
