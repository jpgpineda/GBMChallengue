//
//  RequestManager.swift
//  GBMChallengue
//
//  Created by javier pineda on 10/10/23.
//

import Foundation

struct HttpCodes {
    static let ok: Int = 200
}

struct HTTPMethod {
    static let GET = "GET"
}

struct Host {
    static let marketStack = "http://api.marketstack.com/v1/"
    struct Mock {
        static let tickerMock = ""
        static let tickerDetailMock = ""
        static let tickerIntradayLatestMock = ""
    }
}
