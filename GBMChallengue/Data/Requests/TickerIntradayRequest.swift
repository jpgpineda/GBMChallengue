//
//  TickerDetailRequest.swift
//  GBMChallengue
//
//  Created by javier pineda on 14/10/23.
//

import Foundation

struct TickerIntradayRequest: ApiRequest {
    var isUnitTest: Bool
    let symbol: String
    var stringUrl: String {
        if isUnitTest {
            return Host.Mock.tickerDetailMock
        } else {
            let url = Host.marketStack + "tickers/%@/intraday?access_key=ef4d5df55f0413cbbfc9334f95351573&limit=2"
            return String(format: url, symbol)
        }
    }
    
    var apiRequest: URLRequest? {
        guard let url = URL(string: stringUrl) else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.GET
        return request
    }
    
    init(isUnitTest: Bool? = false,
         symbol: String? = .empty) {
        self.isUnitTest = isUnitTest ?? false
        self.symbol = symbol ?? .empty
    }
}
