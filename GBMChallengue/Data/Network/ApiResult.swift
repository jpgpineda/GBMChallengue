//
//  ApiResult.swift
//  GBMChallengue
//
//  Created by javier pineda on 10/10/23.
//

import Foundation

enum ApiResult<T> {
    case success(T)
    case failure(ApiError)
    
    func dematerialize() throws -> T {
        switch self {
        case .success(let value):
            return value
        case .failure(let error):
            return error as! T
        }
    }
}
