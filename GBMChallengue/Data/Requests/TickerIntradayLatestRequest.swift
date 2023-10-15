//
//  TickerIntradayLatestRequest.swift
//  GBMChallengue
//
//  Created by javier pineda on 15/10/23.
//

import Foundation

struct TickerIntradayLatestRequest: ApiRequest {
    var isUnitTest: Bool
    let symbol: String
    var stringUrl: String {
        if isUnitTest {
            return Host.Mock.tickerDetailMock
        } else {
            let url = Host.marketStack + "tickers/%@/intraday/latest?access_key=ef4d5df55f0413cbbfc9334f95351573"
            return String(format: url, symbol)
        }
    }
    
    var apiRequest: URLRequest? {
        guard let url = URL(string: stringUrl) else { return nil }
        var apiRequest = URLRequest(url: url)
        apiRequest.httpMethod = HTTPMethod.GET
        return apiRequest
    }
    
    init(isUnitTest: Bool? = false,
         symbol: String? = .empty) {
        self.isUnitTest = isUnitTest ?? false
        self.symbol = symbol ?? .empty
    }
}
