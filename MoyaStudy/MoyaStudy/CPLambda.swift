//
//  CPLambda.swift
//  MoyaStudy
//
//  Created by 2jw.kim on 2022/11/09.
//

import Foundation

import Moya

enum CPLambda {
    case getData(_ url: String, _ firstName: String? = nil, _ lastName: String? = nil)
}

extension CPLambda: TargetType {
    var baseURL: URL {
        switch self {
        case .getData(let url, _, _):
            let url = URL(string: url)!
            return url
        }
    }
    
    var path: String {
        switch self {
        case .getData(_, _, _):
            return "api/users?page=2"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getData(_, _, _):
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .getData(_, let firstName, let lastName):
            let params: [String: Any] = [
                "firstName": firstName,
                "lastName": lastName
            ]
            return .requestParameters(parameters: params, encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }
}



