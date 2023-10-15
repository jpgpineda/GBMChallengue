//
//  TickerDetail.swift
//  GBMChallengue
//
//  Created by javier pineda on 14/10/23.
//

import Foundation

// MARK: - Welcome
struct TickerIntraday: Codable {
    let pagination: Pagination
    let data: TickerDetail
}

// MARK: - DataClass
struct TickerDetail: Codable {
    let name, symbol: String
    let hasIntraday, hasEOD: Bool
    let country: JSONNull?
    let intraday: [Intraday]

    enum CodingKeys: String, CodingKey {
        case name, symbol
        case hasIntraday = "has_intraday"
        case hasEOD = "has_eod"
        case country, intraday
    }
}

// MARK: - Intraday
struct Intraday: Codable {
    let intradayOpen, high, low: Double
    let last: Double?
    let close: Double?
    let volume: Int?
    let date: Date
    let symbol, exchange: String

    enum CodingKeys: String, CodingKey {
        case intradayOpen = "open"
        case high, low, last, close, volume, date, symbol, exchange
    }
}
