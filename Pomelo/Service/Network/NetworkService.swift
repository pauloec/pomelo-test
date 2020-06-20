//
//  NetworkService.swift
//  Pomelo
//
//  Created by Paulo Correa on 20/6/20.
//  Copyright © 2020 Pomelo. All rights reserved.
//

import Foundation

import Alamofire
import RxSwift

/**
 Class definition for Requests
*/
class NetworkService {
    // MARK: - List
    static func getVenueList(shopId: String) -> Observable<VenueListModel> {
        return RequestManager.request(Router.getVenueList(shopId: shopId))
    }
}
