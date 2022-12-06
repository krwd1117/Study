//
//  NetworkManager.swift
//  AlamofireExample
//
//  Created by Jeongwan Kim on 2022/12/06.
//

import Foundation
import Alamofire

class NetworkManager {
    
    private let session: Session = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 10
        configuration.timeoutIntervalForResource = 10
        return Session(configuration: configuration)
    }()
    
    func requestJSON<T: Decodable>(_ url: String,
                                   type: T.Type,
                                   method: HTTPMethod,
                                   parameters: Parameters? = nil) async throws -> T {
      
       return try await session.request(url,
                                       method: method,
                                       parameters: parameters,
                                       encoding: URLEncoding.default)
            .serializingDecodable()
            .value
    }
    
    func get() {
        let url = "https://jsonplaceholder.typicode.com/todos/1"
        AF.request(url,
                                 method: .get,
                                 encoding: URLEncoding.default,
                                 headers: ["Content-Type":"application/json", "Accept":"application/json"]
        ).responseJSON { json in
            print(json)
        }
    }
    
}
