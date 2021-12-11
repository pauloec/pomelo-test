//
//  ServiceManager.swift
//  Network
//
//  Created by Paulo Correa on 11/12/2021.
//

import Foundation
import Core

class ServiceManager {
    public static let shared: ServiceManager = ServiceManager()
    public var baseURL: String = "https://45434c1b-1e22-4af2-8c9f-c2d99ffa4896.mock.pstmn.io/v3"
}

extension ServiceManager {
    func sendRequest<T: Codable>(request: RequestModel,
                                 result: PublishBinder<Swift.Result<T, ErrorModel>>) {
        if request.isLoggingEnabled.request {
            LogManager.req(request)
        }

        URLSession.shared.dataTask(with: request.urlRequest()) { data, response, error in
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            guard let data = data,
                  var responseModel = try? decoder.decode(ResponseModel<T>.self, from: data) else {
                      let error: ErrorModel = ErrorModel(ErrorKey.parsing.rawValue)
                      LogManager.err(error)
                      result.onNext(Result.failure(error))
                      return
            }

            responseModel.rawData = data
            responseModel.request = request

            if request.isLoggingEnabled.response {
                LogManager.res(responseModel)
            }

            if responseModel.isSuccess, let data = responseModel.data {
                result.onNext(Result.success(data))
            } else {
                result.onNext(Result.failure(ErrorModel.generalError()))
            }
            
        }.resume()
    }
}
