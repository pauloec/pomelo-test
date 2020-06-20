//
//  RequestManager.swift
//  Pomelo
//
//  Created by Paulo Correa on 20/6/20.
//  Copyright © 2020 Pomelo. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift

class RequestManager {
    
    /// Request
    /// - Parameter urlConvertible: URL for specific request
    /// - Returns: An observable as a result from the response
    static func request<T: Decodable> (_ urlConvertible: URLRequestConvertible) -> Observable<T> {
        let interceptor = Interceptor(retriers: [RetryPolicy(retryLimit: 5)])
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return Observable<T>.create { observer in
            let request = AF.request(urlConvertible, interceptor: interceptor)
                            .validate()
                            .responseDecodable(decoder: decoder, completionHandler: { (response: AFDataResponse<T>) in
                                switch response.result {
                                case .success(let value):
                                    observer.onNext(value)
                                    observer.onCompleted()
                                case .failure(let error):
                                    observer.onError(error)
                                }
                            })

            return Disposables.create {
                request.cancel()
            }
        }
    }
}
