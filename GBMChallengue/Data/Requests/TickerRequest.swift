//
//  TickerRequest.swift
//  GBMChallengue
//
//  Created by javier pineda on 10/10/23.
//

import Foundation

struct TickerRequest: ApiRequest {
    var isUnitTest: Bool
    let offset: Int
    var stringUrl: String {
        if isUnitTest {
            return Host.Mock.tickerMock
        } else {
            let url = Host.marketStack + "tickers?access_key=ef4d5df55f0413cbbfc9334f95351573&limit=100&offset=%d"
            return String(format: url, offset)
        }
    }
    
    var apiRequest: URLRequest? {
        guard let formattedUrl = URL(string: stringUrl) else { return nil }
        var request = URLRequest(url: formattedUrl)
        request.httpMethod = HTTPMethod.GET
        return request
    }
    
    init(isUnitTest: Bool? = false,
         offSet: Int? = .zero) {
        self.isUnitTest = isUnitTest ?? false
        self.offset = offSet ?? .zero
    }
}
