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
        static let tickerMock = "https://run.mocky.io/v3/b8dd10d8-260c-4898-a7c4-c420860ef658"
        static let tickerDetailMock = "https://run.mocky.io/v3/e65fd1bc-ac30-494e-9580-e580a899bc67"
        static let tickerIntradayLatestMock = "https://run.mocky.io/v3/c8f88f20-2fbd-460c-af5e-89646ccbda73"
    }
}
